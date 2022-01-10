//
//  SelectColorView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/09.
//

import UIKit
import SnapKit

class ColorSelectorView: DeclarativeView {
    
    // MARK: - Properties
    let viewModel: ColorSelectorViewModel
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 45
        let length = UIScreen.main.bounds.width / 3 - padding
        
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionViewLayout.itemSize = CGSize(width: length, height: length)
        
        return collectionViewLayout
    }()
    
    lazy var colorCollection: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(ColorCell.self,
                                forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        
        return collectionView
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: ColorSelectorViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.backgroundColor = Color.background
        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy() {
        addSubview(colorCollection)
    }
    
    func activateConstraints() {
        colorCollection.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

extension ColorSelectorView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.selectColor(at: indexPath.item)
    }
}

extension ColorSelectorView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let padding: CGFloat = 45
        return padding / 2
    }
}

extension ColorSelectorView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.colorCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier,
                                                            for: indexPath) as? ColorCell else {
            return UICollectionViewCell()
        }
        
        cell.setColor(viewModel.getColor(at: indexPath.item))
        
        return cell
    }
}
