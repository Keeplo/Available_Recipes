//
//  Recipe.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

struct Recipe {
    let ingredients: [Ingredient]
    let steps: [Step]
    
    func containsAllIngrdients(_ ingredients: [Ingredient]) -> Bool {
        // TODO: 나중에 필터로 재료로 레시피를 찾을때 이용하면 편할 함수입니다.
        return true
    }
    
    // TODO: json에 저장할떄 이용해주세요.
    var toJSON: [String:Any] {
        return [
            "ingreidients": [String:Any](),
            "steps": [[String:Any]]()
        ]
    }
    
    static func instance(from json: [String:Any]) -> Recipe {
        // JSON에서 객체를 만들떄 써주세요.
        return Recipe(ingredients: [], steps: [])
    }
}
