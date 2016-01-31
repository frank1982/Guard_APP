

import UIKit


class RegViewController: UIViewController,UITextFieldDelegate{
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    var phoneTextFieldMsg:UILabel!
    var phoneTextField:UITextField!
    var regBtn:UIButton!
    var _netDao:NetDao=NetDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _width=self.view.frame.width
        _height=self.view.frame.height
        self.view.backgroundColor=UIColor.whiteColor()
        
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        titleLabel.text="注册"
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
        
        //错误提示区域
        phoneTextFieldMsg=UILabel(frame:CGRectMake(10,phoneTextField.frame.origin.y+phoneTextField.frame.height, _width-20, 20))
        phoneTextFieldMsg.font=UIFont(name: _constant._textFont, size: 12)
        phoneTextFieldMsg.textColor=_constant._redColor
        self.view.addSubview(phoneTextFieldMsg)
        
        
        
        regBtn=UIButton(frame:CGRectMake(10,phoneTextFieldMsg.frame.origin.y+phoneTextFieldMsg.frame.height, _width-20, 40))
        regBtn.backgroundColor=_constant._redColor
        regBtn.setTitle("下一步", forState: UIControlState.Normal)
        regBtn.titleLabel?.font=UIFont(name: _constant._textFont, size: 22)
        regBtn.addTarget(self, action: "next", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(regBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //检查输入内容
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

            if range.location >= 11 {//输入长度控制
                return false
            }
            if !"0123456789".containsString(string){//输入必须为数字
                return false
            }

        return true
    }


    func next(){
        
        //检查手机号码输入
        if phoneTextField.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) == 0 {
            
            phoneTextFieldMsg.text="请输入手机号码"
            
        }else if phoneTextField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) < 11 &&
            phoneTextField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{
                
            phoneTextFieldMsg.text="手机号码输入错误"
              
        }else{
            
            //防止id重复
            var result=_netDao.checkUserId(phoneTextField.text!)
            if result == "yes"{
                
                phoneTextFieldMsg.text="该用户已存在"
            }else{
                
                var desVC=ImageCodeViewController()
                desVC.phoneNum=phoneTextField.text!
                self.navigationController?.pushViewController(desVC, animated: false)
            }
        
        }

    }

}
