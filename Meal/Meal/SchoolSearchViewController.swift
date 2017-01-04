//
//  SchoolSearchViewController.swift
//  Meal
//
//  Created by sunrin software10 on 2016. 12. 28..
//  Copyright © 2016년 sunrin software10. All rights reserved.
//

import UIKit
import Alamofire

class SchoolSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var schools: [School] = []
    var didSelectSchool: ((School) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.searchBar)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.contentInset.top = 44
        self.tableView.scrollIndicatorInsets.top = 44
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        self.searchBar.placeholder = "학교 검색"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchBar.frame = CGRect(
            x: 0,
            y: 64,
            width: self.view.frame.size.width,
            height: 44
        )
        self.tableView.frame = self.view.bounds
    }
    
    func searchSchools(query: String) {
        let urlString = "https://schoool.herokuapp.com/school/search"
        let parameters: [String: Any] = [
            "query": query,
        ]
        Alamofire.request(urlString, parameters: parameters).responseJSON {
            response in
            guard let json = response.result.value as? [String: [[String: Any]]],
            let dicts = json["data"]
                else { return }
            self.schools = dicts.flatMap{return School(dictuionary: $0)
            }
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let query = searchBar.text else { return }
        self.searchSchools(query: query)
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
        ) -> Int {
        return self.schools.count
    }
    
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.schools[indexPath.row].name
        let school = self.schools[indexPath.row]
        switch school.type {
        case "초등학교":
            cell.imageView?.image = UIImage(named: "icon_elementary")
        case "중학교":
            cell.imageView?.image = UIImage(named: "icon_middle")
        case "고등학교":
            cell.imageView?.image = UIImage(named: "icon_high")
        default:
            cell.imageView?.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let school = self.schools[indexPath.row]
        self.didSelectSchool?(school)
        self.dismiss(animated: true, completion: nil)
    }
}
