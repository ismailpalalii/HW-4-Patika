//
//  WebViewContainerViewController.swift
//  UIComponents
//
//  Created by Semih Emre ÜNLÜ on 9.01.2022.
//

import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWebView()
        configureActivityIndicator()
    }

    var urlString = "https://www.google.com"

    func configureWebView() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
//        webView.configuration = configuration
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.isLoading),
                            options: .new,
                            context: nil)
        webView.load(urlRequest)
        
        // Create Html String
        let htmlString = """
            <style>
            @font-face
            {
                font-family: 'Open Sans';
                font-weight: normal;
                src: url(OpenSans-Regular.ttf);
            }
            @font-face
            {
                font-family: 'Open Sans';
                font-weight: bold;
                src: url(OpenSans-Bold.ttf);
            }
            @font-face
            {
                font-family: 'Open Sans';
                font-weight: 1500;
                src: url(OpenSans-ExtraBold.ttf);
            }
            @font-face
            {
                font-family: 'Open Sans';
                font-weight: 1000;
                src: url(OpenSans-Light.ttf);
            }
            @font-face
            {
                font-family: 'Open Sans';
                font-weight: 1000;
                src: url(OpenSans-Semibold.ttf);
            }
            </style>
            <span style="font-family: 'Open Sans'; font-weight: bold; font-size: 100; color: red">(Hello World !)</span>
            """
            // Call Html String
            webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }

    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        if keyPath == "loading" {
            webView.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }

    }

    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
}

extension WebViewContainerViewController: WKNavigationDelegate {

}

extension WebViewContainerViewController: WKUIDelegate {

}
