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
    

    
 
    var schools : [NewYorkSchool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSchool()
//Registed our table view cell with the xib file.
        self.tableView.register(UINib(nibName: "NYCSchoolsTableViewCell", bundle: nil), forCellReuseIdentifier: "NYCSchoolsTableViewCell")
//Assigned delegates to view objects for needed functionality.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        

    }
    
  

    //Created a function to that uses the singleton from our NetworkManager to inistiate a call for a http request. We set a reference to our global constant called schools and give it weak self so that we aren't storing a strong reference to it when it isn't needed.
    func getSchool(){
        NetworkManager.shared.downloadNYCSchools{ [weak self] schoolResponse in
//Here we create a switch to check our reference, if it succedd then store it as a constant assign it's value to schools and the tableview is populated. If the reference fails, we print out the error.
            switch schoolResponse {
            case .success(let schools ):
                self?.schools = schools
            case.failure(let error):
                print(error)
            }
            //Good idea to upload table view on main thread.
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

        }

    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Our constant that contains our data returned counted.
        return schools.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Set tableview cell as Xib tableview cell file.
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYCSchoolsTableViewCell", for: indexPath) as! NYCSchoolsTableViewCell
        
        let school = schools[indexPath.row]
        //Called a function to set each cell with an instance of that specific school at indexpath.row.
        cell.set(with: school)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //If I had more time, I would create a UIButton tranistion with a Show segue. Instead, I assigned a show segue to the cell to excuted when the user taps a cell. When is function is excuted, a constant school is created and given the value of schools at it's index.row. The Constant destVC then creates a instance of school, that is shown with the .pushViewController.
        let school = schools[indexPath.row]
        let destVC = SATDetailViewController(school: school)
        navigationController?.pushViewController(destVC, animated: true)
    }
  
}
//Created a searchBar to search for school. If I had more time I would create a function that filters through JSON and returns the correct value.
extension ViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
        tableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            
        }
    }
    
}
    

