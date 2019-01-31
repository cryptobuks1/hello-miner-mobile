//
//  SiteTableController.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import Foundation
import UIKit

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var SlickBackground: UIImageView!
    
}

class SiteTableController: UITableViewController {
    
    var sites: [Site] = []
    var siteToSend : Site?
    var isLoadingSites = false
    
    @IBOutlet var SiteTable: UITableView!
    
    // MARK: Lifecycle
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set styling
        self.tableView.separatorStyle = .none
        
        // place table view below status bar, cuz I think it's prettier that way
        SiteTable.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 0.0, right: 0.0);
        
        // load up the sites from the API
        self.loadSites()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeadlineTableViewCell
        
        if sites.count >= indexPath.row {
            let siteToShow = sites[indexPath.row]
            cell.Name.text = siteToShow.name
            let hometown =  siteToShow.site_city__c! + ", " + siteToShow.site_state__c!
            cell.Location.text = hometown
            
            let imageName = String(siteToShow.id ?? 1)
            cell.SlickBackground?.image = UIImage(named: imageName)
        }
        
        //Hide until we're ready
        cell.contentView.alpha = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let stagger = 0.5 * Double(indexPath.row)
        
        UIView.animate(withDuration: 0.5, delay: stagger, animations: {
            cell.contentView.alpha = 1
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Manually move to detail view
        siteToSend = sites[indexPath.row]
        performSegue(withIdentifier: "ViewDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if (segue.identifier == "ViewDetail") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! SiteView
            // your new view controller should have property that will store passed value
            viewController.site = siteToSend
        }
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
            self.SiteTable.reloadData()
        }
        
    }
    
    
    //
}
