//
//  ConnectionError.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 05.02.2023.
//

import Foundation

public protocol ConnectionError: Error {
	var isInternetConnectionError: Bool { get }
}

public extension Error {
	var isInternetConnectionError: Bool {
		guard let error = self as? ConnectionError, error.isInternetConnectionError else {
			return false
		}
		return true
	}
}
