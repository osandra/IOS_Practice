//
//  CustomViewController.swift
//  collectionView
//
//  Created by heawon on 2021/02/07.
//

import UIKit

class CustomViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        /* --다른 파일.xib에서 만든 CollecitonViewCell 등록--  */
        collectionView.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellWithReuseIdentifier: CustomCollectionCell.identifier)
        //콜렉션 바 밑에 생기는 스크롤 바 없애기
        collectionView.showsHorizontalScrollIndicator = false

        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellWithReuseIdentifier: CustomCollectionCell.identifier)
        secondCollectionView.showsHorizontalScrollIndicator = false
        setFlowLayout() //collectionView, secondCollectionView의 레이아웃 설정하는 함수 호출

    }
    
    @IBAction func goBackBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 콜렉션 뷰 레이아웃 관련 설정
    private func setFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        //스크롤 방향 수평으로 변경 (기본적으로 스크롤 방향 -> 수직으로 설정되어 있음)
        flowLayout.scrollDirection = .horizontal
        //스토리보드에서 collection뷰의  높이 250으로 제한함

        // 콜렉션 뷰가 뷰로부터 얼만큼 떨어지게 위치시킬 것인지
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        // 연속적인 열(아이템) 사이의 최소 간격 설정
        flowLayout.minimumLineSpacing = 5
        
        //각 아이템의 크기를 설정하기 위해 먼저 전체 스크린 너비에서 inset하는 부분(왼쪽: 10, 오른쪽 10)을 제외한다.
        //제외한 남은 공간에서 한 열에 총 2개의 아이템만 보여줄 것이기에 / 2 하고 minimumLineSpacing으로 지정한 간격 빼준다.
        let width = (UIScreen.main.bounds.width - 20) / 2 - 2.5
        flowLayout.itemSize = CGSize(width: width, height: width)
        
        self.collectionView.collectionViewLayout = flowLayout //설정한 레이아웃 적용
        self.secondCollectionView.collectionViewLayout = flowLayout
    }
}

//MARK: - datasource & delegate
extension CustomViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //섹션에 표시할 아이템 수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UseData.totalData.count
    }
    //각 아이템에 표시할 셀 정보 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
            cell.imageView.image = UIImage(systemName: UseData.totalData[indexPath.row].ImageName)
            cell.label.text = UseData.totalData[indexPath.row].titleName
            return cell
        }
        //secondCollectionView일 경우엔 해당 셀로 리턴(지금은 동일한 셀로 테스트 해봄)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
        cell.imageView.image = UIImage(systemName: UseData.totalData[indexPath.row].ImageName)
        cell.imageView.tintColor = .white
        cell.label.text = UseData.totalData[indexPath.row].titleName
        cell.backgroundColor = UIColor(red: 0.99, green: 0.45, blue: 0.45, alpha: 1.00)
        return cell
    }
    //각 아이템을 터치한 경우 실행
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            print("collectionView가 클릭되었음 \(indexPath.row)")
        } else if collectionView == self.secondCollectionView {
            print("secondCollectionView가 클릭되었음 \(indexPath.row)")
        }
    }
}


