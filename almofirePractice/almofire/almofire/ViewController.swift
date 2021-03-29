//
//  ViewController.swift
//  almofire
//
//  Created by heawon on 2021/03/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    //MARK: - Property
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return collectionView
    }()

    private var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        return activityIndicator
    }()
    
    var imageLink = [String](){
        didSet {
            self.collectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    private func addSubviews(){
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 50, y: view.safeAreaInsets.top+10, width: view.width-100, height: 50)
        collectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+100, width: view.width, height: (view.height-view.safeAreaInsets.top)-100)
    }
    
    //MARK: - Function
    func fetchData(with searchWord: String){
        self.imageLink = []
        APICaller.shared.getPhotoData(term: searchWord) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.updateDate(with: data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateDate(with data: PhotoAPI){
        for result in data.results {
            imageLink.append(result.urlLink.full)
        }
    }
}

//MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageLink.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let urlString = imageLink[indexPath.row]
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            cell.imageView.image=UIImage(data: data)
        }
        return cell
    }
    
    //셀 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-2, height: (view.frame.size.width/2)-2)
    }
    
    //셀  간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
    }
}


//MARK: - Search Bar
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        guard let searchText = searchBar.text, searchText.count > 0 else {return}
        DispatchQueue.main.async { [weak self] in
            self?.fetchData(with: searchText)
            self?.activityIndicator.startAnimating()
        }
    }

    //사용자가 x버튼 누르면
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  searchBar.resignFirstResponder()
              }
          }
    }
}
