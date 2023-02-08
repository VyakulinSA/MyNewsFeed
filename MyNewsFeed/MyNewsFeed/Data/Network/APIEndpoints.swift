//
//  APIEndpoints.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import Foundation

struct APIEndpoints {
	
	static func getNews(with newsRequestDTO: NewsRequestDTO) -> Endpoint<NewsResponseDTO> {
		
		return Endpoint(path: "v2/top-headlines",
						method: .get,
						queryParametersEncodable: newsRequestDTO)
	}
	
	static func getNewsImge(path: String, isFullPath: Bool) -> Endpoint<Data> {
		
		return Endpoint(path: path,
						isFullPath: isFullPath,
						method: .get,
						responseDecoder: RawDataResponseDecoder())
	}
}
