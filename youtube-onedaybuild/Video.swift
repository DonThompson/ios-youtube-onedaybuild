//
//  Video.swift
//  youtube-onedaybuild
//
//  Created by Donald Thompson on 8/17/20.
//  Copyright © 2020 Donald Thompson. All rights reserved.
//

import Foundation

struct Video : Decodable {
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        //Pathing
        case snippet
        case thumbnails
        case high
        case resourceId
        
        //Stuff we want
        case published = "publishedAt"
        case title = "title"
        case description = "description"
        case thumbnail = "url"
        case videoId = "videoId"
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        //Parse snippet level details
        self.title = try snippet.decode(String.self, forKey: .title)
        self.description = try snippet.decode(String.self, forKey: .description)
        self.published = try snippet.decode(Date.self, forKey: .published)
        
        //thumbs
        let thumbs = try snippet.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let high = try thumbs.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try high.decode(String.self, forKey: .thumbnail)
        
        //id
        let resourceId = try snippet.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceId.decode(String.self, forKey: .videoId)
    }
}
