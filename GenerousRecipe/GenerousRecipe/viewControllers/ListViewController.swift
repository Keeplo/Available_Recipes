//
//  ViewController.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var searchV: UIView!
    @IBOutlet weak var searchVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTF: UITextField!
        
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
    
    var searchVIsHidden: Bool!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVIsHidden = false
        changeViewState(isHidden: searchVIsHidden)
    }
    
    func changeViewState(isHidden: Bool) {
        isHidden ? AppearSearchingView() : hideSearchingView()
    }
    
    func hideSearchingView() {
        let resiedHeight = searchV.bounds.height  - searchVBottomConstraint.constant - searchTF.bounds.height
        print("before : \(searchV.bounds.height) / resize : \(resiedHeight)")
        
        searchV.sizeThatFits(CGSize(width: searchV.bounds.width, height: resiedHeight))
        self.resignFirstResponder()
        print(searchV.frame)
        
        searchTF.isHidden = !searchTF.isHidden
        searchTF.isEnabled = !searchTF.isEnabled
    }
    func AppearSearchingView() {
        let resiedHeight = searchV.bounds.height  + searchVBottomConstraint.constant + searchTF.bounds.height
        print("before : \(searchV.bounds.height) / resize : \(resiedHeight)")
        
        searchV. = CGFloat(resiedHeight)
        searchV.sizeToFit()
        print(searchV.frame)
        
        searchTF.isHidden = !searchTF.isHidden
        searchTF.isEnabled = !searchTF.isEnabled
    }

    @IBAction func addRecipeButton(_ sender: Any) {
        print("func addRecipeButton / press AddingRecipeButton")
    }
    @IBAction func searchingRecipeButton(_ sender: Any) {
        print("func searchingRecipeButton / press SearchingRecipeButton")
        searchVIsHidden = (searchVIsHidden ? false : true)
        changeViewState(isHidden: searchVIsHidden)
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

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCollectionViewCell", for: indexPath) as? RecipesCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

