//
//  LossesEquipmentTopCell.swift
//  MPTT-rlp
//
//  Created by DiOS on 27.08.2023.
//

import UIKit

final class LossesEquipmentTopCell: UITableViewCell {
    static let id = String(describing: LossesEquipmentTopCell.self)
    
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
    
    private let topImage: UIImageView = {
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
    
    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.text = R.constant.info
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.textColor = .systemBlue
        obj.font = .systemFont(ofSize: 27, weight: .bold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.text = R.constant.enemyLosses
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.textColor = .systemYellow
        obj.font = .systemFont(ofSize: 15, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        
        addSubview(hStackView)
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            topImage.heightAnchor.constraint(equalToConstant: 50),
            topImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
