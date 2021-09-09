//
//  TotalNutritionViewModal.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

final class TotalNutritionViewModal {
    
    // MARK: - Properties
    let facts: [Facts]?
    private var factsModelSubject = PublishSubject<[Facts]>()
    
    var factsModelObservable: Observable<[Facts]> {
        return factsModelSubject
    }
    
    // MARK: - Initialize
    init(facts: [Facts]?) {
        self.facts = facts
    }
    
    func ingredientsSubjectOnNext() {
        self.factsModelSubject.onNext(facts ?? [])
    }
    
}
