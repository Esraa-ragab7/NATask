//
//  APIRouter.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case getNutritionDetails(text: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getNutritionDetails:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getNutritionDetails:
            return "nutrition-data"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getNutritionDetails:
            return nil
        }
    }
    
    // MARK: - Queries
    private var queries: [Queries]? {
        switch self {
        case .getNutritionDetails(let text):
            return [
                Queries.init(key: "ingr", value: text),
                Queries.init(key: "app_id", value: Constants.ProductionServer.appID),
                Queries.init(key: "app_key", value: Constants.ProductionServer.appKey)
            ]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var url = Constants.ProductionServer.baseURL
        if path.contains("http") {
            url = ""
        }
        var components = URLComponents(string: "\(url)\(path)")!
        
        // Add Queries
        if let queries = queries {
            components.queryItems = [URLQueryItem]()
            for query in queries {
                let queryItem = URLQueryItem(name: query.key, value: query.value)
                components.queryItems!.append(queryItem)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        var urlRequest = URLRequest(url: components.url!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

struct Queries {
    let key: String
    let value: String
}
