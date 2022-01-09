//
//  ColorSelectorViewModel.swift
//  MyPlanner
//
//  Created by 김세영 on 2022/01/09.
//

import Foundation
import RxSwift
import RxRelay

protocol ColorSelectorViewModelInput {
    
    func selectColor(at index: Int)
}

@objc
protocol ColorSelectorViewModelAction {
    
    func select()
}

protocol ColorSelectorViewModelOutput {
    
    var colorSelectorAction: PublishSubject<ColorSelectorAction> { get }
    var selectedColor: BehaviorRelay<Plan.Color> { get }
    var colorCollection: [Plan.Color] { get }
    
    func getColor(at index: Int) -> UIColor
}

protocol ColorSelectorViewModel: ColorSelectorViewModelInput,
                                 ColorSelectorViewModelAction,
                                 ColorSelectorViewModelOutput { }

class DefaultColorSelectorViewModel: ColorSelectorViewModel {
    
    // MARK: - Properties
    let addPlanViewModel: AddPlanViewModel
    
    let colorSelectorAction = PublishSubject<ColorSelectorAction>()
    let selectedColor = BehaviorRelay<Plan.Color>(value: Color.accentColor.toHexStr())
    let colorCollection = Color.getColorAssets()
    
    // MARK: - Methods
    init(addPlanViewModel: AddPlanViewModel) {
        self.addPlanViewModel = addPlanViewModel
    }
    
    // MARK: - Input
    func selectColor(at index: Int) {
        let color = colorCollection[index]
        selectedColor.accept(color)
        addPlanViewModel.changeColor(color)
    }
    
    // MARK: - Action
    @objc
    func select() {
        colorSelectorAction.onNext(.select)
    }
    
    // MARK: - Output
    func getColor(at index: Int) -> UIColor {
        let colorHex = colorCollection[index]
        return UIColor(colorHex)
    }
}
