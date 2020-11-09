//
//  AddRecipeViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class AddRecipeViewController: UIViewController {
    @IBOutlet weak var storeB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelAddingButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
