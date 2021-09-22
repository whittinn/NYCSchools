//
//  ViewController.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
 
    var schools : [[String:String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSchool()

        self.tableView.register(UINib(nibName: "NYCSchoolTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
       
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        

    }
    
  

    //calling http request, loading tableview.
    func getSchool(){
        NetworkManager.shared.downloadNYCSchools{ [weak self] schoolResponse in

            switch schoolResponse {
            case .success(let response ):
                print(response)
                self?.schools = schoolResponse
            case.failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

        }

    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NYCSchoolsTableViewCell
//        cell.addressLabel.text = schools[indexPath.row][]
//        cell.numberLabel.text = String(schools[indexPath.row][])
//        cell.schoolLabel.text = schools[indexPath.row][]

        return cell
    }
  
}

extension ViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableViewTopConstraint.constant = 0
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        tableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            
        }
    }
    
}
    

