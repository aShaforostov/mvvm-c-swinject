//
//  PostView.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostView: UIView {

    var readMoreObservable: Observable<Void> {
        return self.readMoreButton.rx
            .tap
            .asObservable()
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = Design.Colors.mainTitleColor
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0)
        ])

        return label
    }()

    private lazy var descriptionlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = Design.Colors.mainDescriptionColor
        label.lineBreakMode = .byTruncatingTail
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 16.0),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 14.0)
        ])

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = Design.Colors.mainTitleColor
        label.lineBreakMode = .byTruncatingTail
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.descriptionlabel.bottomAnchor, constant: 32.0),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 10.0),
            label.heightAnchor.constraint(equalToConstant: 14.0)
        ])

        return label
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14.0)
        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            label.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 10.0),
            label.heightAnchor.constraint(equalToConstant: 14.0)
        ])

        return label
    }()

    private func textColorForRating(rating: Int) -> UIColor {
        switch rating {
        case 0:
            return Design.Colors.mainTitleColor
        case ..<0:
            return UIColor.red
        default:
            return UIColor.green
        }
    }

    private lazy var readMoreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.green, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.expand, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        self.addSubview(button)

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.topAnchor.constraint(equalTo: self.descriptionlabel.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 32.0)
        ])

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.label.topAnchor, constant: -16.0),
            self.bottomAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 16.0)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: PostPreviewCellModel? {
        didSet {
            self.updateUI()
        }
    }

    private func updateUI() {
        self.descriptionlabel.numberOfLines = (self.model?.expanded ?? false) ? 0 : 2
        self.label.text = self.model?.model.title
        self.descriptionlabel.text = self.model?.model.preview_text

        if let timeStamp = model?.model.timeshamp {
            let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(timeStamp)))
            self.dateLabel.text = date.timeAgoSinceDate()
        }

        if let rating = model?.model.likes_count {
            self.ratingLabel.text = "\(rating)"
            self.ratingLabel.textColor = self.textColorForRating(rating: rating)
        }

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.readMoreButton.isHidden = (self.model?.expanded ?? false) || self.descriptionlabel.maxNumberOfLines <= 2
    }

}
