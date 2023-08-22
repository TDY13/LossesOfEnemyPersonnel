//
//  LossesEquipmentView.swift
//	MPTT-rlp
//
//  Created by DiOS on 21.08.2023
//

import UIKit

class LossesEquipmentView: UIView {
    
    private lazy var hStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            topImage,
            vStackView
        ])
        obj.axis = .horizontal
        obj.spacing = 8
        obj.alignment = .center
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let topImage: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: R.image.afou)
        obj.contentMode = .scaleAspectFit
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private lazy var vStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
        titleLabel,
        descriptionLabel
        ])
        obj.axis = .vertical
        obj.spacing = 2
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.text = R.constant.info
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.textColor = .systemBlue
        obj.font = .systemFont(ofSize: 27, weight: .bold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.text = R.constant.enemyLosses
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.textColor = .systemYellow
        obj.font = .systemFont(ofSize: 15, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView(frame: .zero, style: .insetGrouped)
        obj.backgroundColor = .clear
        obj.separatorInset = .init(top: 0, left: 56, bottom: 0, right: 0)
        obj.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(hStackView)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            hStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            hStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            topImage.heightAnchor.constraint(equalToConstant: 50),
            topImage.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: hStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
