//
//  ViewController.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import UIKit

final class NewsFeedViewController: UIViewController {
	
	private var viewModel: NewsFeedViewModel!
	private var newsImagesRepository: NewsImagesRepository?
	private let newsFeedCollectionView = NewsFeedCollectionView()
	
	let errorView = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .errorViewBackgroundColor
		$0.font = .systemFont(ofSize: 12, weight: .regular)
		$0.textColor = .red
		$0.alpha = 0
		$0.textAlignment = .center
	}

	func setViewModel(_ viewModel: NewsFeedViewModel) {
		self.viewModel = viewModel
	}
	
	func setImagesRepository(_ newsImagesRepository: NewsImagesRepository?) {
		self.newsImagesRepository = newsImagesRepository
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupAppearance()
		viewModel.viewDidLoad()
		bind(to: viewModel)
	}
	
	private func bind(to viewModel: NewsFeedViewModel){
		viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
		viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
	}
	
	private func showError(_ error: String) {
		guard !error.isEmpty else { return }
		errorView.text = error
		UIView.animate(withDuration: 1) {
			self.errorView.alpha = 1
		}
		UIView.animate(withDuration: 3) {
			self.errorView.alpha = 0
		}
	}
	
	private func updateItems() {
		newsFeedCollectionView.reloadData()
	}
}

// MARK: - setup views and appearance

extension NewsFeedViewController {
	private func setupViews() {
		newsFeedCollectionView.viewModel = viewModel
		newsFeedCollectionView.newsImagesRepository = newsImagesRepository
		
		view.addSubview(newsFeedCollectionView)
		view.addSubview(errorView)
		
		let safe = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			errorView.topAnchor.constraint(equalTo: safe.topAnchor),
			errorView.leftAnchor.constraint(equalTo: safe.leftAnchor),
			errorView.rightAnchor.constraint(equalTo: safe.rightAnchor),
			errorView.heightAnchor.constraint(equalToConstant: 20),
			
			newsFeedCollectionView.topAnchor.constraint(equalTo: safe.topAnchor),
			newsFeedCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			newsFeedCollectionView.leftAnchor.constraint(equalTo: safe.leftAnchor),
			newsFeedCollectionView.rightAnchor.constraint(equalTo: safe.rightAnchor)
		])
	}
	
	private func setupAppearance() {
		view.backgroundColor = .systemGray5
	}
}



