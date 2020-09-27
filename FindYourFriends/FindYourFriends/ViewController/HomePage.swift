//
//  HomePage.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 27/09/2020.
//

import UIKit

class HomePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://jsonplaceholder.typicode.com/users"
        
        let dataReciver: DataReciver = DataReciver()
        dataReciver.getUserData(urlString: url)
        
    }
}
