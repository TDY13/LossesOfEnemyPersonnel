//
//  LossesEquipmentViewController.swift
//	MPTT-rlp
//
//  Created by DiOS on 21.08.2023
//

import UIKit

final class LossesEquipmentViewController: BaseViewController {
    private let mainView = LossesEquipmentView()
    private var equipmentData: [EquipmentModel]
    
    private var lossesEquipment: LossesEquipmentModel
    
    // MARK: - Function(s)
    init(equipment: LossesEquipmentModel, equipmentService: EquipmentService) {
        self.lossesEquipment = equipment
        self.equipmentData = equipmentService.createEquipmentDataFromReflection(equipment)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = R.constant.statisticsFor + (lossesEquipment.date.decodeDateFromString() ?? R.constant.unknownDate)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(LossesEquipmentTopCell.self, forCellReuseIdentifier: LossesEquipmentTopCell.id)
        mainView.tableView.register(LossesEquipmentCell.self, forCellReuseIdentifier: LossesEquipmentCell.id)
    }
}

//MARK: - UITableViewDelegate
extension LossesEquipmentViewController: UITableViewDelegate {}

//MARK: - UITableViewDataSource
extension LossesEquipmentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : equipmentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LossesEquipmentTopCell.id, for: indexPath) as? LossesEquipmentTopCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LossesEquipmentCell.id, for: indexPath) as? LossesEquipmentCell else { return UITableViewCell() }
            let item = equipmentData[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
