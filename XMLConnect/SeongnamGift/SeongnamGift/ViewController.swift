//
//  ViewController.swift
//  SeongnamGift
//
//  Created by heawon on 2021/03/04.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    private var items = [Item]()
    private var CategoryString = String()
    private var NameString = String()
    private var elementName = String()
    private var totalNum: Int = 0

    var pageNum = 1 //처음에 불러올 api 페이지 번호
 
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData(pageNumber: pageNum)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        tableView.rowHeight = 45
    }
    
    func getData(pageNumber: Int){
        let baseURL = "http://apis.data.go.kr/3780000/SeongnamGiftStoreInfoService/getInfolist?serviceKey=\(Constants.secertKey)"
        let subString = "&numOfRows=40&pageNo=\(pageNum)&gu=분당구&dong=정자동".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let URLString = baseURL + subString
        
        let parser = XMLParser(contentsOf: URL(string: URLString)!)
        parser?.delegate = self
        parser?.parse()
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.Name
        return cell
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (items.count)-1 {
            pageNum += 1
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 50)
            if items.count < totalNum { //전체 개수만큼 불러와 지지 않았다면
                getData(pageNumber: pageNum)
                self.tableView.tableFooterView = spinner
                spinner.startAnimating()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                spinner.stopAnimating()
            }
        }
    }
}

extension ViewController {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            CategoryString = ""
            NameString = ""
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (!string.isEmpty) {
            if self.elementName == "val003" {
                CategoryString += string //사용하진 않지만 가져와 지는지 확인해봄
            } else if self.elementName == "val004" {
                NameString += string
            } else if self.elementName == "totalCount" {
                if let totalNumber = Int(string) {
                    totalNum = totalNumber
                }
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let data = Item(Category: CategoryString, Name: NameString)
            items.append(data)
        }
    }
}
