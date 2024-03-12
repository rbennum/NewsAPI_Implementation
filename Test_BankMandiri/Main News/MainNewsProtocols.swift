//
//  MainNewsProtocols.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

protocol MainNewsViewProtocol: AnyObject {
    func showCategoryList(_ items: [String])
}

protocol MainNewsInteractorProtocol {
    func fetchCategoryList()
}

protocol MainNewsPresenterProtocol {
    func viewDidLoad()
    func onCategoryItemTapped(category: String)
}

protocol MainNewsRouterProtocol {
    func navigateToDetail(by category: String)
}
