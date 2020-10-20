//
//  ViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addRecipeButton(_ sender: Any) {
        print("func addRecipeButton / press AddingRecipeButton")
    }
    @IBAction func searchingRecipeButton(_ sender: Any) {
        print("func searchingRecipeButton / press SearchingRecipeButton")
    }
    // BG 탭했을때, 키보드 내려오게 하기
    @IBAction func tapBG(_ sender: Any) {
        searchTextField.resignFirstResponder() // 최고의 관심사가 아니게 된다.
    }
}

