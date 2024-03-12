//
//  String+.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

extension String {
    var capitalized: String {
        guard let firstCharacter = self.first else {
            return self
        }
        return String(firstCharacter).uppercased() + self.dropFirst()
    }
}
