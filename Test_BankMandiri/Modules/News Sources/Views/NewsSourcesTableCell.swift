//
//  NewsSourcesTableCell.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

class NewsSourcesTableCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18.0, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14.0, weight: .regular)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 8.0
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(descriptionLabel)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(item: NewsSource) {
        titleLabel.text = item.name
        descriptionLabel.text = item.description ?? "No description provided."
    }
}
