//
//  InitialVC.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import UIKit

class InitialVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] timer in
            let vc = MainNewsVC.Assembly.createModule()
            self?.navigationController?.setViewControllers([vc], animated: true)
            timer.invalidate()
        }
    }
}
