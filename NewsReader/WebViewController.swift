//
//  WebViewController.swift
//  NewsReader
//
//  Created by Andrei Vasilev on 15/04/2019.
//  Copyright © 2019 Andrei Vasilev. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: String!
    var progressView: UIProgressView!
    
    deinit {
            webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        guard let nUrl = URL(string: url) else { return }
        
        let request = URLRequest(url: nUrl)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        let flexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        
        toolbarItems = [progressButton, flexibleSpacer, refreshButton]
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationController?.isToolbarHidden = false
        navigationController?.navigationBar.isHidden = false

        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    

   

}
