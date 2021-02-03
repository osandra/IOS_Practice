//
//  SecondTableViewController.swift
//  tabBarPractice
//
//  Created by heawon on 2021/02/03.
//

import UIKit

class SecondTableViewController: UITableViewController {
    let dataObject = ArticleData()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCellIndentifier")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let leftItem = UIBarButtonItem(title: "Articles",
                                           style: .done,
                                           target: nil,
                                           action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ArticleDetailViewController()
        detailVC.titleLabel.text = dataObject.articles[indexPath.row].title
        detailVC.descriptionLabel.text = dataObject.articles[indexPath.row].description
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
//MARK: - Table view data source
extension SecondTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataObject.articles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCellIndentifier", for: indexPath) as! SecondTableViewCell
        
        let data = dataObject.articles[indexPath.row]
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.description
        return cell
    }
}
