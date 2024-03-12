//
//  NewsSourcesImplementer.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

// MARK: Interactor Protocol
class NewsSourcesInteractor: NewsSourcesInteractorProtocol {
    weak var presenter: NewsSourcesPresenter?
    private let selectedCategory: String

    init(selectedCategory: String) {
        self.selectedCategory = selectedCategory
    }

    func fetchSourceList() {
        guard let url = NetworkClient.shared.buildURL(
            baseURL: "https://newsapi.org",
            path: "/v2/top-headlines/sources",
            queryItems: [.init(name: "category", value: selectedCategory)]
        ) else {
            presenter?.didFetchSourceList(with: NetworkError.invalidURL)
            return
        }
        NetworkClient.shared.sendRequest(with: url, type: NewsSourceResponse.self) {
            switch $0 {
            case .success(let response):
                self.presenter?.didFetchSourceList(sources: response.sources ?? [])
            case .failure(let error):
                self.presenter?.didFetchSourceList(with: error as! NetworkError)
            }
        }
    }
}

// MARK: Presenter Protocol
class NewsSourcesPresenter: NewsSourcesPresenterProtocol {
    weak var view: NewsSourcesViewProtocol?
    var interactor: NewsSourcesInteractorProtocol?
    var router: NewsSourcesRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchSourceList()
    }

    func onSourceItemTapped() {
        router?.navigateToArticleList()
    }

    func onBackButtonPressed() {
        router?.navigateToPreviousPage()
    }

    // MARK: - Interactor-side Methods
    func didFetchSourceList(sources: [NewsSource]) {
        view?.showSourceList(sources)
    }

    func didFetchSourceList(with error: NetworkError) {
        view?.showSourceList(with: error)
    }
}

// MARK: Router Protocol
class NewsSourcesRouter: NewsSourcesRouterProtocol {
    weak var view: UIViewController?

    func navigateToArticleList() {
        // TODO: assign method here
    }

    func navigateToPreviousPage() {
        view?.navigationController?.popViewController(animated: true)
    }
}
