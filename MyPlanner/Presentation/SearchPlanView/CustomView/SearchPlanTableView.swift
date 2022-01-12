//
//  SearchPlanTableView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/13.
//

import UIKit
import RxSwift
import RxRelay

class SearchPlanTableView: UITableView {
    
    // MARK: - Properties
    let viewModel: SearchPlanViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: SearchPlanViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, style: .plain)
        
        self.keyboardDismissMode = .interactive
        self.delegate = self
        self.dataSource = self
        
        register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        bind(to: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SearchPlanTableView.init(coder:) called.")
    }
    
    private func bind(to viewModel: SearchPlanViewModel) {
        viewModel.searchResult.bind { [weak self] _ in
            self?.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension SearchPlanTableView: UITableViewDelegate {
    
}

extension SearchPlanTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.value.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier,
                                                       for: indexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
        
        let color = viewModel.getColor(at: indexPath.row)
        let date = viewModel.getDate(at: indexPath.row)
        let name = viewModel.getName(at: indexPath.row)
        let achieve = viewModel.getAchieve(at: indexPath.row)
        
        cell.configureCell(color: color, date: date, name: name, achieve: achieve)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
