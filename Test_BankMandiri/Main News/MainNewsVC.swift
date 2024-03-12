//
//  MainNewsVC.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import UIKit
import SnapKit

class MainNewsVC: UIViewController {
    private lazy var headerView: UIView = {
        let view = HeaderView(title: "Categories")
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCategoryCollectionCell.self, forCellWithReuseIdentifier: NewsCategoryCollectionCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        return collectionView
    }()

    var presenter: MainNewsPresenterProtocol?
    private var categories: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

// MARK: MainNewsViewProtocol
extension MainNewsVC: MainNewsViewProtocol {
    func showCategoryList(_ items: [String]) {
        categories = items
        collectionView.reloadData()
    }
}

// MARK: Private methods
private extension MainNewsVC {
    func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(collectionView)
    }

    func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom
                .equalToSuperview()
        }
    }
}

// MARK: Assembly
extension MainNewsVC {
    class Assembly {
        static func createModule() -> UIViewController {
            let view = MainNewsVC()
            let presenter = MainNewsPresenter()
            let interactor = MainNewsInteractor()
            let router = MainNewsRouter()
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

// MARK: UICollectionView Delegates
extension MainNewsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCategoryCollectionCell.reuseIdentifier, for: indexPath) as! NewsCategoryCollectionCell
        cell.label.text = categories[indexPath.item].capitalized
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection
        let selectedItem = categories[indexPath.item]
        presenter?.onCategoryItemTapped(category: selectedItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 20 // Adding padding
        return CGSize(width: width, height: 40) // Adjust height as needed
    }
}
