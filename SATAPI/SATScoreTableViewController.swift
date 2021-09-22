//
//  SATScoreTableViewController.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import UIKit

class SATScoreTableViewController: UITableViewController {

    init () {}

    
    var satScores : [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "SATScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "SATCell")
        getSat()
    }

    func getSat(){
        NetworkManager.shared.downloadSAT{ [weak self] satResponse in

            switch satResponse {
            case .success(let response ):
                print(response)
                self?.satScores = satResponse
            case.failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

        }

    }

  


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return satScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SATCell", for: indexPath) as! SATScoreTableViewCell
        cell.averageMath.text = satScores[indexPath.row]
        cell.averageReading.text = satScores[indexPath.row]
        cell.averageWriting.text = satScores[indexPath.row]
        cell.schoolName.text = satScores[indexPath.row]
        cell.schooltesters.text = satScores[indexPath.row]
        cell.dbnLabel.text = satScores[indexPath.row]
        return cell
    }

  
}
