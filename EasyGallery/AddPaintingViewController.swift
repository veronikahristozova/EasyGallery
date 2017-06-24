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
        
        let painting = Painting(name: nameTextField.text!, pictureURL: pictureURLTextField.text!, author: authorTextField.text!, year: Int(yearTextField.text!)!)
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
