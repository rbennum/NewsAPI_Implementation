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
        return view
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.tintColor = .systemBlue
        view.hidesWhenStopped = true
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .singleLine
        view.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        view.register(NewsSourcesTableCell.self, forCellReuseIdentifier: NewsSourcesTableCell.reuseIdentifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    var presenter: NewsSourcesPresenterProtocol?
    private let category: String
    private var sourceList: [NewsSource] = []
    private var isError: Bool = false

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
        activityIndicator.startAnimating()
        presenter?.viewDidLoad()
    }
}

// MARK: ViewProtocol
extension NewsSourcesVC: NewsSourcesViewProtocol {
    func showSourceList(_ items: [NewsSource]) {
        activityIndicator.stopAnimating()
        isError = false
        sourceList = items
        tableView.reloadData()
    }
    
    func showSourceList(with error: NetworkError) {
        activityIndicator.stopAnimating()
        isError = true
        tableView.reloadData()
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
        self.view.addSubview(activityIndicator)
        self.view.addSubview(tableView)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom
                .equalToSuperview()
        }
    }
}

extension NewsSourcesVC: UITableViewDelegate {
    
}

extension NewsSourcesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isError {
            return 1
        }
        return sourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isError {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsSourcesTableCell.reuseIdentifier, for: indexPath) as? NewsSourcesTableCell
        guard let cell = cell else { return UITableViewCell() }
        let item = sourceList[indexPath.row]
        cell.bind(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }
}
