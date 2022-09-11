//
//  Family.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 11.09.2022.
//

import Foundation

struct Family: Codable {
    let name: String
    let surname: String
    let status: String
    
    var fullname: String {
        "\(name) \(surname)"
    }
}
