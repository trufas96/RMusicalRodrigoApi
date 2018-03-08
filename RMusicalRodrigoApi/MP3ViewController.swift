

import UIKit
import AVFoundation
import WebKit
import Alamofire

class MP3ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webKit: WKWebView!
    var url : String = ""
    var downloadTimer = Timer()
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        myActivityIndicator.center = view.center
        
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        webKit.navigationDelegate = self
        let urlYT = NSURL(string : url)
        let requestYT = NSURLRequest(url: urlYT! as URL)
        webKit.load(requestYT as URLRequest)
        
    }


    

}
