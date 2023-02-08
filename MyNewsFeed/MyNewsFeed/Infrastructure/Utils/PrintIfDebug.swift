//
//  PrintIfDebug.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 08.02.2023.
//

import Foundation

func printIfDebug(_ string: String) {
	#if DEBUG
	print(string)
	#endif
}
