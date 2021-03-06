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
    
    func analyzeText(view: UIViewController) {
        if Connectivity.isConnectedToInternet {
            loadingBehavior.accept(true)
            let ingredientsByLines = inputText.value.split(separator: "\n")
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let self = self else { return }
                var ingredients: [IngredientModal] = []
                var errorMassage = ""
                for line in ingredientsByLines {
                    self.myGroup.enter()
                    APIClient.getNutritionDetails(text: String(line)) { res, error, massage  in
                        if var ingredient = res {
                            ingredient.ingredientText = String(line)
                            ingredients.append(ingredient)
                        } else if let massage = massage {
                            errorMassage = massage
                        } else if error != nil {
                            errorMassage = error?.localizedDescription ?? "Error"
                        }
                        self.myGroup.leave()
                    }
                }
                self.myGroup.notify(queue: .main) {
                    self.loadingBehavior.accept(false)
                    if ingredients.count > 0 {
                        self.navigateToIngredientListDetailsViewController(view: view, ingredients: ingredients)
                    } else {
                        view.alert(message: errorMassage)
                    }
                }
            }
        } else {
            view.alert(message: "No Internet Connection")
        }
    }
    
    func navigateToIngredientListDetailsViewController(view: UIViewController, ingredients: [IngredientModal]) {
        let ingredientListDetailsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IngredientListDetailsViewController")
        if let ingredientListDetailsViewController = ingredientListDetailsViewController as? IngredientListDetailsViewController {
            ingredientListDetailsViewController.ingredientLisrDetailsViewModal = IngredientLisrDetailsViewModal(ingredients: ingredients)
        }
        ingredientListDetailsViewController.modalPresentationStyle = .fullScreen
        view.navigationController?.pushViewController(ingredientListDetailsViewController, animated: true)
    }
    
}
