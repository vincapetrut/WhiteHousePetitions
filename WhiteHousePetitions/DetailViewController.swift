//
//  DetailViewController.swift
//  WhiteHousePetitions
//
//  Created by Petruț Vinca on 15.06.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailedPetition: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailedPetition = detailedPetition else {
            return
        }
        
        title = detailedPetition.title
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePetition))
        
        let address = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
        :root {
          color-scheme: light dark;
        }
        </style>
        </head>
        <body>
        \(detailedPetition.body)
        </body>
        </html>
        """
        
        webView.isOpaque = false
        webView.backgroundColor = UIColor.systemBackground
        webView.loadHTMLString(address, baseURL: nil)
    }
    
    @objc func sharePetition() {
        let ac = UIActivityViewController(activityItems: [detailedPetition?.title], applicationActivities: nil)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}
