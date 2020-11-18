//
//  Step.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

struct Step: Codable, Equatable {
    // TODO: 레시피에 사진도 있으면 사용자가 이해하기 더 쉽겠죠?
    var imageDescription: String? // imageDescription Path (온라인용)
    var textInstructions: String
}
