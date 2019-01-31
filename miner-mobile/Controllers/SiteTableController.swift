//
//  SiteTableController.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import Foundation
import UIKit

class SiteTableController: UITableViewController {
    
    var sites: [Site] = []
    var isLoadingSites = false
    
    @IBOutlet weak var tableview: UITableView?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // place table view below status bar, cuz I think it's prettier that way
        self.tableview?.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0);
        
        // load up the sites from the API
        self.loadSites()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if sites.count >= indexPath.row {
            let siteToShow = sites[indexPath.row]
            cell.textLabel?.text = siteToShow.name
            cell.detailTextLabel?.text = siteToShow.site_city__c
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func loadSites() {
        isLoadingSites = true
        Site.getSites { result in
            if let error = result.error {
                // TODO: improved error handling
                self.isLoadingSites = false
                let alert = UIAlertController(title: "Error", message: "Could not load site :( \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            if let tempSites = result.value as? [Site] {
                for tempSite in tempSites {
                    if (self.sites.append(tempSite)) == nil {
                        self.sites = [tempSite]
                    }
                }
                
            }
            self.isLoadingSites = false
            self.tableview?.reloadData()
        }
        
    }
    
    
    //
}
