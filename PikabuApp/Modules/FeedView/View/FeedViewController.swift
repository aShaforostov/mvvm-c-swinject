//
//  FeedViewController.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FeedViewController: UIViewController {

    var feedViewModel: FeedViewModelProtocol?

    init(feedViewModel: FeedViewModelProtocol?) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()

        let settingsButton = UIBarButtonItem.menuButton(self, action: nil, image: Asset.settings.image)
        (settingsButton.customView as? UIButton)?.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] (_) in
                self?.feedViewModel?.showSortSheet()
            }).disposed(by: self.disposeBag)

        self.navigationItem.setRightBarButton(settingsButton, animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostPreviewTableViewCell.self, forCellReuseIdentifier: PostPreviewTableViewCell.reuseIdentifier())
        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        return tableView
    }()

    private func bindUI() {
        guard let viewModel = self.feedViewModel else {
            fatalError("ViewModel must ne not nil")
        }

        viewModel.reloadHandler
            .flatMap({ viewModel.posts })
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: self.disposeBag)

        self.tableView.rx
            .modelSelected(PostPreviewCellModel.self)
            .subscribe(onNext: { [weak self] (model) in
                self?.feedViewModel?.openPost(postID: model.model.postId)
            }).disposed(by: self.disposeBag)

        viewModel.reload(sortOrder: .dateNew)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUI()
        self.view.backgroundColor = Design.Colors.mainBackground
    }

}
