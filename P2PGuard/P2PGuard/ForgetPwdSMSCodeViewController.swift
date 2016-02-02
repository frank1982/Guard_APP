


import UIKit
import QJLink

class ForgetPwdSMSCodeViewController: UIViewController,UITextFieldDelegate{
    
    var _constant:Constant=Constant()
    var phoneNum:String!
    var imageCode:String!
    var codeField:UITextField!
    var _width:CGFloat!
    var _height:CGFloat!
    var sendSMSBtn:UIButton!
    var errorMsg:UILabel!
    var timeBtn:UIButton!
    var TIME:Int!
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _width=self.view.frame.width
        _height=self.view.frame.height
        TIME=30
        
        self.view.backgroundColor=UIColor.whiteColor()
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        titleLabel.text="短信验证"
        titleLabel.textAlignment=NSTextAlignment.Center
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        codeField=UITextField(frame:CGRectMake(10,20, _width-20, 40))
        codeField.delegate=self
        codeField.placeholder="输入短信验证码"
        codeField.font=UIFont(name: _constant._digitalFont, size: 20)
        codeField.returnKeyType=UIReturnKeyType.Next
        codeField.borderStyle=UITextBorderStyle.Line
        codeField.layer.borderWidth = 1.0;
        codeField.layer.borderColor=UIColor.redColor().CGColor
        codeField.leftViewMode=UITextFieldViewMode.Always
        codeField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(codeField)
        
        /*
        //倒计时按钮
        timeBtn=UIButton(frame:CGRectMake(_width/2,20, _width/2-10, 40))
        timeBtn.backgroundColor=_constant._redColor
        self.view.addSubview(timeBtn)
        self.timeBtn.alpha=0.4
        self.timeBtn.userInteractionEnabled=false
        timeBtn.addTarget(self, action: "touchTimeBtn", forControlEvents: UIControlEvents.TouchUpInside)
        */
        
        
        //错误提示区域
        errorMsg=UILabel(frame:CGRectMake(10,codeField.frame.origin.y+codeField.frame.height, _width-20, 20))
        errorMsg.font=UIFont(name: _constant._textFont, size: 12)
        errorMsg.textColor=_constant._redColor
        self.view.addSubview(errorMsg)
        
        var regBtn=UIButton(frame:CGRectMake(10,self.errorMsg.frame.origin.y+self.errorMsg.frame.height, self._width-20, 40))
        regBtn.backgroundColor=self._constant._redColor
        regBtn.setTitle("下一步", forState: UIControlState.Normal)
        regBtn.titleLabel?.font=UIFont(name: self._constant._textFont, size: 22)
        regBtn.addTarget(self, action: "next", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(regBtn)
        
        
        //获取短信验证码
        QJLinkManager.shareManager.requestCode(self.phoneNum, codeNumber: self.imageCode) { (error) -> () in
            
            if error == nil { //登录成功
                
                // 登录成功的提示
                //self.showMessage("验证码已发送至手机号：\n\(self.phoneNumberField.text!)")
                //self.timer=NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countTime"), userInfo: nil, repeats: true)
                
            } else {
                
                //self.showError((error?.domain)!)
                self.errorMsg.text="验证码发送失败"
                
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //print(string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))//string.length为0时，表示删除
        if range.location >= 4 {//输入长度控制
            
            return false
        }
        if !"0123456789".containsString(string){//输入必须为数字
            
            return false
        }
        
        return true
    }

    
    func next(){
        
        //先验证
        // 拿到用户的手机号和验证码,去服务器请求,判断是否正确
        
        QJLinkManager.shareManager.requestLogin(self.phoneNum, code: codeField.text!) { (message, error) -> () in
            
            print(message)
            
            if error == nil {

                //跳转设置密码
                var desVC=ForgetPwdSuccessViewController()
                desVC.username=self.phoneNum
                self.navigationController?.pushViewController(desVC, animated: false)
                
            }else{
                
                self.errorMsg.text="验证码错误"
            }
        }
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
