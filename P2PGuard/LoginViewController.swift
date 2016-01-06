

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate{
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    var phoneTextFieldMsg:UILabel!
    var phoneTextField:UITextField!
    var pwdTextFieldMsg:UILabel!
    var pwdTextField:UITextField!
    var _netDao:NetDao=NetDao()
    var loginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("login")
        self.view.backgroundColor=UIColor.whiteColor()
        _width=self.view.frame.width
        _height=self.view.frame.height
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        //titleLabel.backgroundColor=UIColor.greenColor()
        titleLabel.text="登录"
        titleLabel.textAlignment=NSTextAlignment.Center
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        phoneTextField=UITextField(frame:CGRectMake(10,10, _width-20, 40))
        phoneTextField.delegate=self
        phoneTextField.placeholder="请输入手机号码"
        phoneTextField.font=UIFont(name: _constant._digitalFont, size: 20)
        phoneTextField.keyboardType=UIKeyboardType.NumberPad
        phoneTextField.returnKeyType=UIReturnKeyType.Next
        phoneTextField.borderStyle=UITextBorderStyle.Line
        phoneTextField.layer.borderWidth = 1.0;
        phoneTextField.layer.borderColor=UIColor.redColor().CGColor
        var mobileView=UIImageView(frame: CGRectMake(0,0, 40, 30))
        mobileView.image=UIImage(named: "Mobile")
        mobileView.contentMode=UIViewContentMode.ScaleAspectFit
        phoneTextField.leftView=mobileView
        phoneTextField.leftViewMode=UITextFieldViewMode.Always
        phoneTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(phoneTextField)

        phoneTextFieldMsg=UILabel(frame:CGRectMake(10,phoneTextField.frame.origin.y+phoneTextField.frame.height, _width-20, 20))
        phoneTextFieldMsg.font=UIFont(name: _constant._textFont, size: 12)
        phoneTextFieldMsg.textColor=_constant._redColor
        self.view.addSubview(phoneTextFieldMsg)
        
        pwdTextField=UITextField(frame:CGRectMake(10,phoneTextFieldMsg.frame.origin.y+phoneTextFieldMsg.frame.height, _width-20, 40))
        pwdTextField.delegate=self
        pwdTextField.placeholder="请输入密码"
        pwdTextField.font=UIFont(name: _constant._digitalFont, size: 20)
        pwdTextField.keyboardType=UIKeyboardType.NamePhonePad
        pwdTextField.returnKeyType=UIReturnKeyType.Done
        pwdTextField.borderStyle=UITextBorderStyle.Line
        pwdTextField.layer.borderWidth = 1.0;
        pwdTextField.layer.borderColor=UIColor.redColor().CGColor
        var pwdView=UIImageView(frame: CGRectMake(0,0, 40, 30))
        pwdView.image=UIImage(named: "Key")
        pwdView.contentMode=UIViewContentMode.ScaleAspectFit
        pwdTextField.leftView=pwdView
        pwdTextField.secureTextEntry=true
        pwdTextField.leftViewMode=UITextFieldViewMode.Always
        pwdTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(pwdTextField)
        
        pwdTextFieldMsg=UILabel(frame:CGRectMake(10,pwdTextField.frame.origin.y+pwdTextField.frame.height, _width-20, 20))
        pwdTextFieldMsg.font=UIFont(name: _constant._textFont, size: 12)
        pwdTextFieldMsg.textColor=_constant._redColor
        self.view.addSubview(pwdTextFieldMsg)
        
        loginBtn=UIButton(frame:CGRectMake(10,pwdTextFieldMsg.frame.origin.y+pwdTextFieldMsg.frame.height, _width-20, 40))
        loginBtn.backgroundColor=_constant._redColor
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        loginBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 22)
        loginBtn.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginBtn)
        
        var forgetPwdBtn=UIButton(frame:CGRectMake(10,loginBtn.frame.origin.y+loginBtn.frame.height, _width/2-10, 44))
        forgetPwdBtn.setTitle("忘记密码?", forState: UIControlState.Normal)
        //设置按钮文字颜色
        forgetPwdBtn.setTitleColor(_constant._redColor, forState: UIControlState.Normal)
        //btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft 
        forgetPwdBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignment.Left
        forgetPwdBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 16)
        forgetPwdBtn.addTarget(self, action: "forgetPwd", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(forgetPwdBtn)
        
        var regBtn=UIButton(frame:CGRectMake(_width/2,loginBtn.frame.origin.y+loginBtn.frame.height, _width/2-10, 44))
        regBtn.setTitle("我要注册", forState: UIControlState.Normal)
        //设置按钮文字颜色
        regBtn.setTitleColor(_constant._redColor, forState: UIControlState.Normal)
        regBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignment.Right
        regBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 16)
        regBtn.addTarget(self, action: "register", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(regBtn)
    }
    
    func register(){
        
        print("register")
    }
    
    func forgetPwd(){
        
        print("forgetPwd")
    }
    
    func login(){
        
        loginBtn.alpha=0.4
        loginBtn.enabled=false//不可重复点击
        phoneTextFieldMsg.text=""
        pwdTextFieldMsg.text=""
        var phoneFormat=true
        var pwdFormat=true
        
        //检查手机号码输入
        if phoneTextField.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) == 0 {

            phoneTextFieldMsg.text="请输入手机号码"
            phoneFormat=false
            
        }else if phoneTextField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) < 11 &&
        phoneTextField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{

            phoneTextFieldMsg.text="手机号码输入错误"
            phoneFormat=false
        }
        //检查密码输入
        if pwdTextField.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) < 6 {
            
            pwdTextFieldMsg.text="密码为6-12位数字字母组合"
            pwdFormat=false
        }
        loginBtn.alpha=1
        loginBtn.enabled=true
        
        if phoneFormat && pwdFormat{
            
            //加载loading
            var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            activityIndicatorView.color=_constant._redColor
            var bgView=UIView(frame: self.view.bounds)
            bgView.backgroundColor=UIColor.blackColor()
            bgView.alpha=0.5
            activityIndicatorView.center=bgView.center
            bgView.addSubview(activityIndicatorView)
            self.view.window?.addSubview(bgView)
            activityIndicatorView.startAnimating()
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                
                var msg=self._netDao.loginCheck(self.phoneTextField.text!, pwd:self.pwdTextField.text!)
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), {
                    
                    activityIndicatorView.stopAnimating()
                    bgView.removeFromSuperview()
                    self.loginBtn.alpha=1
                    self.loginBtn.enabled=true
                    if msg == "success"{//登录成功
                        
                        var des=AddProductViewController()
                        var animation=CATransition()
                        animation.duration=0.5
                        animation.timingFunction=CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
                        animation.type="pageCurl"
                        animation.subtype=kCATransitionFromBottom
                        self.navigationController!.view.layer.addAnimation(animation, forKey: nil)
                        self.navigationController?.pushViewController(des, animated: false)

                    }else if msg == "error"{
                        self.pwdTextFieldMsg.text="用户名或密码错误"
                        self.pwdTextField.text=""
                    }else{
                        self.pwdTextFieldMsg.text="网络连接失败"
                        self.pwdTextField.text=""
                    }
                });
            })

        }
        
    }
    


    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //print(string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))//string.length为0时，表示删除
        if textField == phoneTextField && string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{
            
            if range.location >= 11 {//输入长度控制
                return false
            }
            if !"0123456789".containsString(string){//输入必须为数字
                return false
            }
        }
        //密码输入检查
        if textField == pwdTextField && string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{
            
            if range.location >= 12 {//输入长度控制
                return false
            }
            if !"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".containsString(string){//输入必须为数字、大小写字母
                return false
            }

        }
        
        return true       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
