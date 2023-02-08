//
//  CoordinatorOutput.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 03.02.2023.
//

import Foundation

protocol CoordinatorOutput: AnyObject{
	var finishFlow: (()->Void)? { get set }
}
