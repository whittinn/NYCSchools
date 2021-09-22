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
    func downloadNYCSchools(completion: @escaping (Result<Response,Error>)->Void){
         
         guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
             fatalError("Error retrieving url")
     }
     
     URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data, response != nil, error == nil else {
             print("Error retrieving data")
            
             return
     }
         print("downloaded")
         
         do{
             let decode = JSONDecoder()
             let school = try decode.decode(Response.self, from: data)
            completion(.success(school))
             print(school)
     }catch{
             print("no data to return")
        completion(.failure(error))
       
     }
         
           }.resume()
         
        }
    
//    func downloadSAT(completion: (SAT<Response,Error>) -> Void){
//
//        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
////            fatalError("Error retrieving URL")
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data, response != nil, error == nil else {
//                print("Error retrieving data")
//                completion([])
//                return
//            }
//            print("downloaded")
//            do{
//                let decode = JSONDecoder()
//                let sat = try decode.decode(SATScore.self, from: data)
//                print(sat)
//
//            }catch{
//                print("no data to return")
//                completion([])
//
//            }
//        }.resume()
//
//    }

}
