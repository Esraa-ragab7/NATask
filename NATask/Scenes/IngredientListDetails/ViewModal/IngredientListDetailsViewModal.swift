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
        
    }
}
