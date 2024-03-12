//
//  NewsSourcesImplementer.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

class NewsSourcesInteractor: NewsSourcesInteractorProtocol {
    weak var presenter: NewsSourcesPresenter?
    private let selectedCategory: String

    init(selectedCategory: String) {
        self.selectedCategory = selectedCategory
    }

    func fetchSourceList() {
        guard let url = NetworkClient.shared.buildURL(baseURL: "https://newsapi.org", 
                                                      path: "/v2/top-headlines/sources",
                                                      queryItems: [.init(name: "category", value: "business")])
        else {
            presenter?.didFetchSourceList(with: NetworkError.invalidURL)
            return
        }{
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

    func didFetchSourceList(sources: [NewsSource]) {
        view?.showSourceList(sources)
    }

    func didFetchSourceList(with error: NetworkError) {
        view?.showSourceList(with: error)
    }
}

class NewsSourcesRouter: NewsSourcesRouterProtocol {
    weak var view: UIViewController?

    func navigateToArticleList() {
    }
}
