//
//  Router.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol Router: AnyObject {
	func push(_ module: Presentable)
	func push(_ module: Presentable, animated: Bool)
}
