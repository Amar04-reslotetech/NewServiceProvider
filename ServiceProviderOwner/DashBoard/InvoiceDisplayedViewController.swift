//
//  InvoiceDisplayedViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import UIKit
import WebKit

class InvoiceDisplayedViewController: UIViewController,WKUIDelegate {

    @IBOutlet weak var myView: UIView!
    var webView: WKWebView!
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.myView.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.addSubview(webView)
        webView.topAnchor.constraint(equalTo: myView.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: myView.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: myView.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: myView.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: myView.heightAnchor).isActive = true
        webView.uiDelegate = self
        guard let url = URL(string: url) else {
            return
        }
        print("\(url)")
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)

        // Do any additional setup after loading the view.
    }
    

   
}



//MARKS: Back Button Pressed
extension InvoiceDisplayedViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
}
