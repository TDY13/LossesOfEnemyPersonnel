//
//  MainScreenView.swift
//	MPTT-rlp
//
//  Created by DiOS on 21.08.2023
//

import UIKit

final class MainScreenView: UIView {
    
    let tableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .insetGrouped)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.separatorInset = .init(top: 0, left: 58, bottom: 0, right: 0)
        obj.backgroundColor = .clear
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
