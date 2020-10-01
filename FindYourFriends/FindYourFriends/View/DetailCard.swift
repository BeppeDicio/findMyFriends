//
//  DetailCard.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 30/09/2020.
//

import Foundation
import UIKit

class DetailCard: UIViewController{
    
    @IBOutlet weak var nomeutente: UILabel!
    @IBOutlet weak var callCTA: UIButton!
    @IBOutlet weak var navigateCTA: UIButton!
    
    var detailData: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeutente.text = detailData?.name
        
    }
}
