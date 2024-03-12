//
//  MainNewsImplementer.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

// Interactor
class MainNewsInteractor: MainNewsInteractorProtocol {
    weak var presenter: MainNewsPresenter?

    func fetchCategoryList() {
        presenter?.didFetchCategoryList(
            [
                "business",
                "entertainment",
                "general",
                "health",
                "science",
                "sport",
                "technology"
            ]
        )
    }
}

// Presenter
class MainNewsPresenter: MainNewsPresenterProtocol {
    weak var view: MainNewsViewProtocol?
    var interactor: MainNewsInteractorProtocol?
    var router: MainNewsRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchCategoryList()
    }

    func didFetchCategoryList(_ items: [String]) {
        view?.showCategoryList(items)
    }

    func onCategoryItemTapped(category: String) {
        router?.navigateToDetail(by: category)
    }
}

// Router (Coordinator)
class MainNewsRouter: MainNewsRouterProtocol {
    weak var view: UIViewController?

    func navigateToDetail(by category: String) {
        let sourceVC = NewsSourcesVC.Assembly.createModule(category: category)
        view?.navigationController?.pushViewController(sourceVC, animated: true)
    }
}
