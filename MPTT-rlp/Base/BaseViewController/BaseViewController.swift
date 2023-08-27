//
//  BaseViewController.swift
//  MPTT-rlp
//
//  Created by DiOS on 21.08.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Function(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpNavigationBarAppearance()
    }
    
    private func setUpNavigationBarAppearance() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.backgroundColor = .white
        
        let backImage = UIImage(systemName: "chevron.left")
        standardAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        navigationItem.standardAppearance = standardAppearance
        navigationItem.scrollEdgeAppearance = standardAppearance
        navigationItem.compactAppearance = standardAppearance
        if #available(iOS 15.0, *) {
            navigationItem.compactScrollEdgeAppearance = standardAppearance
        }
        
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setUpSubviews() {
        view.backgroundColor = R.color.bg
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.leftBarButtonItem = .init(image: UIImage(systemName: "crown.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didTapInfoButton))
    }
    
    private func presentCharityScreen() {
        if let url = URL(string: R.URL.united24URL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

//MARK: - Action(s)
extension BaseViewController {
    @objc private func didTapInfoButton() {
        presentCharityScreen()
    }
}
