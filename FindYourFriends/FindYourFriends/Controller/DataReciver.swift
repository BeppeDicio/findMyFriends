//
//  File.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 27/09/2020.
//

import Foundation

class DataReciver {
    
    public func getUserData(urlString: String, context: HomePage) -> [Friend]{
        
        var friends = [Friend]()
        
        self.loadJson(fromURLString: urlString) { (result) in
            switch result {
            case .success(let data):
                friends = self.parse(jsonData: data, context: context)
            case .failure(let error):
                print(error)
            }
        }
        
        return friends
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
    
    private func parse(jsonData: Data, context:HomePage) -> [Friend]{
        
        var friends = [Friend]()
        
        do { 
            let response = try JSONDecoder().decode([User].self, from: jsonData)
            
            for friend in response {
                
                let frnd = Friend(id: friend.id,
                                  name: friend.name,
                                  lat: friend.address.geo.lat,
                                  lng: friend.address.geo.lng)
                
                frnd.email = friend.email
                frnd.street = friend.address.street
                frnd.suite = friend.address.suite
                frnd.city = friend.address.city
                frnd.zipcode = friend.address.zipcode
                frnd.phone = friend.phone
                frnd.website = friend.website
                frnd.companyName = friend.company.name
                frnd.companyCatchPhrase = friend.company.catchPhrase
                frnd.companyBs = friend.company.bs
                
                friends.append(frnd)
            }
            
        } catch {
            print("decode error")
        }
        
        context.updateTable(data: friends)
        
        return friends
    }
}
