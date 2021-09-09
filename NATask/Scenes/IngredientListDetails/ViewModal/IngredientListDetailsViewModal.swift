//
//  IngredientListDetailsViewModal.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

final class IngredientLisrDetailsViewModal {
    
    // MARK: - Properties
    let ingredients: [IngredientModal]?
    private var ingredientsModelSubject = PublishSubject<[IngredientModal]>()
    
    var ingredientModelObservable: Observable<[IngredientModal]> {
        return ingredientsModelSubject
    }
    
    // MARK: - Initialize
    init(ingredients: [IngredientModal]?) {
        self.ingredients = ingredients
    }
    
    func ingredientsSubjectOnNext() {
        self.ingredientsModelSubject.onNext(ingredients ?? [])
    }
    
    // MARK: - Navigate to Total Nutrition
    func showTotalNutrition(view: UIViewController) {
        let totleNutritionViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TotleNutritionViewController")
        if let totleNutritionViewController = totleNutritionViewController as? TotleNutritionViewController {
            totleNutritionViewController.totalNutritionViewModal = TotalNutritionViewModal(facts: getFacts())
        }
        totleNutritionViewController.modalPresentationStyle = .fullScreen
        view.navigationController?.pushViewController(totleNutritionViewController, animated: true)
    }

    func getFacts() -> [Facts] {
        let requiredCalculations = [
            "Calories": 1,
            "Fat": 1,
            "Cholesterol": 1,
            "Sodium": 1,
            "Carbs": 1,
            "Fiber": 1,
            "Protein": 1,
            "Vitamin": 1,
            "Calcium": 1,
            "Iron": 1,
            "Potassium": 1
        ]
        var factsDic = [String: Facts]()
        for item in ingredients ?? [] {
            factsDic["Calories"] = Facts(label: "Calories", quantity: ((factsDic["Calories"]?.quantity ?? 0.0) + Double(item.calories ?? 0)), unit: "kcal")
            for fact in item.totalDaily ?? [:] {
                let prevValue = factsDic[fact.key]
                let newQuantity = (prevValue?.quantity ?? 0) + (fact.value.quantity ?? 0)
                factsDic[fact.key] = Facts(label: fact.value.label, quantity: newQuantity, unit: fact.value.unit)
            }
        }
        
        return factsDic.map({return $0.value}).filter({requiredCalculations[$0.label ?? ""] == 1})
    }
}
