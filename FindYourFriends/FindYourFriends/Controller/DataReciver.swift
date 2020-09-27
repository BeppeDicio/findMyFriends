//
//  File.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 27/09/2020.
//

import Foundation

class DataReciver {
    
    public func getUserData(urlString: String){
        
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    private func parse(jsonData: Data){
        
        do {
            let response = try JSONDecoder().decode([User].self, from: jsonData)
            
            for friend in response {
                print("Id: ", friend.id)
                print("Name: ", friend.name)
                print("Email: ", friend.email)
                print("Street: ", friend.address.street)
                print("Suite: ", friend.address.suite)
                print("City: ", friend.address.city)
                print("Zipcode: ", friend.address.zipcode)
                print("Lat: ", friend.address.geo.lat)
                print("Lng: ", friend.address.geo.lng)
                print("Phone: ", friend.phone)
                print("Website: ", friend.website)
                print("Company Name: ", friend.company.name)
                print("Company CatchPhrase: ", friend.company.catchPhrase)
                print("Company Bs: ", friend.company.bs)
                print("===================================")
            }
            
        } catch {
            print("decode error")
        }
    }
}
