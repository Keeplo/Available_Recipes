//
//  AddRecipeCell.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/11/13.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit
import Foundation

class AddRecipeCell: UITableViewCell {
    @IBOutlet weak var dishNameTF: UITextField!
    
    @IBOutlet weak var dishStyleTF: UITextField!
    @IBOutlet weak var ingredientNameTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    
    @IBOutlet weak var stepsTF: UITextField!
    
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    private let styles: [(Styles,String)] = [(.korean, "한식"), (.japanese, "일식"), (.chinese, "중식"), (.western, "양식"), (.nokind, "기타")]
    
    
    func updateDishStyle() {
        let stylePicker = UIPickerView()
        stylePicker.delegate = self
        dishStyleTF.inputView = stylePicker
    }
    func allCellInit() {
        
    }
}
extension AddRecipeCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return styles[row].1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dishStyleTF.text = styles[row].1
    }
}

extension AddRecipeCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return styles.count
    }
}
