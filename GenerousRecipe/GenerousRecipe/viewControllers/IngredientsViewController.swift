//
//  IngredientsViewController.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController {
    @IBOutlet weak var searchV: UIView!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
        
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
        searchTF.resignFirstResponder() // 최고의 관심사가 아니게 된다.
    }
    
    @IBAction func changedSort(_ sender: Any) {
        print("func changedSort / changed Sort Segumented Controler")
        print(sortSC.selectedSegmentIndex)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension IngredientsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsCollectionViewCell", for: indexPath) as? IngredientsCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}

