//
//  Recipe.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

// 11.13 / 추천 구현

struct Recipe: Codable, Equatable {
    var dishName: String
    let thumbnail: ImageData?
    let IIngredients: [Ingredient] // important ingredients
    let OIngredients: [Ingredient] // optional ingredients
    let steps: [Step]
    var favorite: Bool = false
    var section: Styles = .nokind
    
    mutating func containsAllIngrdients(_ important: [String], _ optional: [String]) {
        // 가지고 있는 량은 측정 불가
    }
    mutating func update() {
        
    }
    
    // TODO: json에 저장할떄 이용해주세요.
    var toJSON: [String:Any] {
        return [
            "dishName": String(),
            "thumbnail": (Any).self,
            "important": [Any](),
            "optional": [Any](),
            "steps": [Any](),
            "favorite": Bool(),
            "section": Any.self
        ]
    }
    
//    static func instance(from json: [String:Any]) -> Recipe {
//        // JSON에서 객체를 만들떄 써주세요.
//        return Recipe(dishName: String(json["dishName"]), thumbnail: ImageData?(json["thumbnail"]), IIngredients: [Ingredient](json["important"]), OIngredients: [Ingredient](json["optional"]), steps: [steps](json["steps"]), favorite: Bool(json["favorite"]), section: Section(json["section"]))
//    }
    
    static func == (leftRecipeName: Self, rightRecipeName: Self) -> Bool {
        // ++TODO: 동등 조건 추가
        return leftRecipeName.dishName == rightRecipeName.dishName
    }
}

class RecipeManager {
    static let shared = RecipeManager()
    static var lastDishName: String = ""
    
    var baseRecipes: [Recipe] = []
    var searchedRecipes: [Recipe] = []
    
    func createRecipe(dishName: String, thumbnail: ImageData?, IIngredients: [Ingredient], OIngredients: [Ingredient], steps: [Step], favorite: Bool, section: Styles) -> Recipe {
        return Recipe(dishName: dishName, thumbnail: thumbnail, IIngredients: IIngredients, OIngredients: OIngredients, steps: steps, favorite: favorite, section: .nokind)
    }
    
    func addRecipe(_ recipe: Recipe) {
        baseRecipes.append(recipe)
        saveRecipe()
    }

    func deleteRecipe(_ recipe: Recipe) {
        /*if let index = recipes.firstIndex(of recipe) {
            recipes.remove(at: index)
        }
        */
        Storage.store(baseRecipes, to: .documents, as: "recipes.json")
    }
    
    func updateRecipe(_ recipe: Recipe) {
        guard let index = baseRecipes.firstIndex(of: recipe) else { return }
        baseRecipes[index].update()

        saveRecipe()
    }
    
    func saveRecipe() {
        Storage.store(baseRecipes, to: .documents, as: "recipes.json")
    }
    
    func retrieveRecipe(){
        baseRecipes = Storage.retrive("recipes.json", from: .documents, as: [Recipe].self) ?? []
    }
    func searchingDishName(_ name: String) {
        let foundRecipes = baseRecipes.filter({ $0.dishName.contains(name) })
        searchedRecipes = foundRecipes
    }
    func recommandingRecipe(_ important: [String], _ optional: [String]) {
        let selectedRecipes = baseRecipes.filter{ (recipe: Recipe) -> Bool in
            print("요리 이름 : \(recipe.dishName)")
            let importantWords: [String] = recipe.IIngredients.map({ $0.name })
            let optionalWords: [String] = recipe.OIngredients.map({ $0.name })
            
            for str in important {
                if importantWords.contains(str) {
                    print("주메뉴 \(str)")
                    return true
                }
            }
            for str in optional {
                if optionalWords.contains(str) {
                    print("부메뉴 \(str)")
                    return true
                }
            }
            print("검색없음")
            return false
        }
        searchedRecipes = selectedRecipes
    }
    func emptySearchedList() {
        searchedRecipes.removeAll()
    }
}


class RecipeViewModel {
    
    private let manager = RecipeManager.shared // 상글톤
    
    var baseRecipes: [Recipe] {
        return manager.baseRecipes
    }
    var searchedRecipes: [Recipe] {
        return manager.searchedRecipes
    }
    
    var baseAllRecipes: [Recipe] {
        return baseRecipes
    }
    var baseFavoriteRecipes: [Recipe] {
        return baseRecipes.filter { $0.favorite == true }
    }
    
    var searchedAllRecipes: [Recipe] {
        return searchedRecipes
    }
    var searchedFavoriteRecipes: [Recipe] {
        return searchedRecipes.filter { $0.favorite == true }
    }
    
    func addRecipe(_ recipe: Recipe) {
        manager.addRecipe(recipe)
    }
    func deleteRecipe(_ recipe: Recipe) {
        manager.deleteRecipe(recipe)
    }
    func updateRecipe(_ recipe: Recipe) {
        manager.updateRecipe(recipe)
    }
    
    func loadTasks() {
        manager.retrieveRecipe()
    }
    func searchingDishName(name: String) {
        manager.searchingDishName(name)
    }
    func recommandingRecipe(_ important: [String], _ optional: [String]) {
        manager.recommandingRecipe(important, optional)
    }
    func emptySearchedList() {
        manager.emptySearchedList()
    }
}

