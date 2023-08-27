//
//  OnboardingView.swift
//  MPTT-rlp
//
//  Created by DiOS on 26.08.2023.
//

import UIKit

class OnboardingView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.isScrollEnabled = false
        obj.backgroundColor = .clear
        return obj
    }()
    
    let continueButton: UIButton = {
        let obj = UIButton()
        obj.layer.cornerRadius = 12
        obj.backgroundColor = .white
        obj.setTitle("Continue", for: .normal)
        obj.setTitleColor(.systemBlue, for: .normal)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return obj
    }()
    
    let pageControl: UIPageControl = {
        let obj = UIPageControl()
        obj.currentPage = 0
        obj.numberOfPages = 5
        obj.isUserInteractionEnabled = false
        obj.pageIndicatorTintColor = .white
        obj.currentPageIndicatorTintColor = .systemYellow
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let topBackgroundView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .systemBlue.withAlphaComponent(0.25)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let middleBackgroundView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let bottomBackgroundView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .systemBlue.withAlphaComponent(1)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topBackgroundView.layer.cornerRadius = topBackgroundView.frame.height / 2
        middleBackgroundView.layer.cornerRadius = middleBackgroundView.frame.height / 2
        bottomBackgroundView.layer.cornerRadius = bottomBackgroundView.frame.height / 2
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(bottomBackgroundView)
        addSubview(middleBackgroundView)
        addSubview(topBackgroundView)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: centerYAnchor, constant: -32),
            topBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            topBackgroundView.widthAnchor.constraint(equalTo: topBackgroundView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            middleBackgroundView.topAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            middleBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            middleBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            middleBackgroundView.widthAnchor.constraint(equalTo: middleBackgroundView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            bottomBackgroundView.topAnchor.constraint(equalTo: centerYAnchor),
            bottomBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            bottomBackgroundView.widthAnchor.constraint(equalTo: bottomBackgroundView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalToConstant: 8),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}

