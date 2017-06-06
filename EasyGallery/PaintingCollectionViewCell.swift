//
//  PaintingCollectionViewCell.swift
//  EasyGallery
//
//  Created by Veronika Hristozova on 6/6/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit

class PaintingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var paintingImageView: UIImageView!
    @IBOutlet weak var paintingNameLabel: UILabel!
    @IBOutlet weak var paintingAuthorLabel: UILabel!
    
    var painting: Painting? { didSet { updateUI() } }
    private var imageDownloadTask: URLSessionDataTask?
    
    func updateUI() {
        if let painting = painting {
            imageDownloadTask = paintingImageView.downloadImageAsync(contentsOf: painting.pictureURL, saveToCache: imageCache)
            paintingNameLabel.text = painting.name
            paintingAuthorLabel.text = "by " + painting.author + ", \(painting.year)"
        }
        self.layer.borderWidth  = 1
        self.layer.borderColor  = UIColor.clear.cgColor
        self.layer.cornerRadius = 6
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDownloadTask?.cancel()
    }
}
