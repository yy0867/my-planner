//
//  ColorCell.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/09.
//

import UIKit
import SnapKit

class ColorCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ColorCellReuseIdentifier"
    
    lazy var colorCell: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructHierarchy()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ColorCell.init(coder:)")
    }
    
    private func constructHierarchy() {
        self.addSubview(colorCell)
    }
    
    private func activateConstraints() {
        colorCell.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    public func setColor(_ color: UIColor) {
        colorCell.backgroundColor = color
    }
}
