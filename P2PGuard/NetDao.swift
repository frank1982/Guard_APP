import UIKit

class NetDao: NSObject {
    
    //var URL:String="http://120.26.215.42:8080"
    var URL:String="http://127.0.0.1:8888"
    
    func downProduct()->NSMutableArray?{
        
        var urlString=URL+"/guard/getProductJsondata.action"
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var jsonArray:NSMutableArray!
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
        }catch(let error){
            print("查找服务器查询最新的消息动态失败")
        }
        return jsonArray
        
    }
    
    func getUpdateTime()->NSDate?{
        
        var urlString=URL+"/guard/getUpdateTime.action";
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var time:NSDate?
        var localTime:NSDate?
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            var formatter=NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var timeStr=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            time=formatter.dateFromString(timeStr as! String)
            //解决相差8个小时
            var zone=NSTimeZone.systemTimeZone()
            var interval:NSInteger=zone.secondsFromGMTForDate(time!)
            var timerInterval=NSTimeInterval(interval)
            localTime=time?.dateByAddingTimeInterval(timerInterval)
            
        }catch(let error){
            print("get updateTime from server 失败")
            
        }
        return localTime
    }
    
    func loginCheck(phone:String,pwd:String)->String?{
        
        print("login check")
        var urlString=URL+"/guard/userLogin.action?username="+phone+"&pwd="+pwd;
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:String?
        do {
            print("try connect")
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            //print(result)
            
        }catch(let error){
            print("getPlatformNumFromServer失败")
            print(error)
            result="netfail"
        }
        return result
    }
    
    //从服务端查询最新数据id,采用同步方式
    func getPlatformNumFromServer()->Int?{
        
        var urlString=URL+"/guard/getPlatformNum.action"
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:Int?
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding)?.integerValue
            
        }catch(let error){
            print("getPlatformNumFromServer失败")
        }
        return result
    }
    
    //从服务端查询最新的消息动态，最多四条
    func getNews()->NSMutableArray?{
        
        var urlString=URL+"/guard/getNews.action"
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var jsonArray:NSMutableArray!
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
        }catch(let error){
            print("查找服务器查询最新的消息动态失败")
        }
        return jsonArray
        
    }
    
    //根据id从服务端查询最新的消息动态，随机1-4条
    func getNewsById(id:String)->NSMutableArray?{
        
        var urlString=URL+"/guard/getNewsById.action?id="+id
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var jsonArray:NSMutableArray!
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
        }catch(let error){
            print("查找服务器查询最新的消息动态失败")
        }
        return jsonArray
        
    }
}
