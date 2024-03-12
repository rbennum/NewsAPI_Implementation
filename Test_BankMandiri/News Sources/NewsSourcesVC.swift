//
//  NewsSourcesVC.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit
import SnapKit

class NewsSourcesVC: UIViewController {
    var presenter: NewsSourcesPresenterProtocol?
    private let category: String

    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension NewsSourcesVC: NewsSourcesViewProtocol {
    func showSourceList(_ items: [NewsSource]) {
    }
    
    func showSourceList(with error: NetworkError) {
    }
}

extension NewsSourcesVC {
    class Assembly {
        static func createModule(category: String) -> UIViewController {
            let view = NewsSourcesVC(category: category)
            let presenter = NewsSourcesPresenter()
            let interactor = NewsSourcesInteractor(selectedCategory: category)
            let router = NewsSourcesRouter()
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            router.view = view
            return view
        }
    }
}
