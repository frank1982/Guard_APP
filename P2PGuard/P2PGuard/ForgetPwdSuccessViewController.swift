

import UIKit

class ForgetPwdSuccessViewController: UIViewController,UITextFieldDelegate{
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    var pwdTextFieldMsg1:UILabel!
    var pwdTextField1:UITextField!
    var pwdTextFieldMsg2:UILabel!
    var pwdTextField2:UITextField!
    var _netDao:NetDao=NetDao()
    var regBtn:UIButton!
    var username:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _width=self.view.frame.width
        self.view.backgroundColor=UIColor.whiteColor()
        
        pwdTextField1=UITextField(frame:CGRectMake(10,20, _width-20, 40))
        pwdTextField1.delegate=self
        pwdTextField1.placeholder="请输入6-12位密码"
        pwdTextField1.font=UIFont(name: _constant._textFont, size: 20)
        pwdTextField1.keyboardType=UIKeyboardType.NamePhonePad
        pwdTextField1.returnKeyType=UIReturnKeyType.Done
        pwdTextField1.borderStyle=UITextBorderStyle.Line
        pwdTextField1.layer.borderWidth = 1.0;
        pwdTextField1.layer.borderColor=UIColor.redColor().CGColor
        var pwdView=UIImageView(frame: CGRectMake(0,0, 40, 30))
        pwdView.image=UIImage(named: "Key")
        pwdView.contentMode=UIViewContentMode.ScaleAspectFit
        pwdTextField1.leftView=pwdView
        pwdTextField1.secureTextEntry=true
        pwdTextField1.leftViewMode=UITextFieldViewMode.Always
        pwdTextField1.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(pwdTextField1)
        
        pwdTextFieldMsg1=UILabel(frame:CGRectMake(10,pwdTextField1.frame.origin.y+pwdTextField1.frame.height, _width-20, 20))
        pwdTextFieldMsg1.font=UIFont(name: _constant._textFont, size: 12)
        pwdTextFieldMsg1.textColor=_constant._redColor
        self.view.addSubview(pwdTextFieldMsg1)
        
        pwdTextField2=UITextField(frame:CGRectMake(10,pwdTextFieldMsg1.frame.origin.y+pwdTextFieldMsg1.frame.height, _width-20, 40))
        pwdTextField2.delegate=self
        pwdTextField2.placeholder="请再次输入密码"
        pwdTextField2.font=UIFont(name: _constant._textFont, size: 20)
        pwdTextField2.keyboardType=UIKeyboardType.NamePhonePad
        pwdTextField2.returnKeyType=UIReturnKeyType.Done
        pwdTextField2.borderStyle=UITextBorderStyle.Line
        pwdTextField2.layer.borderWidth = 1.0;
        pwdTextField2.layer.borderColor=UIColor.redColor().CGColor
        var pwdView2=UIImageView(frame: CGRectMake(0,0, 40, 30))
        pwdView2.image=UIImage(named: "Key")
        pwdView2.contentMode=UIViewContentMode.ScaleAspectFit
        pwdTextField2.leftView=pwdView2
        pwdTextField2.secureTextEntry=true
        pwdTextField2.leftViewMode=UITextFieldViewMode.Always
        pwdTextField2.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(pwdTextField2)
        
        pwdTextFieldMsg2=UILabel(frame:CGRectMake(10,pwdTextField2.frame.origin.y+pwdTextField2.frame.height, _width-20, 20))
        pwdTextFieldMsg2.font=UIFont(name: _constant._textFont, size: 12)
        pwdTextFieldMsg2.textColor=_constant._redColor
        self.view.addSubview(pwdTextFieldMsg2)
        
        
        regBtn=UIButton(frame:CGRectMake(10,pwdTextFieldMsg2.frame.origin.y+pwdTextFieldMsg2.frame.height, _width-20, 40))
        regBtn.backgroundColor=_constant._redColor
        regBtn.setTitle("提交", forState: UIControlState.Normal)
        regBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 22)
        regBtn.addTarget(self, action: "reg", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(regBtn)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reg(){
        
        regBtn.alpha=0.4
        regBtn.enabled=false//不可重复点击
        var flag0=false
        var flag1=false

        print("click regbtn")
        
        //检查手机号码输入
        if pwdTextField1.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) == 0 {
            
            pwdTextFieldMsg1.text="请输入密码"
            
        }else if pwdTextField1.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) <= 5{
            
            pwdTextFieldMsg1.text="密码为6-12位字母数字"
        }else{
            pwdTextFieldMsg1.text=""
            flag0=true

        }
        
        if pwdTextField2.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) == 0 {
            
            pwdTextFieldMsg2.text="请输入密码"
            
        }else if pwdTextField2.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) <= 5{
            
            pwdTextFieldMsg2.text="密码为6-12位字母数字"
        }else if pwdTextField1.text! != pwdTextField2.text!{
            
            pwdTextFieldMsg2.text="密码不一致"
        }else{
            
            pwdTextFieldMsg2.text=""
            flag1=true
            
        }
        
        if flag0 == true && flag1 == true && _netDao.setPwd(username, pwd: pwdTextField2.text!) == "yes"{
            
            var alertView=UIView(frame:CGRectMake(_width/2-60,UIScreen.mainScreen().bounds.height/2-30,120,60))
            alertView.backgroundColor=UIColor.blackColor()
            alertView.alpha=0.5
            var label=UILabel(frame:CGRectMake(0,10,100,40))
            label.text="密码修改成功"
            label.font=UIFont(name: _constant._textFont, size: 16)
            label.sizeToFit()
            label.textColor=_constant._redColor
            alertView.addSubview(label)
            self.view.addSubview(alertView)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                
                sleep(2)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    alertView.removeFromSuperview()
                    var desVC=OneViewController()
                    self.navigationController?.pushViewController(desVC, animated: false)
                    
                })
                
            })
            
        }
        regBtn.alpha=1
        regBtn.enabled=true
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        //print(string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))//string.length为0时，表示删除
        if textField == pwdTextField1 && string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{
            
            if range.location >= 11 {//输入长度控制
                return false
            }
            if !"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".containsString(string){//输入必须为数字、大小写字母
                return false
            }
        }
        //密码输入检查
        if textField == pwdTextField2 && string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{
            
            if range.location >= 11 {//输入长度控制
                return false
            }
            if !"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".containsString(string){//输入必须为数字、大小写字母
                return false
            }
            
        }
        
        return true
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
