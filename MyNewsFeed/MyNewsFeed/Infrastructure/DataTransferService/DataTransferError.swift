//
//  DataTransferError.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 08.02.2023.
//

import Foundation

public enum DataTransferError: Error {
	case noResponse
	case parsing(Error)
	case networkFailure(NetworkError)
	case resolvedNetworkFailure(Error)
}
