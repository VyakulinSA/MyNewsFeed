//
//  NewsFeedItemCell.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation
import UIKit


final class NewsFeedItemCell: UICollectionViewCell {
	
	private var viewModel: NewsFeedItemViewModel!
	private var newsImagesRepository: NewsImagesRepository?
	private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
	
	private let imageView = with(UIImageView()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .systemGray3
	}
	
	private var soursAndDateLabel = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.textColor = .gray
		$0.font = .systemFont(ofSize: 12, weight: .light)
		$0.numberOfLines = 0
	}
	
	private var titleLabel = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.textColor = .black
		$0.font = .systemFont(ofSize: 18, weight: .medium)
		$0.numberOfLines = 0
	}
	
	private let viewsCounterImage = with(UIImageView(image: UIImage(systemName: "eye")!)) {
		$0.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private let viewsCounterLabel = with(UILabel()) {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.textColor = .gray
		$0.font = .systemFont(ofSize: 11, weight: .regular)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupAppearance()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func fill(with viewModel: NewsFeedItemViewModel, newsImagesRepository: NewsImagesRepository?) {
		self.viewModel = viewModel
		self.newsImagesRepository = newsImagesRepository

		titleLabel.text = viewModel.title
		soursAndDateLabel.text = viewModel.sourceName + " | " + viewModel.publishDate
		viewsCounterLabel.text = "\(viewModel.viewsCounter)"
		
		updateNewsImage()
	}
	
	private func updateNewsImage() {
		imageView.image = nil
		guard let newsImagePath = viewModel.urlToImage else { return }
		
		imageLoadTask = newsImagesRepository?.fetchImage(with: newsImagePath, isFullPath: true) { [weak self] result in
			guard let self = self else { return }
			guard self.viewModel.urlToImage == newsImagePath else { return }
			if case let .success(data) = result {
				self.imageView.image = UIImage(data: data)
			}
			self.imageLoadTask = nil
		}
	}
}

// MARK: - Setup views and appearance

extension NewsFeedItemCell {
	
	private func setupViews() {
		contentView.addSubview(imageView)
		contentView.addSubview(soursAndDateLabel)
		contentView.addSubview(titleLabel)
		contentView.addSubview(viewsCounterImage)
		contentView.addSubview(viewsCounterLabel)
		
		setupConstraints()
	}
	
	private func setupAppearance() {
		backgroundColor = .systemGray6
		contentView.layer.cornerRadius = 15
		contentView.layer.borderColor = UIColor.gray.cgColor
		contentView.layer.borderWidth = 0.3
		contentView.clipsToBounds = true
		layer.cornerRadius = 15
		
		viewsCounterImage.tintColor = .gray
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2),
			
			soursAndDateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
			soursAndDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
			soursAndDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
			soursAndDateLabel.heightAnchor.constraint(equalToConstant: 15),
			
			titleLabel.topAnchor.constraint(equalTo: soursAndDateLabel.bottomAnchor, constant: 5),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
			titleLabel.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: viewsCounterImage.topAnchor, multiplier: -5),
			
			viewsCounterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
			viewsCounterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
			viewsCounterImage.widthAnchor.constraint(equalToConstant: 15),
			viewsCounterImage.heightAnchor.constraint(equalToConstant: 15),
			
			viewsCounterLabel.leadingAnchor.constraint(equalTo: viewsCounterImage.trailingAnchor, constant: 2),
			viewsCounterLabel.bottomAnchor.constraint(equalTo: viewsCounterImage.bottomAnchor),
			viewsCounterLabel.topAnchor.constraint(equalTo: viewsCounterImage.topAnchor)
		])
	}
}
