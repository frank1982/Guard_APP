

import UIKit

class Dao: NSObject {
    
    class func setLoginName(){
        
        var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefault.setObject("frank", forKey: "loginName")

    }
    
    class func getLoginName()->String?{
        
        var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var loginName:String?
        loginName = userDefault.objectForKey("loginName") as? String
        
        return loginName
    }
}
