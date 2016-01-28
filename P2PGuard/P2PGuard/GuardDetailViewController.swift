

import UIKit

class GuardDetailViewController: UIViewController {

    var _width:CGFloat!
    var _height:CGFloat!
    var _dic:NSDictionary!
    var _constant:Constant=Constant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.whiteColor()
        _width=self.view.frame.width
        _height=self.view.frame.height
        
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        //titleLabel.backgroundColor=UIColor.greenColor()
        titleLabel.text="通知内容"
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        var  infoTimeLabel=UILabel(frame:CGRectMake(10,20,_width*2/3,30))
        infoTimeLabel.text=_dic["infoTime"] as! String
        infoTimeLabel.font=UIFont(name: _constant._digitalFont, size: 14)
        self.view.addSubview(infoTimeLabel)
        
        var  productName=UILabel(frame:CGRectMake(_width*2/3,20,_width/3,30))
        productName.text=_dic["productName"] as! String
        productName.textAlignment=NSTextAlignment.Left
        productName.font=UIFont(name: _constant._textFont, size: 14)
        self.view.addSubview(productName)

        var  title=UILabel(frame:CGRectMake(10,infoTimeLabel.frame.origin.y+infoTimeLabel.frame.height,_width,44))
        title.text=_dic["title"] as! String
        title.font=UIFont(name: _constant._textFont, size: 18)
        self.view.addSubview(title)

        var str=_dic["descript"] as! String
        var attributedString=NSMutableAttributedString(string: str)
        var paragraphStyle=NSMutableParagraphStyle()
        //设置行间距
        paragraphStyle.lineSpacing=8
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0,NSString(string: str).length))
        //设置字体...
        attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: _constant._textFont, size: 14)!, range: NSMakeRange(0,NSString(string: str).length))
        //计算文字占据的尺寸大小，其中CGSize为约束限制
        var fontSize=attributedString.boundingRectWithSize(CGSize(width: _width-20,height: 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        var descriptLabel=UILabel()
        descriptLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        descriptLabel.numberOfLines = 0
        descriptLabel.attributedText = attributedString
        var height=min(fontSize.height,UIScreen.mainScreen().bounds.height-title.frame.origin.y-title.frame.height-10-44)
        descriptLabel.frame=CGRectMake(10, title.frame.origin.y+title.frame.height+10, fontSize.width, height)//高度取最小值
        self.view.addSubview(descriptLabel)
        
        
        var linkBtn=UIButton(frame:CGRectMake(10,descriptLabel.frame.height+descriptLabel.frame.origin.y+10,_width-20,44))
        
        linkBtn.backgroundColor=_constant._redColor
        linkBtn.addTarget(self, action: "goLink",
            forControlEvents: UIControlEvents.TouchUpInside)
        
        linkBtn.titleLabel!.textColor=UIColor.whiteColor()
        linkBtn.titleLabel!.font=UIFont(name: _constant._textFont, size: 20)
        linkBtn.setTitle("查看原文", forState: UIControlState.Normal)
        self.view.addSubview(linkBtn)

    }
    
    func goLink(){
        
        print("goLink")
        var des=LinkViewController()
        des._link=_dic["link"] as! String
        self.navigationController?.pushViewController(des, animated: true)
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
