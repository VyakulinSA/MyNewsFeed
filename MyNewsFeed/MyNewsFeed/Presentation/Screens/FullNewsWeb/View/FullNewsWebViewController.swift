//
//  FullNewsWebViewController.swift
//  MyNewsFeed
//
//  Created by Вякулин Сергей on 04.02.2023.
//

import UIKit
import WebKit

class FullNewsWebViewController: UIViewController, WKUIDelegate {
	
	var webView: WKWebView!
	private var url: String?
	
	func setUrl(url: String) {
		self.url = url
	}
	
	override func loadView() {
		let webConfiguration = WKWebViewConfiguration()
		webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.uiDelegate = self
		view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let url = url else {return}
		let myURL = URL(string:url)
		let myRequest = URLRequest(url: myURL!)
		webView.load(myRequest)
	}
}
