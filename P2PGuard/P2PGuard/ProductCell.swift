

import UIKit

class ProductCell: UITableViewCell{
    
    var productNameStr:String?
    var companyNameStr:String?
    var productId:Int?
    var _cellWidth:CGFloat?
    var _constant:Constant?=Constant()
    var addBtn:UIButton?
    var cancelBtn:UIButton?
    var label1:UILabel?
    var label2:UILabel?
    var _netDao:NetDao=NetDao()
    var delegate:ProductCellDelegate?
    var check:UIImageView?
    var isGuard:Bool?
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,dic:NSMutableDictionary,cellHeight:CGFloat,cellWidth:CGFloat) {
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        _cellWidth=cellWidth
        productId=dic["id"] as! Int
        productNameStr=dic["productName"] as! String
        label1=UILabel()
        label1!.text=productNameStr
        label1!.font=UIFont(name: _constant!._textFont, size: 16)
        label1!.sizeToFit()
        label1!.center=CGPoint(x: 25+label1!.frame.size.width/2,y: self.center.y)
        self.addSubview(label1!)
        
        companyNameStr=dic["companyName"] as! String
        label2=UILabel()
        label2!.text=companyNameStr
        label2!.font=UIFont(name: _constant!._textFont, size: 12)
        label2!.frame=CGRectMake(cellWidth/3, 0, cellWidth*2/3-60, self.frame.height)
        self.addSubview(label2!)

        self.selectionStyle=UITableViewCellSelectionStyle.None
        
        check=UIImageView(frame:CGRectMake(cellWidth-45,self.frame.height/2-11,30,21))
        check!.image=UIImage(named: "Check")
        isGuard=dic["isGuard"] as! Bool
        if isGuard! {
            
            //print("cell is guard")
            self.addSubview(check!)
        }else{
            
            //print("cell is not guard")
        }
        
        
        addBtn=UIButton(frame: CGRectMake(_cellWidth!/3, 0, _cellWidth!*2/3, self.frame.height))
        addBtn!.backgroundColor=_constant!._redColor
        addBtn?.addTarget(self, action: "addProduct", forControlEvents: UIControlEvents.TouchUpInside)
        var txt=UILabel(frame: CGRectMake(0, 0, _cellWidth!*2/3, self.frame.height))
        txt.text="加入监控"
        txt.textColor=UIColor.whiteColor()
        txt.font=UIFont(name: (_constant?._textFont)!, size: 16)
        txt.textAlignment=NSTextAlignment.Center
        addBtn?.addSubview(txt)
        
        cancelBtn=UIButton(frame: CGRectMake(_cellWidth!/3, 0, _cellWidth!*2/3, self.frame.height))
        cancelBtn!.backgroundColor=_constant!._redColor
        cancelBtn?.addTarget(self, action: "cancelProduct", forControlEvents: UIControlEvents.TouchUpInside)
        var txt2=UILabel(frame: CGRectMake(0, 0, _cellWidth!*2/3, self.frame.height))
        txt2.text="取消监控"
        txt2.textColor=UIColor.whiteColor()
        txt2.font=UIFont(name: (_constant?._textFont)!, size: 16)
        txt2.textAlignment=NSTextAlignment.Center
        cancelBtn?.addSubview(txt2)

    }
    func cancelProduct(){
        
        print("click cancel btn")
        delegate?.cancelGuard(productId!)
    }
   
    func addProduct(){
        
        print("click add btn")
        delegate?.setGuard(productId!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
protocol ProductCellDelegate{
    
    func setGuard(productId:Int)
    func cancelGuard(productId:Int)
}
