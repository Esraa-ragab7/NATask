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
    static func statusCodeCheck(statusCode: Int) -> String? {
        if statusCode == 200 {
            return nil
        } else if statusCode == 304 {
            return "Not Modified"
        } else if statusCode == 404 {
            return "Not Found - The specified URL was not found or couldn't be retrieved"
        } else if statusCode == 409 {
            return "The provided ETag token does not match the input data"
        } else if statusCode == 422 {
            return "Unprocessable Entity - Couldn't parse the recipe or extract the nutritional info"
        } else if statusCode == 555 {
            return "Unprocessable Entity - Couldn't parse the recipe or extract the nutritional info"
        } else {
            return "Error"
        }
    }
    
    // MARK: - get Service With Id
    static func getNutritionDetails(text: String, completion:@escaping(IngredientModal?,Error?,String?)->Void) {
        AF.request(APIRouter.getNutritionDetails(text: text)).responseDecodable { (response: DataResponse<IngredientModal, AFError>) in
            if let statusMessage = APIClient.statusCodeCheck(statusCode:  response.response?.statusCode ?? 0) {
                completion(nil, nil, statusMessage)
                return 
            }
            switch response.result {
            case .success(let ingredientModal):
                completion(ingredientModal, nil, nil)
            case .failure(let error):
                completion(nil, error, nil)
            }
        }
    }
}
