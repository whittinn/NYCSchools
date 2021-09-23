//
//  SATDetailViewController.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import UIKit
//I created this view programmatically.
class SATDetailViewController: UIViewController {

    //Created a variable called school of NewYorkSchool.
    var school: NewYorkSchool!
    
    //Created 6 instances of UILabel.
    
    
    let schoolNameLabel = UILabel()
    let numOfTestersLabel = UILabel()
    let criticalReadingScoresLabel = UILabel()
    let mathScoreLabel = UILabel()
    let writingScoreLabel = UILabel()
   
    //Below I created two init methods that both conforms to UIViewControllerDeleget. First init method is for the class that creates an instance of NewYorkSchool.
    init(school: NewYorkSchool) {
        //Reterned a newly inititialed view controller of nil.
        super.init(nibName: nil, bundle: nil)
        //Referring to global varaibale.
        self.school = school
        
    }
    //Second init method for UIViewControllerDelegate.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //If I had more time I would create custom label and set them next to my view objects.
        
        
        //Added functions to view controller.
        configureViewController()
        configureUIElements()
        getSATScores()
    }
    
    private func configureViewController() {
        //Set background to .system Background based environment color.
        view.backgroundColor = .systemBackground
    }
   //Created a function to add labels to the root view and provided them with constriants.
    private func configureUIElements() {
        
        view.addSubview(schoolNameLabel)
        view.addSubview(numOfTestersLabel)
        view.addSubview(criticalReadingScoresLabel)
        view.addSubview(mathScoreLabel)
        view.addSubview(writingScoreLabel)
       
        //Holds onto the autoresize features you want, like flexible height and width.
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        numOfTestersLabel.translatesAutoresizingMaskIntoConstraints = false
        criticalReadingScoresLabel.translatesAutoresizingMaskIntoConstraints = false
        mathScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        writingScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Created a relationship between objects that must be satisfied by constraint layout sytsem.
        NSLayoutConstraint.activate([
            schoolNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            schoolNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            schoolNameLabel.heightAnchor.constraint(equalToConstant: 30), numOfTestersLabel.topAnchor.constraint(equalTo: schoolNameLabel.topAnchor, constant: 50), numOfTestersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),numOfTestersLabel.heightAnchor.constraint(equalToConstant: 20), criticalReadingScoresLabel.topAnchor.constraint(equalTo: numOfTestersLabel.topAnchor, constant: 50),criticalReadingScoresLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),criticalReadingScoresLabel.heightAnchor.constraint(equalToConstant: 20),mathScoreLabel.topAnchor.constraint(equalTo: criticalReadingScoresLabel.topAnchor, constant: 50),mathScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),mathScoreLabel.heightAnchor.constraint(equalToConstant: 20),writingScoreLabel.topAnchor.constraint(equalTo: mathScoreLabel.topAnchor, constant: 50),writingScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),writingScoreLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //Created a function that calls the NetworkManager class that stores our singleton. The singleton calls it's function and take a school.dbn data type. We then capture our reference to the global varible and assign it weak self in a closure to prevent store reference cycles. In the closure, I use a switch statement to check if of data passed.
    func getSATScores() {
        NetworkManager.shared.downloadSAT(for: school.dbn) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let satscore):
                //If success, we will store a instance of our data and add labels to the main thread using GCD.
                DispatchQueue.main.async {
                    self?.configureInformation(satScore: satscore)
                }
            }
        }
    }
    //Here I created a function to create a instance of of data, which will lead to the configuring of each label's text to the represented data pulled from our api.
    private func configureInformation(satScore: SATScore) {
        schoolNameLabel.text = satScore.schoolName
        numOfTestersLabel.text = satScore.numOfSatTestTakers
        criticalReadingScoresLabel.text = satScore.satCriticalReadingAvgScore
        mathScoreLabel.text = satScore.satMathAvgScore
        writingScoreLabel.text = satScore.satWritingAvgScore
        
    
    }

}
