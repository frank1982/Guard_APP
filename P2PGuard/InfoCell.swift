

import UIKit


class InfoCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,dic:NSDictionary,cellHeight:CGFloat,cellWidth:CGFloat) {
 
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        var _constant:Constant=Constant()
        var sep=UIView(frame:CGRectMake(0, cellHeight-1, cellWidth, 1))
        sep.backgroundColor=_constant._redColor
        self.addSubview(sep)

        var  insertTimeLabel=UILabel(frame:CGRectMake(10,5,cellWidth*2/3,cellHeight/3))
        insertTimeLabel.text=dic["insertTime"] as! String
        insertTimeLabel.font=UIFont(name: _constant._digitalFont, size: 14)
        self.addSubview(insertTimeLabel)

        var  platformName=UILabel(frame:CGRectMake(cellWidth*2/3,5,cellWidth/3,cellHeight/3))
        platformName.text=dic["platformName"] as! String
        platformName.textAlignment=NSTextAlignment.Left
        platformName.font=UIFont(name: _constant._textFont, size: 14)
        self.addSubview(platformName)

        var  title=UILabel(frame:CGRectMake(10,cellHeight/3,cellWidth,cellHeight*2/3))
        title.text=dic["title"] as! String
        title.font=UIFont(name: _constant._textFont, size: 16)
        print("title")
        print(title)
        self.addSubview(title)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
