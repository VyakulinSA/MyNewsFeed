//
//  RouterImp.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

final class RouterImp: Router{
	
	private weak var rootViewController: NavigationController?
	
	init(rootViewController: NavigationController?) {
		self.rootViewController = rootViewController
	}
	
	func push(_ module: Presentable) {
		push(module, animated: true)
	}
	
	func push(_ module: Presentable, animated: Bool) {
		guard let controller = module.toPresent() else {return}
		rootViewController?.pushViewController(controller, animated: animated)
	}
}
