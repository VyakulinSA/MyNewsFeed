//
//  ModulesFactory.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol ScreensFactory{
	func makeNewsFeedScreen(actions: NewsFeedViewModelActions) -> NewsFeedViewController
	func makeNewsDetailScreen(news: News, actions: NewsDetailViewModelActions)-> NewsDetailViewController
	func makeFullNewsWebScreen(url: String) -> FullNewsWebViewController
}
