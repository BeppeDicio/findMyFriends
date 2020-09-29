//
//  HomePage.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 27/09/2020.
//

import UIKit

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var friends: [Friend] = []
    @IBOutlet weak var friendsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://jsonplaceholder.typicode.com/users"
        
        let dataReciver: DataReciver = DataReciver()
        
        friends = [Friend]()
        friends = dataReciver.getUserData(urlString: url, context: self)
        
    }
    
    func updateTable(data: [Friend]){
        self.friends = data
        DispatchQueue.main.async{
            self.friendsTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }#imageLiteral(resourceName: "simulator_screenshot_18000366-0E88-4D90-8BCC-B0BEF969042D.png")
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = friends[indexPath.row].name
        
        return cell
    }
}
