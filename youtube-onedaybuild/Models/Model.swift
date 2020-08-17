//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Donald Thompson on 8/17/20.
//  Copyright © 2020 Donald Thompson. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Model {
    
    var delegate: ModelDelegate?
    
    func getVideos() {
        //create a url object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        //get a urlsession object
        let session = URLSession.shared
        
        //get a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if (error != nil || data == nil) {
                return
            }
            
            do {
                //parse the data
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                //alert the delegate
                if(response.items != nil) {
                    //dispatch to main thread to update table view
                    DispatchQueue.main.async {
                        self.delegate?.videosFetched(response.items!)
                    }
                    
                }
                
            }
            catch {
                //todo
            }
        }
        
        //kick off the task
        dataTask.resume()
    }
}
