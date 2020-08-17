//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by Donald Thompson on 8/17/20.
//  Copyright © 2020 Donald Thompson. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video) {
        self.video = v
        guard self.video != nil else {
            return
        }
        
        //Setup UI elements
        self.titleLabel.text = video?.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        //get the image and set it
        guard self.video!.thumbnail != "" else {
            return
        }
        
        //check cache before downloading
        let cachedData: Data? = CacheManager.getVideoCache(self.video!.thumbnail)
        if(cachedData != nil) {
            self.thumbnailImageView.image = UIImage(data: cachedData!)
            return
        }
        
        let url = URL(string: self.video!.thumbnail)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if(error == nil && data != nil) {
                //save to cache
                CacheManager.setVideoCache(self.video!.thumbnail, data!)
                
                //confirm url match
                if(url!.absoluteString != self.video?.thumbnail) {
                    //video cell recycled and no longer matches
                    return
                }

                //create the image
                let image = UIImage(data: data!)
                
                //set view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                    
                    
                }
            }
        }
        
        //kick off task
        dataTask.resume()
    }

}
