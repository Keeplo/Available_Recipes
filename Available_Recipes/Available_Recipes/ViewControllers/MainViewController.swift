//
//  ViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchV: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var sortSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortSC.selectedSegmentTintColor = UIColor(displayP3Red: 230, green: 108, blue: 65, alpha: 1)
        sortSC.tintColor = UIColor.white
    }

    @IBAction func addRecipeButton(_ sender: Any) {
        print("func addRecipeButton / press AddingRecipeButton")
    }
    @IBAction func searchingRecipeButton(_ sender: Any) {
        print("func searchingRecipeButton / press SearchingRecipeButton")
    }
    // BG 탭했을때, 키보드 내려오게 하기
    @IBAction func tapBG(_ sender: Any) {
        searchTF.resignFirstResponder() // 최고의 관심사가 아니게 된다.
    }
    
    @IBAction func changedSort(_ sender: Any) {
        print("func changedSort / changed Sort Segumented Controler")
        print(sortSC.selectedSegmentIndex)
    }
}

