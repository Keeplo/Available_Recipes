//
//  BaekViewController.swift
//  Generous_Recipe
//
//  Created by Yongwoo Marco on 2020/10/19.
//

import UIKit

class BaekViewController: UIViewController {

    @IBOutlet weak var searchV: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var sortSC: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
}
