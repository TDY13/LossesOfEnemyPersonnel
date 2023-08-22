//
//  LossesEquipmentViewController.swift
//	MPTT-rlp
//
//  Created by DiOS on 21.08.2023
//

import UIKit

struct EquipmentModel {
    let name: String
    let value: Any?
}

class LossesEquipmentViewController: BaseViewController {
    private let mainView = LossesEquipmentView()
    
    private var equipmentData: [EquipmentModel] = []
    private var lossesEquipment: LossesEquipmentModel
    
    // MARK: - Functions
    init(equipment: LossesEquipmentModel) {
        self.lossesEquipment = equipment
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
        navigationItem.title = decodeDateFromString(lossesEquipment.date)
    
        equipmentData = createEquipmentDataFromReflection(lossesEquipment)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(LossesEquipmentCell.self,
                                    forCellReuseIdentifier: LossesEquipmentCell.id)
    }
    
    func decodeDateFromString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = R.constant.dateFormatterYMD
        
        if let date = dateFormatter.date(from: dateString) {
            let resultFormatter = DateFormatter()
            resultFormatter.dateFormat = R.constant.dateFormatterDMY
            return resultFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    private func createEquipmentDataFromReflection(_ lossesEquipment: LossesEquipmentModel) -> [EquipmentModel] {
        let mirror = Mirror(reflecting: lossesEquipment)
        return mirror.children.compactMap { child in
            guard let label = child.label else {
                return nil
            }
            
            if label == R.constant.date || label == R.constant.day {
                return nil
            }
            
            let words = label.split(separator: " ").map { String($0) }
            let fieldName = words
                .map { word in
                    return word.prefix(1).uppercased() + word.dropFirst()
                }
                .joined(separator: " ")
            
            if let value = child.value as? Any? {
                if let unwrappedValue = value {
                    return EquipmentModel(name: fieldName, value: unwrappedValue)
                }
            }
            return nil
        }
    }
}

//MARK: - UITableViewDelegate
extension LossesEquipmentViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension LossesEquipmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        equipmentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LossesEquipmentCell.id, for: indexPath) as? LossesEquipmentCell else { return UITableViewCell() }
        let item = equipmentData[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}
