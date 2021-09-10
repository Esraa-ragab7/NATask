//
//  TotalNutritionTests.swift
//  NATaskTests
//
//  Created by Esraa Mohamed Ragab on 10/09/2021.
//

import XCTest
@testable import NATask

class TotalNutritionTests: XCTestCase {

    var totleNutritionViewController: TotleNutritionViewController!
    var value1 = "20"
    var value2 = "11"
    
    func testExample() throws {
        // MARK: - Case1 Success
        initTotleNutritionViewController()
        checkRound0f()
        
        // MARK: - Case2 Failure
        /*
            value1 = "21"
            value2 = "10"
            initTotleNutritionViewController()
            checkRound0f()
        */
    }
    
    func initTotleNutritionViewController() {
        totleNutritionViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TotleNutritionViewController") as? TotleNutritionViewController
        if let totleNutritionViewController = totleNutritionViewController {
            totleNutritionViewController.totalNutritionViewModal = TotalNutritionViewModal(facts: [
                Facts(label: "test1", quantity: 20.37123123, unit: "%"),
                Facts(label: "test2", quantity: 10.72132, unit: "%")
            ])
        }
    }
    
    func checkRound0f() {
        let viewModal = totleNutritionViewController.totalNutritionViewModal
        let facts = viewModal?.facts
        let resValue1 = viewModal?.round0f(quantity: facts?[0].quantity ?? 0) ?? ""
        XCTAssert(value1.elementsEqual(resValue1),"Value1 Not Equal Test1 Fact1")
        let resValue2 = viewModal?.round0f(quantity: facts?[1].quantity ?? 0) ?? ""
        XCTAssert(value2.elementsEqual(resValue2), "Value2 Not Equal Test2 Fact2")
    }

}
