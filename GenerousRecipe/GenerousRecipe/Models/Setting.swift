//
//  Setting.swift
//  GenerousRecipe
//
//  Created by James Kim on 8/5/20.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import Foundation

enum Setting: CaseIterable {
    case appVersion
    case requestToReview
    
    var rightText: String? {
        // right text가 있으면 settingViewController에서 cell에서 오른쪽에 위치한 label로 보여주고 없으면 가려주면 될거같아요.
        switch self {
        default: return nil
        }
    }
}
