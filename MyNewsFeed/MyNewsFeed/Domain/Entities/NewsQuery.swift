//
//  NewsQuery.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

struct NewsQuery: Equatable {
	var country: String = "ru"
	var pageSize: Int = 20
}
