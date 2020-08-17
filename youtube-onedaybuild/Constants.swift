//
//  Constants.swift
//  youtube-onedaybuild
//
//  Created by Donald Thompson on 8/17/20.
//  Copyright © 2020 Donald Thompson. All rights reserved.
//

import Foundation

struct Constants {
    
    static var PLAYLIST_ID = "PLMRqhzcHGw1aLoz4pM_Mg2TewmJcMg9ua"
    static var API_URL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(PLAYLIST_ID)&key=\(Secrets.API_KEY)"
}

