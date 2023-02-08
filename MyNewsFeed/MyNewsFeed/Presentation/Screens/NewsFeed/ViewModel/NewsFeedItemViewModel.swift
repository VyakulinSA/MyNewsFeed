//
//  NewsFeedItemViewModel.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 05.02.2023.
//

import Foundation

struct NewsFeedItemViewModel: Equatable {
	let urlToImage: String?
	let sourceName: String
	let publishDate: String
	let title: String
	var viewsCounter: Int
	let url: String
}

extension NewsFeedItemViewModel {

	init(news: News, viewsCounter: Int) {
		self.title = news.title
		self.sourceName = news.sourceName
		self.urlToImage = news.urlToImage
		self.url = news.url
		self.viewsCounter = viewsCounter
		if let publishDate = news.publishedAt {
			self.publishDate = "\(mediumDateFormatter.string(from: publishDate))"
		} else {
			self.publishDate = NSLocalizedString("TBD", comment: "")
		}
	}
}
