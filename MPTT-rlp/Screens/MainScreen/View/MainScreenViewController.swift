//
//  MainScreenViewController.swift
//	MPTT-rlp
//
//  Created by DiOS on 21.08.2023
//

import UIKit

final class MainScreenViewController: BaseSearchViewController {
    private let mainView = MainScreenView()
    
    private var lossesPersonnel: [LossesPersonnelModel] = []
    private var lossesEquipment: [LossesEquipmentModel] = []
    
    private var dataSource: UITableViewDiffableDataSource<Int, AnyHashable>?
    
    private var ascendingSort = true
    
    private var networkLayer: NetworkLayer
    private var equipmentService: EquipmentService
    
    // MARK: - Function(s)
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
        self.equipmentService = EquipmentService(networkLayer: networkLayer)
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
        navigationItem.title = R.constant.lossesPersonnel
        
        configTableView()
        setupSortingButton()
        
        Task {
            do {
                try await fetchPersonnelDataAndProcess()
                try await fetchEquipmentDataAndProcess()
            }
        }
    }
    
    private func sortedArrayByDay(ascending: Bool, completion: () -> Void?) {
        if ascending {
            if ascendingSort == false {
                lossesPersonnel = lossesPersonnel.sorted { $0.day < $1.day }
                completion()
            }
        } else {
            if ascendingSort == true {
                lossesPersonnel = lossesPersonnel.sorted { $0.day > $1.day }
                completion()
            }
        }
    }
    
    private func showLossesEquipmentScreen(with data: LossesEquipmentModel) {
        let vc = LossesEquipmentViewController(equipment: data, equipmentService: equipmentService)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - FetchDataService
extension MainScreenViewController {
    
    private func fetchPersonnelDataAndProcess() async throws {
        do {
            self.lossesPersonnel = try await networkLayer.fetchDataAsync(from: R.URL.personnelURL.setupURL(), modelType: LossesPersonnelModel.self)
            self.updateDataSource()
        } catch {
            self.lossesPersonnel = Bundle.main.decode([LossesPersonnelModel].self, from: R.constant.personnelJSON)
            self.updateDataSource()
        }
    }
    
    private func fetchEquipmentDataAndProcess() async throws {
        do {
            self.lossesEquipment = try await equipmentService.takeLossesEquipment()
        } catch {
            self.lossesEquipment = Bundle.main.decode([LossesEquipmentModel].self, from: R.constant.equipJSON)
        }
    }
}

//MARK: - UITableViewDelegate
extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedData = lossesEquipment.first(where: { $0.day == lossesPersonnel[indexPath.row].day }) {
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

// MARK: - UISearchBarDelegate
extension MainScreenViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let maxSearchResult = self?.lossesPersonnel.count else { return }
            guard let row = Int(searchText), row >= 2 else { return }
            let adjustedRow = row - 2
            guard adjustedRow < maxSearchResult else { return }
            self?.mainView.tableView.scrollToRow(at: IndexPath(row: adjustedRow, section: 0), at: .top, animated: true)
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: workItem)
    }
}

//MARK: - SortingSetup
extension MainScreenViewController {
    
    private func setupSortingButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainView.sortingButton)
        let menu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: R.constant.lowToHight, image: UIImage(systemName: R.image.chevronDown)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { action in
                self.sortedArrayByDay(ascending: true) {
                    self.updateDataSource()
                }
                self.ascendingSort = true

            }),
            UIAction(title: R.constant.hightToLow, image: UIImage(systemName: R.image.chevronUp)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { action in
                self.sortedArrayByDay(ascending: false) {
                    self.updateDataSource()
                }
                self.ascendingSort = false
            })
        ])
        
        mainView.sortingButton.menu = menu
    }
}
