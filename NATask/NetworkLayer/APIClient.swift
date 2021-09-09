//
//  APIClient.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation
import Alamofire

class APIClient {
    // MARK: - API Requests Method
    
    // MARK: - get Service With Id
    static func getNutritionDetails(text: String, completion:@escaping(IngredientModal?,Error?)->Void) {
        AF.request(APIRouter.getNutritionDetails(text: text)).responseDecodable { (response: DataResponse<IngredientModal, AFError>) in
            switch response.result {
            case .success(let ingredientModal):
                completion(ingredientModal,nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
