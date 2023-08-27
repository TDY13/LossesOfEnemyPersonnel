//
//  LossesEquipmentCell.swift
//  MPTT-rlp
//
//  Created by DiOS on 21.08.2023.
//

import UIKit

class LossesEquipmentCell: UITableViewCell {
    static let id = String(describing: LossesEquipmentCell.self)
    
    private let imageContainerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .systemBlue
        obj.layer.cornerRadius = 7
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let image: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private lazy var hStackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [
            equipmentLabel,
            lossesCountLabel
        ])
        obj.axis = .horizontal
        obj.distribution = .fillProportionally
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let equipmentLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = R.color.silver
        obj.textAlignment = .left
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.font = .systemFont(ofSize: 15, weight: .regular)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let lossesCountLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = R.color.black
        obj.textAlignment = .right
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.font = .systemFont(ofSize: 17, weight: .semibold)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        lossesCountLabel.text = nil
        equipmentLabel.text = nil
    }
    
    private func setup() {
        selectionStyle = .none
        
        contentView.addSubview(imageContainerView)
        contentView.addSubview(hStackView)
        imageContainerView.addSubview(image)
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            hStackView.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 8),
            hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            imageContainerView.widthAnchor.constraint(equalToConstant: 35),
            imageContainerView.heightAnchor.constraint(equalToConstant: 35),
            imageContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 4),
            image.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -4),
            image.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 4),
            image.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -4),
            image.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor)
        ])
    }
    
    func configure(with item: EquipmentModel) {
        self.image.image = UIImage(named: item.name)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        equipmentLabel.text = item.name.splitCamelCase()
        if let count = item.value as? Int {
            lossesCountLabel.text = String(describing: count)
        } else if let direction = item.value as? String {
            lossesCountLabel.text = direction
        } else {
            lossesCountLabel.text = "-"
        }
    } 
}
