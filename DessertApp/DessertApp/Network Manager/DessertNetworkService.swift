//
//  DessertNetworkService.swift
//  DessertApp
//
//  Created by Fabrice Gehy on 8/28/24.
//

import Foundation

protocol DessertNetworkService {
    var endpoint: String { get }
    
    func getDessert() -> DessertsDTO
    func getDessertDetails(id: String) -> DessertsDTO
}
