//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Donald Thompson on 8/17/20.
//  Copyright © 2020 Donald Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        model.delegate = self
        
        model.getVideos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //confirm selection
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        //get ref to video tapped on
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        //get ref to dtl view controller
        let dest = segue.destination as! DetailViewController
        
        //set prop
        dest.video = selectedVideo
    }
    
    // MARK: - Model Delegate Methods
    func videosFetched(_ videos: [Video]) {
        self.videos = videos
        
        //refresh tableview
        tableView.reloadData()
    }

    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        //Configure the cell with any data
        cell.setCell(self.videos[indexPath.row])
        
        //return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
