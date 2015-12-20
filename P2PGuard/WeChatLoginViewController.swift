

import UIKit

class WeChatLoginViewController: UIViewController {
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _width=self.view.frame.width
        _height=self.view.frame.height
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        //titleLabel.backgroundColor=UIColor.greenColor()
        titleLabel.text="微信登录"
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
