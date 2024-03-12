//
//  UIView+.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

extension UIView {
    func onClick(action: @escaping () -> Void) {
        let tapRecognizer = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecognizer.onClick = action
        self.addGestureRecognizer(tapRecognizer)
    }

    @objc func onViewClicked(sender: ClickListener) {
        sender.onClick?()
    }
}
