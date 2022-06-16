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
        
        let address = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body>
        \(detailedPetition.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(address, baseURL: nil)
    }
}
