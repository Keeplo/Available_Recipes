//
//  Recipe.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit
/*
struct Recipe {
    var dishName: String
    let mainIngredients: [Ingredient]
    let ingredients: [Ingredient]
    let steps: [Step]
    var favorite: Bool?
    
    func containsAllIngrdients(_ ingredients: [Ingredient]) -> Bool {
        // TODO: 나중에 필터로 재료로 레시피를 찾을때 이용하면 편할 함수입니다.
        return true
    }
    
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
        return Recipe(dishName: "", importantIngreidients: [], optionalIngreidients: [], steps: [], favorite: nil = false)
    }
}

class RecipeManager {
    static let shared = RecipeManager()
    
    var recipes: [Recipe] = []
    
    func createRecipe(dishName: String, important: [Ingredient], optional: [Ingredient], steps: [Step]) -> Recipe {
        return Recipe(dishName: dishName, importantIngreidients: important, optionalIngreidients: [], steps: [], favorite: nil = false)
    }
    
    func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        saveRecipe()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        // ++TODO: delete 로직 추가
        recipes = recipes.filter({ existingTodo in // { $0.id != todo.id }
            print("filter 작동")
            print("existingTodo.id  \(existingTodo.id )")
            print("todo.id  \(recipe.id )")
            return existingTodo.id != recipe.id
        }) // 방대한 데이터가 아니기에 사용
        
        /*if let index = todos.firstIndex(of: todo) {
            todos.remove(at: index)
        }*/
        
        Storage.store(recipes, to: .documents, as: "todos.json")
    }
    
    func updateRecipe(_ recipe: Recipe) {
        guard  let index = recipes.firstIndex(of: Recipe) else { return }
        recipes[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
    }
    
    func saveRecipe() {
        Storage.store(recipes, to: .documents, as: "todos.json")
    }
    
    func retrieveRecipe() {
        recipes = Storage.retrive("todos.json", from: .documents, as: [Recipe].self) ?? []
        
        let lastId = recipes.last?.id ?? 0
        RecipeManager.lastId = lastId
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
    
    var favoriteRecipes: [Recipe] {
        return recipes.filter { $0.favorite == true }
    }
    
    var upcompingRecipes: [Recipe] {
        return recipes.filter { $0.favorite == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    
    func addRecipe(_ recipe: Recipe) {
        manager.addRecipe(recipe)
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        manager.deleteRecipe(todo)
    }
    
    func updateRecipe(_ recipe: Recipe) {
        manager.updateRecipe(recipe)
    }
    
    func loadTasks() {
        manager.retrieveRecipe()
    }
}
*/
