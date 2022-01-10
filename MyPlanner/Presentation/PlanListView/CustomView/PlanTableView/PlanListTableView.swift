//
//  PlanListTableView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/06.
//

import UIKit
import RxSwift
import RxRelay

class PlanListTableView: UITableView {
    
    // MARK: - Properties
    let viewModel: PlanListViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: PlanListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        registerCell()
        bind(to: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("PlanListTableView.init(coder:) called.")
    }
    
    private func registerCell() {
        self.register(PlanListCell.self, forCellReuseIdentifier: PlanListCell.reuseIdentifier)
    }
    
    private func bind(to: PlanListViewModel) {
        viewModel.planList.bind { [weak self] plans in
            guard let strongSelf = self else { return }
            strongSelf.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.planListViewAction.subscribe(onNext: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension PlanListTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.presentEditPlan(at: indexPath.row)
    }
}

// MARK: - DataSource
extension PlanListTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanListCell.reuseIdentifier,
                                                       for: indexPath) as? PlanListCell else {
            return UITableViewCell()
        }
        
        let mode = viewModel.getTimeLineMode(at: indexPath.row)
        let plan = viewModel.getPlan(at: indexPath.row)
        cell.configureCell(plan: plan, mode: mode) { [weak self] in
            self?.viewModel.togglePlanAchieve(at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
