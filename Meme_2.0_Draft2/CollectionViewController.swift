//
//  CollectionViewController.swift
//  Meme_2.0_Draft2
//
//  Created by Yugandhara Lad on 11/14/17.
//  Copyright © 2017 Yugandhara Lad. All rights reserved.
//

import UIKit



class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var myCollectionView: UICollectionView!
    
   private let reuseIdentifier = "Cell"
    
    var sentMemes: [Meme]! {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        return appDelegate.memes
        
    }

    @IBAction func NewMemeButtonClicked(_ sender: UIBarButtonItem) {
        
        if let navigationController = navigationController {
            let memeEditorController = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController")
            navigationController.present(memeEditorController!, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellSize = CGSize(width: 100, height: 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        myCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myCollectionView.reloadData()
        self.tabBarController!.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sentMemes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustonCollectionViewCell
    
        // Configure the cell
        let memedImagesCollectionView = sentMemes[indexPath.row]
        
        cell.CollectionViewImage?.image = memedImagesCollectionView.memedImage
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //calling VC from stroyboard
        let detailImageVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailedMemeViewController") as! DetailedMemeViewController
        detailImageVC.detailMeme = sentMemes[indexPath.row]
        self.navigationController?.pushViewController(detailImageVC, animated: true)
    }

}


