

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    var phoneTextFieldMsg:UILabel!
    var phoneTextField:UITextField!
    var pwdTextFieldMsg:UILabel!
    var pwdTextField:UITextField!
    
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
        
        var loginBtn=UIButton(frame:CGRectMake(10,pwdTextFieldMsg.frame.origin.y+pwdTextFieldMsg.frame.height, _width-20, 40))
        loginBtn.backgroundColor=_constant._redColor
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        loginBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 22)
        loginBtn.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginBtn)
        
        var forgetPwdBtn=UIButton(frame:CGRectMake(10,loginBtn.frame.origin.y+loginBtn.frame.height, 200, 44))
        forgetPwdBtn.setTitle("忘记密码?", forState: UIControlState.Normal)
        //设置按钮文字颜色
        forgetPwdBtn.setTitleColor(_constant._redColor, forState: UIControlState.Normal)
        //btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft 
        forgetPwdBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignment.Left
        forgetPwdBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 16)
        self.view.addSubview(forgetPwdBtn)
    }
    
    func login(){
        
        phoneTextFieldMsg.text=""
        pwdTextFieldMsg.text=""
        
        //检查手机号码输入
        if phoneTextField.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) == 0 {

            phoneTextFieldMsg.text="请输入手机号码"
            
        }else if phoneTextField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) < 11 &&
        phoneTextField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{

            phoneTextFieldMsg.text="手机号码输入错误"
        }
        //检查密码输入
        if pwdTextField.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) < 6 {
            
            pwdTextFieldMsg.text="密码为6-12位数字字母组合"
        }
       
        
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print(string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))//string.length为0时，表示删除
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
