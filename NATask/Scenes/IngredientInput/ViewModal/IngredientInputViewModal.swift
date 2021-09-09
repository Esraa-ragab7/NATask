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
    var loadingBehavior: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    let myGroup = DispatchGroup()
    
    var isAnalyzeButtonEnabled: Observable<Bool> {
        return inputText.asObservable().map { (phone) -> Bool in
            let isInputTextEmpty = self.inputText.value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return !isInputTextEmpty
        }
    }
    
    func analyzeText() {
        let ingredientsByLines = inputText.value.split(separator: "\n")
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            var ingredients: [IngredientModal] = []
            for line in ingredientsByLines {
                self.myGroup.enter()
                APIClient.getNutritionDetails(text: String(line)) { res, error  in
                    if var ingredient = res {
                        ingredient.ingredientText = String(line)
                        ingredients.append(ingredient)
                    }
                    self.myGroup.leave()
                }
            }
            self.myGroup.notify(queue: .main) {
                print(ingredients)
            }
        }
    }
    
}
