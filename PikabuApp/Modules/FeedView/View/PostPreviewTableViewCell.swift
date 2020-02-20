//
//  PostPreviewTableViewCell.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift

class PostPreviewTableViewCell: UITableViewCell {

    private var disposeBag = DisposeBag()

    var expandCellObservable: Observable<Void>?

    private lazy var mainView: PostView = {
        let view = PostView()

        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])

        return view
    }()

    func setup(model: PostPreviewCellModel) {
        self.mainView.model = model
        self.expandCellObservable = self.mainView.readMoreObservable
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = Design.Colors.mainBackground
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 16.0)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }

}
