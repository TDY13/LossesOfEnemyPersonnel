//
//  OnboardingViewController.swift
//  MPTT-rlp
//
//  Created by DiOS on 26.08.2023.
//

import UIKit
import StoreKit

class OnboardingViewController: UIViewController {
    private let mainView = OnboardingView()
    
    private var data: [OnboardingModelSection] = []
    private var currentPage = 0

    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        data = Bundle.main.decode([OnboardingModelSection].self, from: "onboarding.json")
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.id)
        mainView.continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }
}

//MARK: - UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index - ", indexPath.row)
    }
}

//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.id, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        let item = data[indexPath.section].items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.collectionView.frame.width, height: mainView.collectionView.frame.height)
    }
}

//MARK: - Action(s)
extension OnboardingViewController {
    @objc private func didTapContinueButton() {
//        if currentPage == 2 {
//            SKStoreReviewController.requestReview()
//        }
        currentPage += 1
        mainView.pageControl.currentPage = currentPage
        if currentPage < data[0].items.count {
            mainView.collectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            let vc = MainScreenViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
