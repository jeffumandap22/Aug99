//
//  GitHubWebViewController.swift
//  August99-GithubDM
//
//  Created by Jeff Umandap on 5/20/21.
//

import UIKit
import WebKit

class GitHubWebViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        self.setData(data: user!)
        
        loadWwebView(url: user?.html_url)
    }
    
    func loadWwebView(url: String?) {
        let url = URL(string: url!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func setData(data: User) {
        self.user = data
        nameLabel.text = data.login
    }

    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension GitHubWebViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("StartLoad: didCommit")
        webView.isUserInteractionEnabled = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("StartLoad: didStartProvisionalNavigation")
        webView.isUserInteractionEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("FinishLoad: didFinish")
        webView.isUserInteractionEnabled = true
    }
    
    private func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("FailLoad: didFailProvisionalNavigation: \(error)")
        webView.isUserInteractionEnabled = true
    }

}
