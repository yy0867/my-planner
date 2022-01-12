//
//  SearchPlanView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/13.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SearchPlanView: DeclarativeView {
    
    // MARK: - Properties
    let viewModel: SearchPlanViewModel
    let disposeBag = DisposeBag()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.returnKeyType = .search
        searchBar.placeholder = "일정 검색"
        searchBar.showsCancelButton = true
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        return searchBar
    }()
    
    lazy var tableView: SearchPlanTableView = {
        let tableView = SearchPlanTableView(viewModel: viewModel)
        
        return tableView
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: SearchPlanViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = Color.background
        
        bind(to: viewModel)
        constructHierarchy()
        activateConstraints()
    }
    
    private func bind(to viewModel: SearchPlanViewModel) {
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }
    
    private func constructHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    private func activateConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.left.right.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

extension SearchPlanView: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.takeAction(.cancel)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
