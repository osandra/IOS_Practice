//
//  ViewController.swift
//  memory
//
//  Created by heawon on 2021/01/26.
//

import UIKit
import Foundation
import CoreData

class memoryTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var PersonObject: Person? {
        didSet {
            showMemoryData()
        }
    }
    var memoryArray = [Memory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        showMemoryData()
    }

    @IBAction func addMemory(_ sender: UIBarButtonItem) {
        //MARK: - alert 부분 작성
        var gloabelTextField = UITextField()
        let alert = UIAlertController(title: "Add memories", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addDataAction = UIAlertAction(title: "Add", style: .default) { (action) in
            //유저가 입력한 텍스트를 기반으로 객체 생성
            let memory = Memory(context: self.context)
            memory.text = gloabelTextField.text
            memory.date = Date()
            memory.parentPerson = self.PersonObject
            self.memoryArray.append(memory)
            self.saveData()
        }
        alert.addAction(cancelAction)
        alert.addAction(addDataAction)
        alert.addTextField { (textfield) in
            gloabelTextField = textfield
            gloabelTextField.placeholder = "Make a note of your memories"
        }
       
        present(alert, animated: true, completion: nil)
    }
    
    //데이터에 생긴 변경사항 -> 저장하는 과정을 거쳐야 sqlite에 저장됨
    func saveData(){
        do {
            try context.save()
        } catch {
            print("Can't save data \(error)")
        }
        tableView.reloadData()
    }
    
    //데이터를 요청하고 응답받은 데이터를 리로드하는 함수
    //아무 인자도 전달하지 않으면 기본 값으로 Memory.fetchRequest()가 설정되어서 Memory의 모든 데이터를 불러온다
    //predicate을 전달받으면 해당 필터링을 기존의 필터링(친구이름)에 추가해서 데이터를 보여주겠다.
    func showMemoryData(with request: NSFetchRequest<Memory> = Memory.fetchRequest(), predicate: NSPredicate? = nil){
        let defaultPredicate = NSPredicate(format: "parentPerson.name MATCHES %@", PersonObject!.name!)
        if let getPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [defaultPredicate, getPredicate])
            
        } else {
            request.predicate = defaultPredicate
        }
        //최신순으로 정렬
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            memoryArray = try context.fetch(request)
        } catch {
            print("Can't read data from sqlite \(error)")
        }
        //불러들인 데이터로 테이블 뷰 리로드
        tableView.reloadData()
    }
    //MARK: - tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - data source delegate
extension memoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoryCell", for: indexPath)
        cell.textLabel?.text = memoryArray[indexPath.row].text
        return cell
    }
}

//MARK: - search Bar
extension memoryTableViewController: UISearchBarDelegate {
    //사용자가 입력한 검색어가 Memory 객체의 text필드에 포함되면 해당 메모 보여주기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //쿼리문을 통해 해당 검색어를 포함한 request 보내기
        let request: NSFetchRequest<Memory> = Memory.fetchRequest()
        //[cd]: c-대소문자 구분 없이 d- 발음구별기호에 민감하지 않은
        let searchBarPredicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
        showMemoryData(with: request, predicate: searchBarPredicate)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //사용자가 search bar에 있는 x클릭하면
        if searchText.isEmpty {
            //다시 모든 데이터를 보여주겠다.
            showMemoryData()
            //키보드 닫고, 커서도 취소하겠다. (foreground에서 바로 보여줄 것임)
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
