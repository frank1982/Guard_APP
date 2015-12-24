

import UIKit

class InfoCell: UITableViewCell {
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,dic:NSDictionary,cellHeight:CGFloat,cellWidth:CGFloat) {
 
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        self.textLabel!.text=dic["title"] as! String
        var _constant:Constant=Constant()
        
        
        print("frame.height is: \(self.frame.height)")
        var sep=UIView(frame:CGRectMake(0, cellHeight-1, cellWidth, 1))
        sep.backgroundColor=_constant._redColor
        self.addSubview(sep)

        //var  platFormName
        //var  insertTime
        //var  title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
