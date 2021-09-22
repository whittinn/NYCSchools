//
//  NetworkManager.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import Foundation

class NetworkManager {
    //Created a singleton.
    static let shared = NetworkManager()
    //no access
    private init () {}
    
    
    //Creating a http request.
    func downloadNYCSchools(completion: @escaping (Result<NewYorkSchools,Error>)->Void){
         
         guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
             fatalError("Error retrieving url")
     }
     
     URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data, response != nil, error == nil else {
             print("Error retrieving data")
            completion(.failure(error!))
            
             return
     }
         print("downloaded")
         
         do{
             let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
             let schools = try decoder.decode([School].self, from: data)
         completion(.success(schools))
             print(schools)
     }catch{
             print("no data to return")
        completion(.failure(error))
       
     }
         
           }.resume()
         
        }
    
    func downloadSAT(completion: @escaping (Result<SATScore,Error>) -> Void){

        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=") else {
            fatalError("Error retrieving URL")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, response != nil, error == nil else {
                print("Error retrieving data")
                completion(.failure(error!))
                print(error)
                return
            }
            print("downloaded")
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let sat = try decoder.decode(SATScore.self, from: data)
                completion(.success(sat))
                print(sat)

            }catch{
                print("no data to return")
                completion(.failure(error))

            }
        }.resume()

    }

}
