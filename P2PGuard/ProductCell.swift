

import UIKit

class ProductCell: UITableViewCell{
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,dic:NSMutableDictionary,cellHeight:CGFloat,cellWidth:CGFloat) {
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        var _constant=Constant()
        
        var productNameStr=dic["productName"] as! String
        var label1=UILabel()
        label1.text=productNameStr
        label1.font=UIFont(name: _constant._textFont, size: 16)
        label1.sizeToFit()
        label1.center=CGPoint(x: 25+label1.frame.size.width/2,y: self.center.y)
        self.addSubview(label1)
        
        var companyNameStr=dic["companyName"] as! String
        var label2=UILabel()
        label2.text=companyNameStr
        label2.font=UIFont(name: _constant._textFont, size: 12)
        label2.frame=CGRectMake(cellWidth/3, 0, cellWidth*2/3-20, self.frame.height)
        self.addSubview(label2)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
