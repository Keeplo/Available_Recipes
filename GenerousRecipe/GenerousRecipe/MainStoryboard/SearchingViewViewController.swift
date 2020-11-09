//
//  IngredientsViewController.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController {
    
    var tags: [String:String] = [:]
    
    //Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    @IBAction func searchingButton(_ sender: Any) {
        if false {
            //self.presentingViewController?.dismiss(animated: true, completion:nil)
        } else {
            let msg = "검색할 조건을 입력해주세요"
            let title = "재료 입력 필요"
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) {(action: UIAlertAction!) -> Void in
                NSLog(msg)
            }
            
            alert.addAction(confirmAction)
            
            present(alert, animated: true, completion:nil)
        }
    }
}

extension SearchingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
extension SearchingViewController: UICollectionViewDelegate {
    
}

extension SearchingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField.text!.isEmpty {
//
//        }
        return true
    }
}
