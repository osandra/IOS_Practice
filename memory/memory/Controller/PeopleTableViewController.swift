//
//  PeopleTableViewController.swift
//  memory
//
//  Created by heawon on 2021/01/26.
//

import UIKit
import CoreData

class PeopleTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var PeopleList = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    @IBAction func addPerson(_ sender: UIBarButtonItem) {
            //MARK: - alert 부분 작성
            var gloabelTextField = UITextField()
            let alert = UIAlertController(title: "Add Friends", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let addDataAction = UIAlertAction(title: "Add", style: .default) { (action) in
                //유저가 입력한 텍스트를 기반으로 객체 생성
                let person = Person(context: self.context)
                person.name = gloabelTextField.text
                self.PeopleList.append(person)
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
    //MARK: - tableview delegate method
    //유저가 각 셀을 클릭하면 해당 사람에 대한 추억을 작성한 테이블 뷰로 이동
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음 뷰로 이동
        performSegue(withIdentifier: "goToMemory", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //prepare를 통해 다음 테이블 뷰에 객체 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! memoryTableViewController
        if let indexPathValue = tableView.indexPathForSelectedRow {
            destinationVC.PersonObject = PeopleList[indexPathValue.row]
        }
    }
    func showData(){
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            PeopleList = try context.fetch(request)
        } catch {
            print("Can't read data from sqlite \(error)")
        }
        //불러들인 데이터로 테이블 뷰 리로드
        tableView.reloadData()
    }
    
    func saveData(){
        do {
            try context.save()
        } catch {
            print("Can't save data \(error)")
        }
        tableView.reloadData()
    }
    
}

//MARK: - data source delegate
extension PeopleTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PeopleList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = PeopleList[indexPath.row].name
        return cell
    }
}
