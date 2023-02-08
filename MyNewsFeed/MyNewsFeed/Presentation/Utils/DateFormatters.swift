//
//  DateFormatters.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 05.02.2023.
//

import Foundation

let mediumDateFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .medium
	return formatter
}()
