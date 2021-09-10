//
//  IngredientInputTests.swift
//  NATaskTests
//
//  Created by Esraa Mohamed Ragab on 10/09/2021.
//

import XCTest
@testable import NATask

class IngredientInputTests: XCTestCase {
    
    var inputText = "2 apples \n 1 orange"
    var ingredientInputViewController: IngredientInputViewController!
    
    func testExample() throws {
        // MARK: - Case1 Success
        initIngredientInputViewController()
        addInputTextAndCheckIfAnalyzeButtonIsEnabled()
        initialStateForAnalyzeButtonTest()
        callAnalyzeAPI()
        
        // MARK: - Case2 Failure
        /*
            inputText = ""
         initIngredientInputViewController()
         addInputTextAndCheckIfAnalyzeButtonIsEnabled()
         initialStateForAnalyzeButtonTest()
         callAnalyzeAPI()
         */
    }
    
    func initIngredientInputViewController() {
        ingredientInputViewController = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IngredientInputViewController") as! IngredientInputViewController)
        let _ = ingredientInputViewController.view
    }
    
    func initialStateForAnalyzeButtonTest() {
        XCTAssertTrue(!ingredientInputViewController.inputTextView.text.isEmpty && ingredientInputViewController.analyzeButton.isEnabled,"Input Text is empty!")
    }
    
    func addInputTextAndCheckIfAnalyzeButtonIsEnabled() {
        ingredientInputViewController.inputTextView.text = inputText
        ingredientInputViewController.bind()
        XCTAssertTrue(ingredientInputViewController.analyzeButton.isEnabled,"Analyze Button is Disabled!")
    }
    
    func callAnalyzeAPI() {
        if !ingredientInputViewController.analyzeButton.isEnabled {
            XCTFail("Input Text is empty!")
        }
        let expectation = expectation(description: "Analyze")
        APIClient.getNutritionDetails(text: ingredientInputViewController.inputTextView.text) { res, error, massage  in
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
