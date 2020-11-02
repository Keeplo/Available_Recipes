//
//  Recipe.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

struct Recipe: Codable, Equatable {
    var dishName: String
    let image: UIImage
    let IIngredients: [Ingredient] // important ingredients
    let OIngredients: [Ingredient] // optional ingredients
    let steps: [Step]
    var favorite: Bool? = false
    
    func containsAllIngrdients(_ ingredients: [Ingredient]) -> Bool {
        // TODO: 나중에 필터로 재료로 레시피를 찾을때 이용하면 편할 함수입니다.
        return true
    }
    mutating func update() {
        
    }
    ㅂ
    // TODO: json에 저장할떄 이용해주세요.
    var toJSON: [String:Any] {
        return [
            "dishName": String(),
            "importantIngreidients": [String:Any](),
            "optionalIngreidients": [String:Any](),
            "steps": [[String:Any]](),
            "favorite": Bool()
        ]
    }
    
    static func instance(from json: [String:Any]) -> Recipe {
        // JSON에서 객체를 만들떄 써주세요.
        return Recipe(dishName: "", IIngredients: [], OIngredients: [], steps: [], favorite: false)
    }
    
    static func == (leftRecipeName: Self, rightRecipeName: Self) -> Bool {
        // ++TODO: 동등 조건 추가
        return leftRecipeName.dishName == rightRecipeName.dishName
    }
}

class RecipeManager {
    static let shared = RecipeManager()
    static var lastDishName: String = ""
    
    var recipes: [Recipe] = []
    
//    func createRecipe(dishName: String, important: [Ingredient], optional: [Ingredient], steps: [Step], favorite: Bool?) -> Recipe {
//        return Recipe(dishName: dishName, IIngredients: important, OIngredients: [], steps: [], favorite: favorite)
//    }
    
//    func addRecipe(_ recipe: Recipe) {
//        recipes.append(recipe)
//        saveRecipe()
//    }

//    func deleteRecipe(_ recipe: Recipe) {
//        /*if let index = recipes.firstIndex(of recipe) {
//            recipes.remove(at: index)
//        }
//        */
//        Storage.store(recipes, to: .documents, as: "recipes.json")
//    }
    
//    func updateRecipe(_ recipe: Recipe) {
//        guard let index = recipes.firstIndex(of: recipe) else { return }
//        recipes[index].update()
//
//        saveRecipe()
//    }
    
//    func saveRecipe() {
//        Storage.store(recipes, to: .documents, as: "recipes.json")
//    }
    
//    func retrieveRecipe() {
//        recipes = Storage.retrive("recipes.json", from: .documents, as: [Recipe].self) ?? []
//
//        let lastDishName = recipes.last?.dishName ?? ""
//        RecipeManager.lastDishName = lastDishName
//    }
    func retrieveRecipe() {
        recipes = [
            Recipe(dishName: "돼지고기_김치찌개", IIngredients: [Ingredient(name: "김치", amount: 0.150), Ingredient(name: "돼지고기", amount: 0.100)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.05)], steps: [Step(textInstructions: "one"), Step(textInstructions: "two"), Step(textInstructions: "three")], favorite: false),
            Recipe(dishName: "참치_김치찌개", IIngredients: [Ingredient(name: "김치", amount: 0.150), Ingredient(name: "참치", amount: 0.070)], OIngredients: [Ingredient(name: "마늘", amount: 0.020), Ingredient(name: "양파", amount: 0.050)], steps: [Step(textInstructions: "1"), Step(textInstructions: "2"), Step(textInstructions: "3")], favorite: true)
        ]
        
    }
}


class RecipeViewModel {
    enum Section: Int, CaseIterable {
        case favorite
        
        var title: String {
            switch self {
            case .favorite: return "Favorites"
            default: return "All"
            }
        }
    }
    
    private let manager = RecipeManager.shared // 상글톤
    
    var recipes: [Recipe] {
        return manager.recipes
    }
    var allRecipes: [Recipe] {
        return recipes.filter { $0.favorite == false }
    }
    var favoriteRecipes: [Recipe] {
        return recipes.filter { $0.favorite == true }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addRecipe(_ recipe: Recipe) {
        //manager.addRecipe(recipe)
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        //manager.deleteRecipe(recipe)
    }
    
    func updateRecipe(_ recipe: Recipe) {
        //manager.updateRecipe(recipe)
    }
    
    func loadTasks() {
        manager.retrieveRecipe()
    }
}

