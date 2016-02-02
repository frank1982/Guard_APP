import UIKit

class NetDao: NSObject {
    
    //var URL:String="http://120.26.215.42:8080"
    var URL:String="http://127.0.0.1:8888"
    
    //修改密码
    func setPwd(username:String,pwd:String)->String?{
        
        var urlString=URL+"/guard/setPwd.action?username="+username+"&pwd="+pwd
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:String?
        do {
            
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            
        }catch(let error){
            print("checkUserId失败")
            print(error)
            result="error"
        }
        return result
        
    }
    
    
    //addUser
    func addUser(username:String,pwd:String)->String?{
        
        var urlString=URL+"/guard/addUser.action?username="+username+"&pwd="+pwd
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:String?
        do {
            
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            
        }catch(let error){
            print("checkUserId失败")
            print(error)
            result="error"
        }
        return result
        
    }
    
    
    //检查userid是否重复
    func checkUserId(userid:String)->String?{
        
        var urlString=URL+"/guard/checkId.action?userid="+userid
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:String?
        do {
            
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            
        }catch(let error){
            print("checkUserId失败")
            print(error)
            result="error"
        }
        return result
        
    }
    
    //getMyInfo,获取已订阅产品的信息
    func getMyNews(userid:String,limit:String,offset:String)->NSMutableArray?{
        
        var urlString=URL+"/guard/getMyNews.action?userid="+userid+"&limit="+limit+"&offset="+offset
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var jsonArray:NSMutableArray!
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
        }catch(let error){
            print("查找服务器查询最新的产品失败")
        }
        return jsonArray

    }
    
    //删除订阅关系
    func delProductGuard(userid:String,productid:String)->String?{

        var urlString=URL+"/guard/delProductGuard.action?userid="+userid+"&productid="+productid
        urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        //productName中有中文
        var nsUrl:NSURL=NSURL(string: urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:String?
        do {
 
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            
        }catch(let error){
            print("delPlatformNumFromServer失败")
            print(error)
            result="netfail"
        }
        return result
        
    }
    
    
    
    //send username and productid which to be guard to server
    func setProductGuard(userid:String,productid:String)->String?{

        var urlString=URL+"/guard/setProductGuard.action?userid="+userid+"&productid="+productid
        urlString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        //productName中有中文
        var nsUrl:NSURL=NSURL(string: urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var result:String?
        do {

            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            result=NSString(data:data,encoding:NSUTF8StringEncoding) as! String
            
        }catch(let error){
            print("getPlatformNumFromServer失败")
            print(error)
            result="netfail"
        }
        return result

    }
    
    func downProduct(userid:String)->NSMutableArray?{
        
        var urlString=URL+"/guard/getProductJsondataAndStatus.action?userid="+userid
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var jsonArray:NSMutableArray!
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
        }catch(let error){
            print("查找服务器查询最新的产品失败")
        }
        return jsonArray
        
    }
    /*
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
    */
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
