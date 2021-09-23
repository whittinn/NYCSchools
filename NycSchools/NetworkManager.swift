//
//  NetworkManager.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation

class NetworkManager {
    //Created a singleton to access NetworkManager throughout code(dependency injection is a better solution).
    static let shared = NetworkManager()
    //Denied access to create a new instance of NetworkManager.
    private init () {}
    
    
    //Created a function to store our http request. The completion block captures an escaping closure of Emun Results, with a generic type to store NewYorkSchool that represent an array of NewYorkSchool from our url and protocol Error that provides us with values we can use and a return type of Void.
    func downloadNYCSchools(completion: @escaping (Result<[NewYorkSchool],Error>)->Void){
        
      
        //Guard statement to check if our url is working, if our url is valid we can move onto the next task. If the url failed, we will return a fatalError and our app will iimmediately stop.
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
            fatalError("Error retrieving url")
        }
        //Created an object to form http network request called URLSession that uses a closure to reference data,response,and error in our code. I used a guard statement to unwrap our data into the constant called data, checked so see if we had a response, and also checked to see if there is no error. If all is valid, move to next task. If not, a error message is printed and our completion is called with a value of failure and our error from the closure is printed.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, response != nil, error == nil else {
                print("Error retrieving data")
                completion(.failure(error!))
                
                return
            }
            print("downloaded")
            //We must provide a way for our object above to decode our data type from JSON Object, so we use a do/catch statement to control our object's actions. Used .keydecoding = .convertSnak so exclude snake keys from code.
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
             //Here a constant called school tries to decode an instance of our JSON object agaisnt a try statement. If successful, our data is returned with a value type of success and data is printed.
                let schools = try decoder.decode([NewYorkSchool].self, from: data)
                completion(.success(schools))
                print(schools)
            }catch{
                //If constant schools cannot decode an instance, we return a error of type failure in the completion block.
                print("no data to return")
                completion(.failure(error))
                
            }
        }.resume()
        
    }
    
    //Created a second function that stores a http request. This closure too is out living the function, but it has a parameter of dnb that we will use later for our SATScoreDetail. I also used a custom error to display something different.
    func downloadSAT(for dbn: String, completion: @escaping (Result<SATScore,CustomError>) -> Void){
        
        //Create a guard statement to check url of api. This url uses string interpolation to access different school information based of it's dbn.
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)") else {
            fatalError("Error retrieving URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, response != nil, error == nil else {
                print("Error retrieving data")
                
                //Here I used custom Error to print specific information to user.
                completion(.failure(.unableToGetData))
                print(error)
                return
            }
            print("downloaded")
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let sat = try decoder.decode([SATScore].self, from: data)
                guard let satScore = sat.first else {
                    completion(.failure(.emptySATScore))
                    return
                }
                completion(.success(satScore))
                print(sat)
                
            }catch{
                print("no data to return")
                completion(.failure(.unableToGetData))
                
            }
        }.resume()
        
    }
    
}
