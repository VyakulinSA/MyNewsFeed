//
//  DataTransferError+ConnectionError.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 05.02.2023.
//

import Foundation

extension DataTransferError: ConnectionError {
	public var isInternetConnectionError: Bool {
		guard case let DataTransferError.networkFailure(networkError) = self,
			case .notConnected = networkError else {
				return false
		}
		return true
	}
}
