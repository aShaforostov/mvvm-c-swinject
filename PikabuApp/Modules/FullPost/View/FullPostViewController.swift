//
//  FullPostViewController.swift
//  Pikabu
//
//  Created by Alexey Shaforostov on 20.02.2020
//  Copyright © 2019 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift

class FullPostViewController: UIViewController {

    private var viewModel: FullPostViewModelProtocol?

    private let disposeBag = DisposeBag()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        return indicator
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isHidden = true
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)

        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false

        self.scrollView.addSubview(view)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = Design.Colors.mainDescriptionColor
        self.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32.0),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -32),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0)
        ])

        return label
    }()

    private lazy var descriptionlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = Design.Colors.mainDescriptionColor
        label.lineBreakMode = .byTruncatingTail
        self.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16.0),
            label.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 14.0)
        ])

        return label
    }()

    private lazy var imageStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.isUserInteractionEnabled = false
        self.contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.descriptionlabel.bottomAnchor, constant: 32.0),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10.0)
        ])

        return stackView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = Design.Colors.mainTitleColor
        label.lineBreakMode = .byTruncatingTail
        self.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.imageStack.bottomAnchor, constant: 32.0),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -32),
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
        self.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32),
            label.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 10.0),
            label.heightAnchor.constraint(equalToConstant: 14.0)
        ])

        return label
    }()

    init(viewModel: FullPostViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func loadView() {
        super.loadView()
        self.contentView.layoutIfNeeded()
        self.activityIndicator.startAnimating()
        self.view.backgroundColor = Design.Colors.mainBackground
        self.bindUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindUI() {
        self.viewModel?.model
            .subscribe(onNext: { [weak self] (model) in
                self?.updateUI(model: model)
            }).disposed(by: self.disposeBag)
    }

    func updateUI(model: PostFullModel) {

        self.titleLabel.text = model.title
        self.descriptionlabel.text = model.text

        if let timeStamp = model.timeshamp {
            let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(timeStamp)))
            self.dateLabel.text = date.timeAgoSinceDate()
        }

        if let rating = model.likes_count {
            self.ratingLabel.text = "\(rating)"
            self.ratingLabel.textColor = Design.Colors.mainTitleColor
        }

        guard let viewModel = self.viewModel, let images = model.images, images.count > 0 else {
            self.calculateContentSize()
            return
        }

        let zipped = Completable.zip(viewModel.imageRequests(images: images))

        zipped.subscribe(onCompleted: { [weak self] in
            self?.addImages(images: images)
            self?.calculateContentSize()
        }) { [weak self] (_) in
            self?.calculateContentSize()
        }.disposed(by: self.disposeBag)
    }

    private func addImages(images: [String]) {
        let imagesNames = images.map({ URL(string: $0)!.lastPathComponent })
        let images = imagesNames.map({ self.viewModel?.getImage(named: $0) })

        for image in images {
            guard let image = image else {
                continue
            }

            DispatchQueue.main.async {
                let imageView = UIImageView()
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                let ratio = image.size.width / image.size.height
                imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.scrollView.frame.width / ratio)
                let newHeight = imageView.frame.width / ratio
                NSLayoutConstraint.activate([
                    imageView.heightAnchor.constraint(equalToConstant: newHeight)
                ])
                self.imageStack.addArrangedSubview(imageView)
            }
        }
    }

    private func calculateContentSize() {

        DispatchQueue.main.async {
            self.contentView.layoutIfNeeded()
            self.scrollView.isHidden = false
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentView.frame.height)
            self.activityIndicator.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.dateLabel.bottomAnchor)
        ])
    }

}
