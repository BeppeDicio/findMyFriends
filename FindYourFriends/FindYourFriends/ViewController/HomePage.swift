//
//  HomePage.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 27/09/2020.
//

import UIKit
import CoreLocation

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Creation of a my information profile
    //TODO: Creation of an onboarding process to get the data from the user.
    var mydata: Friend = Friend(id: 0,
                                name: "Giuseppe Diciolla",
                                lat: "-1",
                                lng: "-1")
    var friends: [Friend] = []
    var locationManager = CLLocationManager()
    @IBOutlet weak var friendsTV: UITableView!
    
    let coordUtil = CoordinateUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // my data
        mydata.name = "Giuseppe Diciolla"
        mydata.street = "Via molisana 30F 50593 Montecatini"
        mydata.phone = "+39 334 8839405"
        
        // get current position of the user on the moment he open the app
        //TODO: adapt the get location request with the new location privacy guideline of Apple released with iOS 14
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
          currentLoc = locationManager.location
          self.mydata.lat = String(currentLoc.coordinate.latitude)
          self.mydata.lng = String(currentLoc.coordinate.longitude)
          print(currentLoc.coordinate.latitude)
          print(currentLoc.coordinate.longitude)
        }
        
        // Get data from URL and mapp them into a list of Friend Obj
        //TODO: a real Api, that gives you the firend list, and updates when some other friends where added
        let url = "https://jsonplaceholder.typicode.com/users"
        let dataReciver: DataReciver = DataReciver()
        friends = [Friend]()
        dataReciver.getUserData(urlString: url, context: self)
        
        /* ------------------------- SETUP USER PAGE --------------------------- */
    }
    
    func updateTable(data: [Friend]){
        self.friends = data
        friends = friends.sorted { (fr1: Friend, fr2: Friend) -> Bool in
            return fr1.distance < fr2.distance
        }
        DispatchQueue.main.async{
            self.friendsTV.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomFriendTableViewCell
        let friend = friends[indexPath.row]
        
        cell.friendName.text = friend.name
        
        cell.friendDistanceToYou.text = String(format: "%.2f", friend.distance) + " Km"
        
        return cell
    }
}
