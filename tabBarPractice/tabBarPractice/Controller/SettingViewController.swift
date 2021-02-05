//
//  SettingViewController.swift
//  tabBarPractice
//
//  Created by heawon on 2021/02/05.
//

import UIKit

class SettingViewController: UIViewController {
    //테이블 뷰 선언
    let tableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
      return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource =  self
        //테이블 뷰 가로 라인 지우기
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.backItem?.title = "뒤로"
        navigationController?.navigationBar.tintColor = UIColor.black
    }
}

//MARK: - TableView delegate method
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - TableView datasource
extension SettingViewController: UITableViewDataSource {
    //테이블 뷰의 전체 섹션 수를 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.sections.count
    }

    //각 섹션이 포함하고 있는 아이템 수만큼 각 섹션의 행 수를 지정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Setting.personalItems.count
        } else if section == 1 {
            return Setting.supportItems.count
        } else {
            return Setting.infoItems.count
        }
    }

    //섹션에 대한 헤더 뷰 관련 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        // header 뷰의 배경색 흰색으로 변경
        view.tintColor = .white //헤더 뷰 배경색 흰색으로
        let header = view as! UITableViewHeaderFooterView
        // header 뷰의 섹션 관련 텍스트 라벨 설정을 변경하기
        header.textLabel?.textColor = UIColor.lightGray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        header.textLabel?.textAlignment = .left
    }
    
    //헤더 뷰 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    //긱 헤더 섹션에 표시할 문자열 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Setting.sections[section]
    }
    
    //각 셀에 표시할 데이터 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //nib파일 없이 생성한 테이블 뷰 셀 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        
        //해당 섹션이 0번이면 0번 색션과 관련된 아이템(personalItems)의 값을 리턴
        if indexPath.section == 0 {
            cell.titleLabel.text = Setting.personalItems[indexPath.row]
        }
        else if indexPath.section == 1 {
            cell.titleLabel.text = Setting.supportItems[indexPath.row]
        } else {
            cell.titleLabel.text = Setting.infoItems[indexPath.row]
        }
        // 셀에 > 모양 컨트롤 추가
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
