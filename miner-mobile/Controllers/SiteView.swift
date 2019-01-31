//
//  SiteView.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import Foundation
import UIKit

class SiteView: UIViewController {
    
    var site : Site?
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var State: UILabel!
    @IBOutlet weak var Country: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Green: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fill UI with site details
        self.Name.text = site?.name
        self.City.text = site?.site_city__c
        self.State.text = site?.site_state__c
        self.Country.text = site?.site_country__c
        self.Description.text = site?.site_description__c
        self.Green.text = site?.green_initiatives__c
        
    }
}
