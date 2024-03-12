//
//  NewsSource.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation

struct NewsSource: Codable, Equatable {
    let id: String
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url
        case category
        case language
        case country
    }
}
