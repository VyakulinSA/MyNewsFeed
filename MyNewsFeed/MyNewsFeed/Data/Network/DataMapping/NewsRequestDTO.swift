//
//  NewsRequestDTO.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

struct NewsRequestDTO: Codable {
	let country: String
	let page: Int
	let pageSize: Int
}
