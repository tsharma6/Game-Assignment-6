//
//  SecondScreenViewController.swift
//  Testing
//
//  Created by Tushar Sharma on 11/24/19.
//  Copyright © 2019 Lalit. All rights reserved.
//

import Foundation
import UIKit

class SecondScreenViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let localfilePath = Bundle.main.url(forResource: "intro", withExtension: "html");
        let myRequest = NSURLRequest(url: localfilePath!);
        webView.loadRequest(myRequest as URLRequest);
        self.view.addSubview(webView)
    
    }
    
