//
//  NewsSourcesProtocols.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

protocol NewsSourcesViewProtocol: AnyObject {
    func showSourceList(_ items: [NewsSource])
    func showSourceList(with error: NetworkError)
}

protocol NewsSourcesInteractorProtocol {
    func fetchSourceList()
}

protocol NewsSourcesPresenterProtocol {
    func viewDidLoad()
    func onSourceItemTapped()
    func onBackButtonPressed()
}

protocol NewsSourcesRouterProtocol {
    func navigateToArticleList()
    func navigateToPreviousPage()
}
