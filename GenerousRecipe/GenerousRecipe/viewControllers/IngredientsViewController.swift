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
    
    @IBOutlet weak var searchVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchVHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
        
    var searchVIsHidden: Bool!
    var searchVHeight: CGFloat!
    var resiedHeight: CGFloat!
    
    
//Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVIsHidden = true
        searchVHeight = searchV.bounds.height
        resiedHeight = searchV.bounds.height  - searchVBottomConstraint.constant - searchTF.bounds.height
        
        changeViewState(isHidden: searchVIsHidden)
    }
    
    // Seaching View UIControll
    func changeViewState(isHidden: Bool) {
        isHidden ? hideSearchingView() : AppearSearchingView() }
    func hideSearchingView() {
        //print("before : \(searchV.bounds.height) / resize : \(resiedHeight)")
        searchVHeightConstraint.constant = resiedHeight
        
        searchTF.isHidden = !searchTF.isHidden
        searchTF.isEnabled = !searchTF.isEnabled }
    func AppearSearchingView() {
        searchVHeightConstraint.constant = searchVHeight
        
        searchTF.isHidden = !searchTF.isHidden
        searchTF.isEnabled = !searchTF.isEnabled
    }


//Mark - IBActions
    @IBAction func addRecipeButton(_ sender: Any) {
        print("func addRecipeButton / press AddingRecipeButton")
    }
    @IBAction func searchingRecipeButton(_ sender: Any) {
        searchVIsHidden = !searchVIsHidden
        changeViewState(isHidden: searchVIsHidden)
    }
    // BG 탭했을때, 키보드 내려오게 하기
    @IBAction func tapBG(_ sender: Any) {
        searchTF.resignFirstResponder() // 최고의 관심사가 아니게 된다.
        
        if(!searchVIsHidden) {
            searchVIsHidden = !searchVIsHidden
            changeViewState(isHidden: searchVIsHidden)
        }
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


//Mark - CollectionView DataSource
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

