//
//  Site.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import Foundation
import Alamofire

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

class Site {
    var id: Int?
    var createdbyid : String?
    var sfid : String?
    var site_city__c: String?
    var site_state__c: String?
    var site_country__c: String?
    var name : String?
    var createddate : String?
    var lastmodifieddate : String?
    var ownerid : String?
    var isdeleted : Bool?
    var systemmodstamp : String?
    var site_location__longitude__s : Double?
    var site_location__latitude__s : Double?
    var green_initiatives__c : String?
    var site_description__c : String?
    var _hc_lastop : String?
    var _hc_err : String?
    
    required init(json: [String: Any]) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
    }
    
    class func endpointForSites() -> String {
        return "https://evening-ridge-11930.herokuapp.com/sites/"
    }
    
    private class func siteArrayFromResponse(_ response: DataResponse<Any>) -> Result<[Site]> {
        
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print(response.result.error!)
            return .failure(response.result.error!)
        }
        
        guard let json = response.result.value as? [[String: Any]] else {
            print("Blah. Didn't get Site array as JSON from API")
            return .failure(BackendError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        var allSites: [Site] = []
        
        if let results = json as? [[String: Any]] {
            for siteJson in results {
                let site = Site(json: siteJson)
                allSites.append(site)
            }
        }
        
         return .success(allSites)
        
    }
    
    fileprivate class func getSitesAtPath(_ path: String, completionHandler: @escaping (Result<[Site]>) -> Void) {
        // make sure it's HTTPS because sometimes the API gives us HTTP URLs
        guard var urlComponents = URLComponents(string: path) else {
            let error = BackendError.urlError(reason: "Tried to load an invalid URL")
            completionHandler(.failure(error))
            return
        }
        urlComponents.scheme = "https"
        guard let url = try? urlComponents.asURL() else {
            let error = BackendError.urlError(reason: "Tried to load an invalid URL")
            completionHandler(.failure(error))
            return
        }
        let _ = AF.request(url)
            .responseJSON { response in
                if let error = response.result.error {
                    completionHandler(.failure(error))
                    return
                }
                let siteListResult = Site.siteArrayFromResponse(response)
                completionHandler(siteListResult)
        }
    }
    
    class func getSites(_ completionHandler: @escaping (Result<[Site]>) -> Void) {
        getSitesAtPath(Site.endpointForSites(), completionHandler: completionHandler)
    }
}


