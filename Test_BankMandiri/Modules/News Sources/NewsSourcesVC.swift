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
    private lazy var headerView: UIView = {
        let view = HeaderView(title: category.capitalized)
        view.showBackButton = true
        view.onBackButtonPressed = self.onBackButtonPressed
        return view
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()

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
        setupUI()
        setupConstraints()
        presenter?.viewDidLoad()
    }
}

// MARK: ViewProtocol
extension NewsSourcesVC: NewsSourcesViewProtocol {
    func showSourceList(_ items: [NewsSource]) {
    }
    
    func showSourceList(with error: NetworkError) {
    }
}

// MARK: Assembly
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

// MARK: Private methods
private extension NewsSourcesVC {
    func setupUI() {
        self.view.addSubview(headerView)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }

    func onBackButtonPressed() {
        debugPrint("_BQR: back button pressed")
    }
}
