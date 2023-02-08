//
//  NewsRepository.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

protocol NewsRepository {
	@discardableResult
	func fetchNewsFeed(query: NewsQuery, page: Int,
					   cached: @escaping (NewsPage) -> Void,
					   completion: @escaping (Result<NewsPage, Error>) -> Void) -> Cancellable?
}
