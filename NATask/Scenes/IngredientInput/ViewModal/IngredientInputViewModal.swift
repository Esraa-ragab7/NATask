//
//  IngredientInputViewModal.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

final class IngredientInputViewModal {
    
    var inputText: BehaviorRelay<String> = BehaviorRelay(value: "")
    var isAnalyzeButtonEnabled: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var loadingBehavior = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()
    
    
    func analyzeText() {
        
    }
    
}
