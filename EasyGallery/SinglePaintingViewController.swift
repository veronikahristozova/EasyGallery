//
//  SinglePaintingViewController.swift
//  EasyGallery
//
//  Created by Veronika Hristozova on 6/24/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class SinglePaintingViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var paintingImageView: UIImageView!
    
    //MARL: - Variables
    var painting: Painting?
    private var imageDownloadTask: URLSessionDataTask?
    
    //MARK: - Lifecycle Control
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let paintingURL = painting?.pictureURL else { return }
        imageDownloadTask = paintingImageView.downloadImageAsync(contentsOf: paintingURL, saveToCache: imageCache)
        //Faster way: 
        //Painting Image View
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        imageDownloadTask?.cancel()
    }
}
