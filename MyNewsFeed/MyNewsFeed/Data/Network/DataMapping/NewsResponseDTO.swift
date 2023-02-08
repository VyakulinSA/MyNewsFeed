//
//  NewsResponseDTO.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

struct NewsResponseDTO: Codable {
	let totalResults: Int
	let articles: [NewsDTO]
}

extension NewsResponseDTO {
	struct NewsDTO: Codable {
		let source: Source
		let title: String
		let description: String?
		let url: String
		let urlToImage: String?
		let publishedAt: String?
	}
}

extension NewsResponseDTO {
	struct Source: Codable {
		let name: String
	}
}

// MARK: - Mappings to Domain

extension NewsResponseDTO {
	func toDomain(page: Int) -> NewsPage {
		return .init(page: page,totalResults: totalResults,
					 news: articles.map { $0.toDomain() })
	}
}

extension NewsResponseDTO.NewsDTO {
	func toDomain() -> News {
		return .init(sourceName: source.name,
					 title: title,
					 description: description,
					 url: url,
					 urlToImage: urlToImage,
					 publishedAt: dateFormatter.date(from: publishedAt ?? ""))
	}
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
	
	let dateFormatter = DateFormatter()
	dateFormatter.locale = Locale(identifier: "en_US_POSIX")
	dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
	return dateFormatter
}()
