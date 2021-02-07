//
//  ViewController.swift
//  collectionView
//
//  Created by heawon on 2021/02/06.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //버튼 누르면 GoToAnotherView segue랑 연결된 뷰로 이동
    @IBAction func GoToAnotherView(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToAnotherView", sender: self)
    }    
}

//MARK: - datasource & delegate
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)") //0부터 시작
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UseData.totalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCollectionCell.identifier, for: indexPath) as! FirstCollectionCell
        cell.imageView.image = UIImage(systemName: UseData.totalData[indexPath.row].ImageName)
        cell.label.text = UseData.totalData[indexPath.row].titleName
        cell.contentView.backgroundColor = UIColor(red: 1.00, green: 0.87, blue: 0.35, alpha: 1.00)
        return cell
    }
}

//MARK: - Flow Layout
//컬렉션 뷰의 아이템 관련 레이아웃 설정
extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    //연속적인 행(아이템) 사이의 최소 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //동일한 행에 있는 아이템들 간의 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    //각 컬렉션의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
}
