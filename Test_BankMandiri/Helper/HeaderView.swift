//
//  HeaderView.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    private lazy var backButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.backward.circle")?
            .tinted(with: .black)
        imageView.snp.makeConstraints {
            $0.size.equalTo(24.0)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        if let action = self.onBackButtonPressed {
            imageView.onClick(action: action)
        }
        return imageView
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 8.0
        view.addArrangedSubview(self.backButton)
        view.addArrangedSubview(self.label)
        return view
    }()

    var onBackButtonPressed: (() -> Void)?
    var showBackButton: Bool = false {
        didSet {
            backButton.isHidden = !showBackButton
        }
    }

    convenience init(title: String) {
        self.init(frame: .zero)
        self.label.text = title
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(40.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
