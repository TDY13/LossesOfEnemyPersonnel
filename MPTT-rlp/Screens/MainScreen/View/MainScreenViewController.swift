//
//  MainScreenViewController.swift
//	MPTT-rlp
//
//  Created by DiOS on 21.08.2023
//

import UIKit

final class MainScreenViewController: BaseViewController {
    private let mainView = MainScreenView()
    
    private var lossesPersonnel: [LossesPersonnelModel] = []
    private var lossesEquipment: [LossesEquipmentModel] = []
    
    private var dataSource: UITableViewDiffableDataSource<Int, AnyHashable>?
    
    private var selectedDay: Int?
    
    // MARK: - Functions
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func initViewController() {
        navigationItem.title = R.constant.lossesPersonnel
        configTableView()
    }
    
    private func fetchData() {
        lossesPersonnel = Bundle.main.decode([LossesPersonnelModel].self,
                                             from: R.constant.personnelJSON)
        lossesEquipment = Bundle.main.decode([LossesEquipmentModel].self,
                                             from: R.constant.equipJSON)
        updateDataSource()
    }
    
    private func showLossesEquipmentScreen(with data: LossesEquipmentModel) {
        let vc = LossesEquipmentViewController(equipment: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate
extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDay = lossesPersonnel[indexPath.row].day
        
        if let selectedData = lossesEquipment.first(where: { $0.day == selectedDay }) {
            showLossesEquipmentScreen(with: selectedData)
        }
    }
}

//MARK: - UITableViewDiffableDataSource
extension MainScreenViewController {
    
    private func configTableView() {
        
        mainView.tableView.delegate = self
        mainView.tableView.register(LossesPersonnelCell.self, forCellReuseIdentifier: LossesPersonnelCell.id)
        
        dataSource = UITableViewDiffableDataSource(tableView: mainView.tableView,
                                                   cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LossesPersonnelCell.id,
                                                           for: indexPath) as? LossesPersonnelCell else { return UITableViewCell() }
            let item = self.lossesPersonnel[indexPath.row]
            cell.configure(with: item)
            return cell
        })
        
        updateDataSource()
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, AnyHashable>()
        snapshot.appendSections([0])
        snapshot.appendItems(lossesPersonnel)
        
        dataSource?.apply(snapshot)
    }
}