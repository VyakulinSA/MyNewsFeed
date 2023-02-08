//
//  CoordinatorsFactory.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol CoordinatorsFactory: AnyObject{
	func makeApplicationCoordinator(windowsFactory: WindowsFactory) -> Coordinator
	func makeNewsFeedCoordinator() -> Coordinator
	func makeNewsDetailCoordinator(news: News) -> CoordinatorWithFinish
}
