

import UIKit


class GuardCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,dic:NSDictionary,cellHeight:CGFloat,cellWidth:CGFloat) {
        
        super.init(style: UITableViewCellStyle.Default,reuseIdentifier: reuseIdentifier)
        
        var _constant:Constant=Constant()
        
        //self.textLabel!.text=dic["productName"] as! String
        
        //自定义分割线
        var sep=UIView(frame:CGRectMake(0, cellHeight-1, cellWidth, 1))
        sep.backgroundColor=_constant._redColor
        self.addSubview(sep)
        
        var  infoTimeLabel=UILabel(frame:CGRectMake(10,5,cellWidth*2/3,cellHeight/3))
        infoTimeLabel.text=dic["infoTime"] as! String
        infoTimeLabel.font=UIFont(name: _constant._digitalFont, size: 14)
        self.addSubview(infoTimeLabel)
        
        var  productName=UILabel(frame:CGRectMake(cellWidth*2/3,5,cellWidth/3,cellHeight/3))
        productName.text=dic["productName"] as! String
        productName.textAlignment=NSTextAlignment.Left
        productName.font=UIFont(name: _constant._textFont, size: 14)
        self.addSubview(productName)
        
        var  title=UILabel(frame:CGRectMake(10,cellHeight/3,cellWidth,cellHeight*2/3))
        title.text=dic["title"] as! String
        title.font=UIFont(name: _constant._textFont, size: 16)
        self.addSubview(title)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
