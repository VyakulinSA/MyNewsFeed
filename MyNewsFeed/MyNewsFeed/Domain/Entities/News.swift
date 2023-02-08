//
//  News.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

struct News: Equatable {
	let sourceName: String
	let title: String
	let description: String?
	let url: String
	let urlToImage: String?
	let publishedAt: Date?
}

struct NewsPage: Equatable {
	let page: Int
	let totalResults: Int
	let news: [News]
}
