//
//  BaseSearchViewController.swift
//  MPTT-rlp
//
//  Created by DiOS on 23.08.2023.
//

import UIKit

class BaseSearchViewController: BaseViewController {
    
    var maxSearchTextLength = 4
    var searchWorkItem: DispatchWorkItem?
    
    // MARK: - Method(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpSearchBar()
    }
    
    func setUpSearchBar() {
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController?.searchBar.keyboardType = .numberPad
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    private func setUpSubviews() {
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UISearchBarDelegate
extension BaseSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let invalidCharacters = CharacterSet.decimalDigits.inverted
        
        guard text.rangeOfCharacter(from: invalidCharacters) == nil else { return false }
        
        guard let currentText = searchBar.text else { return false }
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= maxSearchTextLength
    }
}
