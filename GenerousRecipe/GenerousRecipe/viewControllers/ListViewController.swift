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
    @IBOutlet weak var searchTF: UITextField!
        
    @IBOutlet weak var searchVBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchVHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sortSC: UISegmentedControl!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var addingB: UIButton!
    
    var searchVIsHidden: Bool!
    var searchVHeight: CGFloat!
    var resiedHeight: CGFloat!
    
    let recipeListViewModel = RecipeViewModel()
    
//Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SearchingView Control
        searchVIsHidden = true
        searchVHeight = searchV.bounds.height
        resiedHeight = searchV.bounds.height  - searchVBottomConstraint.constant - searchTF.bounds.height
        
        changeViewState(isHidden: searchVIsHidden)
        
        // CollectionView UIUpdate
        recipeListViewModel.loadTasks()
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
        print(sortSC.selectedSegmentIndex)
    }
}


//Mark - CollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeListViewModel.numOfSection
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCollectionViewCell", for: indexPath) as? RecipesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        var recipe: Recipe
        if sortSC.selectedSegmentIndex == 0 {
            recipe = recipeListViewModel.allRecipes[indexPath.row]
        } else {
            recipe = recipeListViewModel.favoriteRecipes[indexPath.row]
        }
        
        // ++TODO: todo 를 이용해서 updateUI
        cell.updateUI(recipe: recipe)
        
        return cell
    }
}

