//
//  NewsDetailViewModel.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation


struct NewsDetailViewModelActions {
	let showFullNews: (String) -> Void
	let backBattonTapped: () -> Void
}

protocol NewsDetailViewModelInput {
	func clickURL()
	func updateNewsImage()
}

protocol NewsDetailViewModelOutput {
	var urlToImage: String? { get }
	var sourceName: String { get }
	var publishDate: String { get }
	var title: String { get }
	var overview: String { get }
	var fullNewsURL: String { get }
	var newsImage: Observable<Data?> { get }
}

final class NewsDetailViewModel: NewsDetailViewModelOutput {
	
	private let actions: NewsDetailViewModelActions?
	private let newsImagesRepository: NewsImagesRepository?
	private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
	
	// MARK: - OUTPUT
	
	var urlToImage: String?
	var sourceName: String
	var publishDate: String
	var title: String
	var overview: String
	var fullNewsURL: String
	let newsImage: Observable<Data?> = Observable(nil)
	
	// MARK: - init
	
	init(news: News, actions: NewsDetailViewModelActions, newsImagesRepository: NewsImagesRepository?){
		self.urlToImage = news.urlToImage
		self.sourceName = news.sourceName
		self.title = news.title
		self.overview = news.description ?? ""
		self.fullNewsURL = news.url
		self.actions = actions
		self.newsImagesRepository = newsImagesRepository
		if let publishDate = news.publishedAt {
			self.publishDate = "\(mediumDateFormatter.string(from: publishDate))"
		} else {
			self.publishDate = NSLocalizedString("TBD", comment: "")
		}
	}
}

// MARK: - INPUT. View event methods

extension NewsDetailViewModel: NewsDetailViewModelInput {
	
	func clickURL() {
		actions?.showFullNews(fullNewsURL)
	}
	
	func updateNewsImage() {
		guard let urlToImage = urlToImage else { return }
		
		imageLoadTask = newsImagesRepository?.fetchImage(with: urlToImage, isFullPath: true) { result in
			guard self.urlToImage == urlToImage else { return }
			switch result {
			case .success(let data):
				self.newsImage.value = data
			case .failure: break
			}
			self.imageLoadTask = nil
		}
	}
}

