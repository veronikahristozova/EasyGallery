//
//  PaintingsViewController.swift
//  EasyGallery
//
//  Created by Veronika Hristozova on 6/6/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PaintingsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var paintingsCollectionView: UICollectionView!
    @IBOutlet weak var addPaintingButton: UIBarButtonItem!
    
    //MARK: - Variables
    let ref = Database.database().reference(withPath: "paintings")
    var paintings = [Painting]()
    
    //MARK: - Lifecycle Control
    override func viewDidLoad() {
        super.viewDidLoad()
        if !Preferences.teacher {
            addPaintingButton.isEnabled = false
            addPaintingButton.tintColor = .clear
        }
        ref.observe(.value, with: { snapshot in
            self.paintings.removeAll()
            self.paintingsCollectionView.reloadData()
            for item in snapshot.children {
                let painting = Painting(snapshot: item as! DataSnapshot)
                self.paintings.append(painting)
            }
            self.paintingsCollectionView.reloadData()
        })
    }
}
//MARK: - Collection View DataSourceDelegate
extension PaintingsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paintings.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PaintingCollectionViewCell
        cell.painting = paintings[indexPath.row]
        return cell
    }
}
