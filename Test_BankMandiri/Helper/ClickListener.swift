//
//  ClickListener.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

class ClickListener: UITapGestureRecognizer {
    var onClick: (() -> Void)?
}
