//
//  AppConfiguration.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

final class AppConfiguration {
	lazy var apiKey: String = {
		return "d631cfd4c9594c6cb5e445c280426208"
	}()
	lazy var apiBaseURL: String = {
		return "https://newsapi.org/"
	}()
}
