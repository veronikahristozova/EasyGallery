//
//  AddPaintingViewController.swift
//  EasyGallery
//
//  Created by Veronika Hristozova on 6/7/17.
//  Copyright © 2017 Veronika Hristozova. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddPaintingViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var pictureURLTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    //MARK: - Variables
    let ref = Database.database().reference(withPath: "paintings")
    
    //MARK: - IBActions
    @IBAction func didTapAddButton(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let pictureURL = pictureURLTextField.text,
              let author = authorTextField.text,
              let yearInt = yearTextField.text,
              let year = Int(yearInt) else { return }
        
        let painting = Painting(name: name, pictureURL: pictureURL, author: author, year: year)
        let paintingRef = ref.child((nameTextField.text?.lowercased())!)
        paintingRef.setValue(painting.toAnyObject())
        navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
