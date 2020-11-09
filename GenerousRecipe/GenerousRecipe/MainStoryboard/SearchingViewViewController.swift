//
//  IngredientsViewController.swift
//  GenerousRecipe
//
//  Created by Yongwoo Marco on 2020/10/26.
//  Copyright © 2020 FastCampus. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController {
    

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
    
    @IBAction func cancelAddingButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}

//extension SearchViewController: UISearchBarDelegate {
//    private func dismissKeyboard() {
//        searchBar.resignFirstResponder() //
//        print("dismissKeyboard")
//    }
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        dismissKeyboard() // 키보드가 올라와 있을때, 내려가게 처리
//        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return } // 검색어가 있는지 확인 비어 있을경우 검색x
//
//
//        SearchAPI.search(searchTerm) { movies in        // collectionView로 표현하기
//            print("--> 몇개 넘어왔어?? \(movies.count), 첫번째꺼 제목: \(String(describing: movies.first?.title))")
//            DispatchQueue.main.async { // 검색 결과가 메인쓰레드에서 UI변경을 해야 하므로 네트워크 쓰레드가 아니라 메인에서 처리하도록 두기
//                self.movies = movies
//                self.resultCollectionView.reloadData()
//            }
//        }
//        print("--> 검색어: \(searchTerm)")
//    }
//}
