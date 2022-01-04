//
//  DeclarativeView.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/03.
//

import UIKit

class DeclarativeView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable,
                message: "DeclarativeView -> init(coder:) used."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("DeclarativeView -> init(coder:) used.")
    }
}

class DeclarativeViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
                message: "DeclarativeView -> init(coder:) used."
    )
    public required init?(coder: NSCoder) {
        fatalError("DeclarativeView -> init(coder:) used.")
    }
}
