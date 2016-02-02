

import UIKit
import CoreData

class Dao: NSObject {
    
    
    
    //get localProduct to dictArray
    class func getLocalProduct()->NSMutableArray?{
        
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext
        var error:NSError?
        var fetchRequest:NSFetchRequest=NSFetchRequest()
        var entity:NSEntityDescription = NSEntityDescription.entityForName("Product", inManagedObjectContext: context)!
        fetchRequest.entity=entity
        //降序排序...
        var sortDescrpitor = NSSortDescriptor(key: "id", ascending: false,selector: Selector("localizedStandardCompare:"))
        fetchRequest.sortDescriptors = [sortDescrpitor]
        var dictArray:NSMutableArray? = NSMutableArray()//需要声明
        
        
        do{
            var fetchObjects:[AnyObject] = try context.executeFetchRequest(fetchRequest)
            if(fetchObjects.count > 0){
                
                for _product:Product in fetchObjects as! [Product]{
                    
                    var tmpDic:NSMutableDictionary? = NSMutableDictionary()//需要声明
                    //print(_product.companyName)
                    tmpDic?.setObject(_product.id!, forKey: "id")
                    tmpDic?.setObject(_product.productName!, forKey: "productName")
                    tmpDic?.setObject(_product.companyName!, forKey: "companyName")
                    tmpDic?.setObject(_product.isGuard!, forKey: "isGuard")
                    //print(tmpDic?["companyName"] as! String)
                    dictArray?.addObject(tmpDic!)
                }
                
                
            }
        }catch{
            
        }
        
        return dictArray
        
    }
    
    
    //count 本地product 数据数量
    class func countLocalProductNum()->Int?{
        
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext
        var error:NSError?
        var fetchRequest:NSFetchRequest=NSFetchRequest()
        var entity:NSEntityDescription = NSEntityDescription.entityForName("Product", inManagedObjectContext: context)!
        fetchRequest.entity=entity
        //降序排序...
        var sortDescrpitor = NSSortDescriptor(key: "id", ascending: true,selector: Selector("localizedStandardCompare:"))
        fetchRequest.sortDescriptors = [sortDescrpitor]
        var num:Int?
        do{
            var fetchObjects:[AnyObject] = try context.executeFetchRequest(fetchRequest)
            if(fetchObjects.count > 0){
                num=fetchObjects.count
                for _product:Product in fetchObjects as! [Product]{
                    
                    print(_product.productName)
                }
                
            }
        }catch{
            
        }
        return num
    }
    
    //删除本地所有product数据
    class func clearLocalProductData(){
        
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext
        var error:NSError?
        var fetchRequest:NSFetchRequest=NSFetchRequest()
        var entity:NSEntityDescription = NSEntityDescription.entityForName("Product", inManagedObjectContext: context)!
        fetchRequest.entity=entity
        
        do{
            var fetchObjects:[AnyObject] = try context.executeFetchRequest(fetchRequest)
            if(fetchObjects.count > 0){
                for _product:Product in fetchObjects as! [Product]{
                    
                    context.deleteObject(_product)
                    do{
                        try context.save()
                    }catch(let error){
                        print("删除本地product数据失败...")
                        print("error")
                    }
                }
            }
        }catch(let error){
            
            print("在执行删除本地product数据失败...")
            print("error")
        }
        print("本地product数据删除")
        
    }
    
    class func saveProduct(array:NSMutableArray){
        
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext
        
        do{
            for(var i=0;i<array.count;i++){
                
                var _product=NSEntityDescription.insertNewObjectForEntityForName("Product", inManagedObjectContext: context) as! Product
                _product.id=array[i]["id"] as! Int
                _product.productName=array[i]["productName"] as! String
                _product.companyName=array[i]["companyName"] as! String
                
                var isGuard=array[i]["isGuard"] as! String
                if isGuard=="isGuard" {
                    _product.isGuard=true
                }else{
                    _product.isGuard=false
                }
                
                
                
                var dateStr=array[i]["updateTime"] as! String
                var formatter=NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var time0=formatter.dateFromString(dateStr)
                //解决相差8个小时
                var zone=NSTimeZone.systemTimeZone()
                var interval:NSInteger=zone.secondsFromGMTForDate(time0!)
                var timerInterval=NSTimeInterval(interval)
                var localTime=time0?.dateByAddingTimeInterval(timerInterval)
                _product.updateTime=localTime
                try context.save()
            }
            
            
        }catch{
            print("将一条Product数据持久化失败")
        }
    }
    
    class func setLoginId(idString:String){
    
    var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    userDefault.setObject(idString, forKey: "userid")
    
    }
    
    class func delLoginId(){
        
        var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefault.removeObjectForKey("userid")
    }

    
    class func getLoginId()->String?{
        
        var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var loginId:String?
        loginId = userDefault.objectForKey("userid") as? String
        
        return loginId
    }
    
    class func getLocalUpdateTime()->NSDate?{
        
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        var error:NSError?
        var fetchRequest:NSFetchRequest=NSFetchRequest()
        var entity:NSEntityDescription = NSEntityDescription.entityForName("Product", inManagedObjectContext: context)!
        fetchRequest.entity=entity
        
        var maxUpdateTime:NSDate?
        
        do{
            
            var fetchObjects:[AnyObject] = try context.executeFetchRequest(fetchRequest)
            if(fetchObjects.count > 0){
                
                for _product:Product in fetchObjects as! [Product]{
                    
                    if maxUpdateTime == nil || _product.updateTime!.timeIntervalSinceDate(maxUpdateTime!) >= 0{
                        
                        maxUpdateTime=_product.updateTime!
                        
                    }
                    
                }
            }
            
        }catch{
            print("获取local updateTime失败")
        }
        return maxUpdateTime
    }
}