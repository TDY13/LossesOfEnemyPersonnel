//
//  OnboardingCell.swift
//  MPTT-rlp
//
//  Created by DiOS on 26.08.2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    static let id = String(describing: OnboardingCell.self)
    
    private let topImage: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.numberOfLines = 0
        obj.textColor = .white
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 20, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.numberOfLines = 0
        obj.textColor = .white
        obj.textAlignment = .center
        obj.font = .systemFont(ofSize: 17, weight: .regular)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topImage.image = nil
    }
    
    private func setup() {
        contentView.addSubview(topImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            topImage.bottomAnchor.constraint(equalTo: centerYAnchor),
            topImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImage.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with item: OnboardingModel) {
        topImage.image = UIImage(named: item.image)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}
