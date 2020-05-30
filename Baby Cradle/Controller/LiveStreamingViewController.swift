//
//  LiveStreamingViewController.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/6/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

//import UIKit
//import WebKit
//
//class LiveStreamingViewController: UIViewController  {
//
//    var myPlayer: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Setting up WebView
//        let webConfiguration = WKWebViewConfiguration()
//        webConfiguration.allowsInlineMediaPlayback = true
//        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
//
//        myPlayer = WKWebView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), configuration: webConfiguration)
//        self.view.addSubview(myPlayer)
//
//        if let videoURL:URL = URL(string: "http://www.google.com") {
//             let request:URLRequest = URLRequest(url: videoURL)
//             myPlayer.load(request)
//            }
//
//    }
//}

import UIKit
import WebKit
class LiveStreamingViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://www.youtube.com/embed/RmHqOSrkZnk")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

//"http://156.217.215.249:8080/stream"
