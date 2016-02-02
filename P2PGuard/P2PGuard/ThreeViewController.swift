

import UIKit

class ThreeViewController: UIViewController {

    var existBtn:UIButton!
    var _constant:Constant=Constant()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        existBtn=UIButton(frame: CGRectMake(0,100,self.view.frame.width,44))
        existBtn.backgroundColor=_constant._redColor
        existBtn.setTitle("退出登录", forState: UIControlState.Normal)
        existBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 22)
        existBtn.addTarget(self, action: "existLogin", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(existBtn)

        
    }
    func existLogin(){
        
        Dao.delLoginId()
        var desVC=OneViewController()
        self.navigationController?.pushViewController(desVC, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 }
