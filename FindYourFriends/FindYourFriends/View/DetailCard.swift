//
//  DetailCard.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 30/09/2020.
//

import Foundation
import UIKit
import MapKit

class DetailCard: UIViewController{
    
    @IBOutlet weak var nomeutente: UILabel!
    @IBOutlet weak var callCTA: UIButton!
    @IBOutlet weak var navigateCTA: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userStreet: UILabel!
    
    var detailData: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeutente.text = detailData?.name
        userStreet.text = detailData?.street
        callCTA.layer.cornerRadius = 25
        navigateCTA.layer.cornerRadius = 25
        
        callCTA.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        navigateCTA.addTarget(self, action: #selector(mapAction), for: .touchUpInside)
        
    }
    
     @objc func callAction(sender: UIButton!) {
        let formattedNumber = detailData?.phone!.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")

        if let url = NSURL(string: ("tel:" + (formattedNumber)!)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
        print("Button tapped")
     }
    
    @objc func mapAction(sender: UIButton!) {
       print("Button tapped")
    }
}
