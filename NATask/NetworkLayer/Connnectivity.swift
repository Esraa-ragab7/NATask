//
//  Connnectivity.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 10/09/2021.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
