

import UIKit
import QJLink

class ImageCodeViewController: UIViewController,UITextFieldDelegate{
    
    var phoneNum:String!
    var _constant:Constant=Constant()
    var codeField:UITextField!
    var _width:CGFloat!
    var _height:CGFloat!
    var pictureCodeImageView:UIImageView!
    var errorMsg:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _width=self.view.frame.width
        _height=self.view.frame.height

        self.view.backgroundColor=UIColor.whiteColor()
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        titleLabel.text="图形验证"
        titleLabel.textAlignment=NSTextAlignment.Center
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        codeField=UITextField(frame:CGRectMake(10,20, _width/2-10, 40))
        codeField.delegate=self
        codeField.placeholder="输入图形验证码"
        codeField.font=UIFont(name: _constant._digitalFont, size: 20)
        codeField.returnKeyType=UIReturnKeyType.Next
        codeField.borderStyle=UITextBorderStyle.Line
        codeField.layer.borderWidth = 1.0;
        codeField.layer.borderColor=UIColor.redColor().CGColor
        codeField.leftViewMode=UITextFieldViewMode.Always
        codeField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.view.addSubview(codeField)
        
        //错误提示区域
        errorMsg=UILabel(frame:CGRectMake(10,codeField.frame.origin.y+codeField.frame.height, _width-20, 20))
        errorMsg.font=UIFont(name: _constant._textFont, size: 12)
        errorMsg.textColor=_constant._redColor
        self.view.addSubview(errorMsg)
        
        
        pictureCodeImageView=UIImageView(frame:CGRectMake(_width/2,20, _width/2-10, 40))
        self.view.addSubview(pictureCodeImageView)
        
        var tapRecognizer=UITapGestureRecognizer(target: self, action: "tapFunc:")
        tapRecognizer.numberOfTapsRequired = 1
        pictureCodeImageView.userInteractionEnabled = true//必须要有这句
        pictureCodeImageView.addGestureRecognizer(tapRecognizer)
        
        
        QJLinkManager.shareManager.requestPictureCode(phoneNum) { (data, error) -> () in
            
            if data != nil {
                // 利用获取的data数据生成图片
                
                self.pictureCodeImageView.image = UIImage(data: data!)
                var regBtn=UIButton(frame:CGRectMake(10,self.errorMsg.frame.origin.y+self.errorMsg.frame.height, self._width-20, 40))
                regBtn.backgroundColor=self._constant._redColor
                regBtn.setTitle("下一步", forState: UIControlState.Normal)
                regBtn.titleLabel?.font=UIFont(name: self._constant._textFont, size: 22)
                regBtn.addTarget(self, action: "next", forControlEvents: UIControlEvents.TouchUpInside)
                self.view.addSubview(regBtn)
                
            }else{
                
                self.errorMsg.text="图形验证码获取失败"
            }
        }

    }
    
    func tapFunc(sender:UITapGestureRecognizer){
        
        print("tap")
        
        //reset image code
        QJLinkManager.shareManager.requestPictureCode(phoneNum) { (data, error) -> () in
            
            if data != nil {
                // 利用获取的data数据生成图片
                
                self.pictureCodeImageView.image = UIImage(data: data!)
                
            }else{
                
                self.errorMsg.text="图形验证码获取失败"
            }
        }
    }
    
    //检查输入内容
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if range.location >= 4 {//输入长度控制
            return false
        }
        
        return true
    }
    
    func next(){
        
        //检查图形验证码输入
        if codeField.text!.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) == 0 {
            
            errorMsg.text="请输入图形验证码"
            
        }else if codeField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) < 4 &&
            codeField.text?.lengthOfBytesUsingEncoding(NSASCIIStringEncoding) > 0{
                
                errorMsg.text="图形验证码输入错误"
                
        }else{
            
            var desVC=SMSCodeViewController()
            desVC.phoneNum=self.phoneNum
            desVC.imageCode=self.codeField.text!
            self.navigationController?.pushViewController(desVC, animated: false)
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
