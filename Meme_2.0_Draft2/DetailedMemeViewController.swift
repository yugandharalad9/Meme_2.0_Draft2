//
//  DetailedMemeViewController.swift
//  Meme_2.0_Draft2
//
//  Created by Yugandhara Lad More on 11/16/17.
//  Copyright © 2017 Yugandhara Lad. All rights reserved.
//

import UIKit

class DetailedMemeViewController: UIViewController {

    @IBOutlet weak var detailedImageView: UIImageView!
    
    var detailMeme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        self.detailedImageView.image = detailMeme.memedImage
     
}
    
}
