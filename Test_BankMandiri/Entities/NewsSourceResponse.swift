//
//  NewsSourceResponse.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation

struct NewsSourceResponse: Codable, Equatable {
    let status: String
    let sources: [NewsSource]?

    enum CodingKeys: String, CodingKey {
        case status
        case sources
    }
}
