//
//  NewsDetailViewController.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
	
	private var viewModel: NewsDetailViewModel!

	private let soursAndDateLabel = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.textColor = .gray
		$0.font = .systemFont(ofSize: 12, weight: .light)
		$0.numberOfLines = 0
	}
	
	private let titleLabel = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.textColor = .black
		$0.font = .systemFont(ofSize: 18, weight: .medium)
		$0.numberOfLines = 0
	}
	
	private let newsImage = with(UIImageView()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.contentMode = .scaleAspectFit
	}
	
	private let overview = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.textColor = .black
		$0.font = .systemFont(ofSize: 14, weight: .light)
		$0.numberOfLines = 0
	}
	
	private let fullNewsURL = with(UIButton(type: .system)) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.setTitle("Читать полностью", for: .normal)
		$0.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
	}
	
	func setViewModel(_ viewModel: NewsDetailViewModel) {
		self.viewModel = viewModel
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupAppearance()
		fill()
		bind(to: viewModel)
		viewModel.updateNewsImage()
	}
	
	private func fill() {
		titleLabel.text = viewModel.title
		overview.text = viewModel.overview
		soursAndDateLabel.text = viewModel.sourceName + " | " + "\(String(describing: viewModel.publishDate))"
	}
	
	private func bind(to viewModel: NewsDetailViewModel) {
		viewModel.newsImage.observe(on: self) { [weak self] in self?.updateImage(data: $0)  }
	}
	
	func updateImage(data: Data?) {
		guard let data = data else { return }
		newsImage.image = UIImage(data: data)
	}
	
	@objc func fullNewsURLTapped() {
		viewModel.clickURL()
	}
}

// MARK: - setup views and appearance

extension NewsDetailViewController {
	func setupAppearance() {
		view.backgroundColor = .systemGray5
	}

	func setupViews() {
		navigationController?.navigationBar.isHidden = false
		
		view.addSubview(soursAndDateLabel)
		view.addSubview(titleLabel)
		view.addSubview(newsImage)
		view.addSubview(overview)
		view.addSubview(fullNewsURL)
		
		fullNewsURL.addTarget(self, action: #selector(fullNewsURLTapped), for: .touchUpInside)
		
		setupConstraints()
	}

	func setupConstraints() {
		let safe = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			newsImage.topAnchor.constraint(equalTo: safe.topAnchor),
			newsImage.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
			newsImage.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
			newsImage.heightAnchor.constraint(equalToConstant: 250),
			
			soursAndDateLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5),
			soursAndDateLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 15),
			soursAndDateLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -15),
			soursAndDateLabel.heightAnchor.constraint(equalToConstant: 15),
			
			titleLabel.topAnchor.constraint(equalTo: soursAndDateLabel.bottomAnchor, constant: 5),
			titleLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 15),
			titleLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -15),
			
			overview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
			overview.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 15),
			overview.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -15),
			overview.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: fullNewsURL.topAnchor, multiplier: -5),
			
			fullNewsURL.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 10),
			fullNewsURL.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 15),
			fullNewsURL.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: safe.bottomAnchor, multiplier: -5),
		])
	}
}
