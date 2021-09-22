//
//  ViewController.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var schools = [[String : String]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      getSchool()
    }

    //calling http request, loading tableview.
    func getSchool(){
        NetworkManager.shared.downloadNYCSchools{ [weak self] schoolResponse in
         
            switch schoolResponse {
            case .success(let response ):
                print(response)
            case.failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
    }

}

//extension ViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NYCSchoolsTableViewCell
//        cell.schoolLocation.text = schools[indexPath.row].schoolLocation
//        cell.schoolName.text = schools[indexPath.row].schoolName
//        cell.schoolNumber.text = String(schools[indexPath.row].schoolNumber)
//
//        return cell
//    }
//
//
//
//}

