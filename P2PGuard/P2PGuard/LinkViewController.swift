

import UIKit

class LinkViewController: UIViewController {
    
    var _width:CGFloat!
    var _height:CGFloat!
    var _constant:Constant=Constant()
    var _link:String!
    var webViews: UIWebView!


    override func viewDidLoad() {
        super.viewDidLoad()

        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        //titleLabel.backgroundColor=UIColor.greenColor()
        titleLabel.text="原文"
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        self.webViews = UIWebView()
        webViews.frame = view.bounds
        
        var urlString = _link
        var url = NSURL(string: urlString)
        var urlRequest = NSURLRequest(URL :url!)
        view.addSubview(webViews)
        webViews.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
