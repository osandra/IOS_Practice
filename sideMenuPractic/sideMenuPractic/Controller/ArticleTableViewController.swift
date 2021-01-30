//
//  ArticleTableViewController.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/28.
//

import UIKit
import SideMenu

class ArticleTableViewController: UITableViewController {
//
//    var ArticleArray = [
//    Article(title: "Lake Canada", articleImageName: "21.jpeg", authorName: "Jonh", authorImageName: "11.jpqg"),
//        Article(title: "Lake New Zealand", articleImageName: "22.jpeg", authorName: "Hellen", authorImageName: "12.jpqg"),
//        Article(title: "Lake AmericaLake America", articleImageName: "23.jpg", authorName: "Nick", authorImageName: "13.jpeg"),
//        Article(title: "Lake Chile", articleImageName: "24.jpeg", authorName: "Brian", authorImageName: "14.jpeg"),
//        Article(title: "Lake Canada", articleImageName: "21.jpeg", authorName: "Jonh", authorImageName: "11.jpqg"),
//        Article(title: "Lake New Zealand", articleImageName: "22.jpeg", authorName: "Hellen", authorImageName: "12.jpqg")
//    ]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "eachContentCell")
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//    }
//
//    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ArticleArray.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "eachContentCell", for: indexPath) as! CustomTableViewCell
//        let data = ArticleArray[indexPath.row]
//        //imageView.image = UIImage(named: 이름)
//        cell.backgroundImage.image =  UIImage(named: data.articleImageName)
//        cell.tilteLabel?.text = data.title
//        cell.authorImage.image = UIImage(named: data.authorImageName)
//        cell.authorName?.text = data.authorName
//        return cell
//    }


}

//
//extension ArticleTableViewController {
//    @IBAction func slideMenuClicked(_ sender: Any) {
//
//        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
//
//        present(menu, animated: true, completion: nil)
//
//    }
//}
