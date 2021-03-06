//
//  IngredientModal.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation

struct IngredientModal: Codable {
    var ingredientText: String?
    let uri : String?
    let calories : Int?
    let totalWeight : Int?
    let totalNutrients : [String: Facts]?
    let totalDaily: [String: Facts]?
    let totalNutrientsKCal: [String: Facts]?
    let cautions: [String]?
    let healthLabels: [String]?
    let dietLabels: [String]?
    
}
