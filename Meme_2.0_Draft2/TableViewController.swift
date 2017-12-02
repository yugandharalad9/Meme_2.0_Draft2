//
//  TableViewController.swift
//  Meme_2.0_Draft2
//
//  Created by Yugandhara Lad on 11/14/17.
//  Copyright © 2017 Yugandhara Lad. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var btnNewMeme: UIBarButtonItem!
    
    //memedImages is the object of type [Meme]
    var memedImages: [Meme]! {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        return appDelegate.memes
    }
    
    //Reload data in the tableview
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        self.tabBarController!.tabBar.isHidden = false
    }
   
    @IBAction func newMemeButtonClicked(_ sender: UIBarButtonItem) {
        
        if let navigationController = navigationController{
            let memeEditorController = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController")
            navigationController.present(memeEditorController!, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memedImages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell", for: indexPath)

        // Configure the cell...
        let memeImages = self.memedImages[indexPath.row]
        
        cell.imageView?.image = memeImages.memedImage
        let memeTopText = memeImages.topText
        let memeBottomText = memeImages.bottomText
        
        cell.textLabel?.text = "\(memeTopText)...\(memeBottomText)"
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailedImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailedMemeViewController") as! DetailedMemeViewController
        
        detailedImageViewController.detailMeme = memedImages[indexPath.row]
        
        //present(detailedImageViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(detailedImageViewController, animated: true)
        
    }
}
