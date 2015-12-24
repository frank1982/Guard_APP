
import UIKit

class NetDao: NSObject {
    
    //let URL:String="http://120.26.215.42:8080"
    var URL:String="http://127.0.0.1:8888"
    
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
    func getNews()->NSArray?{
        
        var urlString=URL+"/guard/getNews.action"
        var nsUrl:NSURL=NSURL(string:urlString)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        var response:NSURLResponse?
        var error:NSError?
        var jsonArray:NSArray!

        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
        }catch(let error){
            print("查找服务器查询最新的消息动态失败")
        }
        return jsonArray

    }
}
