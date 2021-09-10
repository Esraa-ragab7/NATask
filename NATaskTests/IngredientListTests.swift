//
//  IngredientListTests.swift
//  NATaskTests
//
//  Created by Esraa Mohamed Ragab on 10/09/2021.
//

import XCTest
@testable import NATask

class IngredientListTests: XCTestCase {

    var ingredientListDetailsViewController: IngredientListDetailsViewController!
    var inputText = "2 apples"
    
    func testExample() throws {
        // MARK: - Case1 With Facts
        callAnalyzeAPI()
        getFacts()
        
        // MARK: - Case2 With Empty Facts
        
         /*
            inputText = "dsfdsfdsf"
            callAnalyzeAPI()
            getFacts()
         */
    }
    
    func getFacts() {
        let facts = ingredientListDetailsViewController.ingredientLisrDetailsViewModal.getFacts()
        XCTAssert(facts.count > 1, "No Facts exist") // 1 because by deafult it has calories inserted hard copy
    }
    
    func initIngredientListDetails(ingredients: [IngredientModal])  {
        ingredientListDetailsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IngredientListDetailsViewController") as? IngredientListDetailsViewController
        if let ingredientListDetailsViewController = ingredientListDetailsViewController {
            ingredientListDetailsViewController.ingredientLisrDetailsViewModal = IngredientLisrDetailsViewModal(ingredients: ingredients)
        }
        
    }

    func callAnalyzeAPI() {
        let expectation = expectation(description: "Analyze")
        APIClient.getNutritionDetails(text: inputText) { res, error, massage  in
            if res != nil {
                let array = [res!]
                self.initIngredientListDetails(ingredients: array)
            }
            XCTAssert(res != nil, "API Failed")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 7){ error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
