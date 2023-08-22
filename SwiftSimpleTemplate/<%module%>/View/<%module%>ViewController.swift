//
//  <%module%>ViewController.swift
//	<%project%>
//
//  Created by DiOS on <%date%>
//

import UIKit

class <%module%>ViewController: UIViewController {
    private let mainView = <%module%>View()
    
    // MARK: - Functions
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        
    }
}
