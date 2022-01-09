//
//  ToolbarTextField.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/09.
//

import UIKit

class ToolbarTextField: UITextField {
    
    // MARK: - Properties
    
    var leftBarItem = [UIBarButtonItem]()
    var rightBarItem = [UIBarButtonItem]()
    
    lazy var done: UIBarButtonItem = {
        return .init(title: "완료",
                     style: .done,
                     target: self,
                     action: #selector(dismissKeyboard))
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         leftBarItem: [UIBarButtonItem] = [],
         rightBarItem: [UIBarButtonItem] = []) {
        
        self.leftBarItem = leftBarItem
        self.rightBarItem = rightBarItem
        
        super.init(frame: frame)
        
        addToolbarWithItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ToolbarTextField.init(coder:) called.")
    }
    
    public func addDoneButton() {
        self.rightBarItem.append(done)
        addToolbarWithItems()
    }
    
    public func addRightBarItems(_ items: [UIBarButtonItem]) {
        self.rightBarItem.append(contentsOf: items)
        addToolbarWithItems()
    }
    
    public func addLeftBarItems(_ items: [UIBarButtonItem]) {
        self.leftBarItem.append(contentsOf: items)
        addToolbarWithItems()
    }
    
    private func addToolbarWithItems() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 45))
        var toolbarItems = leftBarItem
        toolbarItems.append(.flexibleSpace())
        toolbarItems.append(contentsOf: rightBarItem)
        
        self.inputAccessoryView = toolbar
        toolbar.setItems(toolbarItems, animated: false)
    }
    
    @objc
    private func dismissKeyboard() {
        self.endEditing(true)
    }
}
