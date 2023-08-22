//
//  LossesPersonnelCell.swift
//  MPTT-rlp
//
//  Created by DiOS on 21.08.2023.
//

import UIKit

class LossesPersonnelCell: UITableViewCell {
    static let id = String(describing: LossesPersonnelCell.self)
    
    private let dayContainerView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = R.color.field
        return obj
    }()
    
    private let dayCountLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .systemBlue
        obj.font = .systemFont(ofSize: 12, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.minimumScaleFactor = 0.5
        obj.adjustsFontSizeToFitWidth = true
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
        obj.minimumScaleFactor = 0.5
        obj.textColor = R.color.black
        obj.adjustsFontSizeToFitWidth = true
        obj.font = .systemFont(ofSize: 17, weight: .semibold)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.text = R.constant.unknownPOW
        obj.textColor = R.color.silver
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayContainerView.layer.cornerRadius = dayContainerView.frame.height / 2
    }
    
    private func setup() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(dayContainerView)
        dayContainerView.addSubview(dayCountLabel)
        contentView.addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            dayContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dayContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayContainerView.heightAnchor.constraint(equalToConstant: 32),
            dayContainerView.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            dayCountLabel.centerXAnchor.constraint(equalTo: dayContainerView.centerXAnchor),
            dayCountLabel.centerYAnchor.constraint(equalTo: dayContainerView.centerYAnchor),
            dayCountLabel.trailingAnchor.constraint(greaterThanOrEqualTo: dayContainerView.leadingAnchor, constant: 0.5),
            dayCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: dayContainerView.trailingAnchor, constant: -0.5)
        ])
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: dayContainerView.trailingAnchor, constant: 8),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            vStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -2)
        ])
    }
    
    func configure(with item: LossesPersonnelModel) {
        dayCountLabel.text = String(describing: item.day)
        titleLabel.text = "\(R.constant.lossesPersonnel) \(item.lossesPersonnel) \(item.personnel) ☠"
        if let pow = item.pow {
            descriptionLabel.text = "\(R.constant.pow) - \(pow)"
        } else {
            descriptionLabel.text = "\(R.constant.averageOrcLosses) - \(item.personnel / item.day)"
        }
    }
}
