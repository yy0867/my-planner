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
        searchBar.inputAccessoryView = colorSearchToolbar
        searchBar.becomeFirstResponder()
        
        return searchBar
    }()
    
    lazy var tableView: SearchPlanTableView = {
        let tableView = SearchPlanTableView(viewModel: viewModel)
        
        return tableView
    }()
    
    lazy var colorSearchToolbar: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        let colorAsset = viewModel.getColorAssets()
        let stackView = UIStackView(frame: scrollView.frame)
        
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.layer.borderWidth = 0.5
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        
        
        colorAsset.forEach { color in
            let button = UIButton()
            button.layer.cornerRadius = 10
            button.backgroundColor = UIColor(color)
            stackView.addArrangedSubview(button)
            button.addTarget(self,
                             action: #selector(searchByColor(_:)),
                             for: .touchUpInside)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        return scrollView
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
    
    @objc
    func searchByColor(_ sender: UIButton) {
        guard let color = sender.backgroundColor?.toHexStr() else { return }
        viewModel.searchColor.accept(color)
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
