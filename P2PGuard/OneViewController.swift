

import UIKit

class OneViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    var _isNetOK:Bool=true
    var _netDao:NetDao=NetDao()
    var platformNum:UILabel!=UILabel()//监控平台数量
    var platformNumDescript:UILabel!=UILabel()
    var _tableViewHeight:CGFloat!
    var tableTitleView:UIView!
    var tableTitle:UILabel!
    var tableView:UITableView!
    var cellArray:NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()

        _width=self.view.frame.width
        _height=UIScreen.mainScreen().bounds.height
        self.view.backgroundColor=UIColor.whiteColor()
        
        //判断是iphone几？
        //var device=UIDevice.currentDevice().name
        //print(device)
        
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        //titleLabel.backgroundColor=UIColor.greenColor()
        titleLabel.text="舆情监控"
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        //设置下一级navigationItem的返回按钮
        var backBtnItem=UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "weChatLogin")
        backBtnItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: _constant._textFont, size: 16)!,NSForegroundColorAttributeName: _constant._redColor], forState: UIControlState.Normal)
        self.navigationItem.backBarButtonItem=backBtnItem
        
        //修改下级nav的返回按钮颜色
        self.navigationController!.navigationBar.tintColor=_constant._redColor
        
        //判断是否登录?
        Dao.setLoginName()
        var loginName=Dao.getLoginName()
        if loginName == nil {//未登录
            
            var statusBtnItem=UIBarButtonItem(title: "微信登录", style: UIBarButtonItemStyle.Plain, target: self, action: "weChatLogin")
            statusBtnItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: _constant._textFont, size: 16)!,NSForegroundColorAttributeName: _constant._redColor], forState: UIControlState.Normal)
            self.navigationItem.rightBarButtonItem=statusBtnItem
            
        }else{//已经登录
            
            //显示登录名
            var nameLabel=UILabel()
            nameLabel.text=loginName!+",欢迎您"
            nameLabel.font=UIFont(name: _constant._textFont, size: 16)
            nameLabel.textColor=_constant._redColor
            nameLabel.sizeToFit()
            nameLabel.center=CGPoint(x:_width-nameLabel.frame.width/2-10,y:22)
            self.navigationController?.navigationBar.addSubview(nameLabel)
        }
        
        //显示当前监控平台数量
        showPlatformNum()
        
        if _isNetOK {
            
            //异步加载平台数量
            loadPlatformNum()
            
            //加载tableview
            cellArray=_netDao.getNews()
            loadTableView()
            
            //异步加载cell
            loadAsyncCell()
            
        }else{
            
            print("net fail")
        }
    }
    
    func loadAsyncCell(){
        
        
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                
                while true{
                    
                    sleep(2)
                    var id=self.cellArray[self.cellArray.count-1]["id"] as! String
                    //print(id)
                    var tmp:NSMutableArray!
                    tmp = self._netDao.getNewsById(id)! as NSMutableArray
                    //print(tmp[tmp.count-1]["id"])
                    //通知主线程刷新
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        
                        
                        for(var i=0;i<tmp.count;i++){
                            
                            //print(tmp.count)
                            self.cellArray.addObject(tmp[i])
                            //print(self.cellArray[self.cellArray.count-1]["title"])
                            self.tableView.beginUpdates()
                            print(self.cellArray[3]["title"])
                            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                            
                            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                            self.cellArray.removeObjectAtIndex(0)
                            self.tableView.endUpdates()
                            
                            
                        }
                        
                    })

                }
                
        
            })
        
    }
    
    func loadTableView(){

        var tableHeight = _height-49-tableTitleView.frame.origin.y-tableTitleView.frame.height-64
        tableView=UITableView(frame: CGRectMake(0, tableTitleView.frame.origin.y+tableTitleView.frame.height, _width, tableHeight-30))
        tableView.backgroundColor=UIColor.grayColor()
        self.view.addSubview(tableView)
        
        //这两句很重要
        tableView.delegate=self
        tableView.dataSource=self
        
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        tableView.userInteractionEnabled=false//触摸无效

        _tableViewHeight=tableView.frame.height
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "cellIdentifier"
        var cell=InfoCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier,dic: cellArray[indexPath.row] as! NSDictionary,cellHeight:_tableViewHeight/4,cellWidth:_width)
        /*let cellIdentifier:String = "cellIdentifier"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
            if cell == nil {
            //cell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            cell=InfoCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier,dic: cellArray[indexPath.row] as! NSDictionary,cellHeight:_tableViewHeight/4,cellWidth:_width)

            
        }
        */
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return _tableViewHeight/4
        
    }
    
    //异步加载平台数量
    func loadPlatformNum(){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var platformNumText=String(self._netDao.getPlatformNumFromServer()!)
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), {
                
                self.platformNum.text=platformNumText
                self.platformNum.sizeToFit()
                self.platformNum.center=CGPoint(x:self._width/2,y:15+self.platformNum.frame.height/2)
            });
        })
    }
    
    func showPlatformNum(){

        platformNum.text="--"
        platformNum.font=UIFont(name: _constant._digitalFont, size: 28)
        platformNum.textColor=_constant._redColor
        platformNum.sizeToFit()
        platformNum.center=CGPoint(x:_width/2,y:15+platformNum.frame.height/2)
        self.view.addSubview(platformNum)
        
        platformNumDescript.text="实时监控平台数量"
        platformNumDescript.font=UIFont(name: _constant._textFont, size: 16)
        platformNumDescript.textColor=_constant._redColor
        platformNumDescript.sizeToFit()
        platformNumDescript.center=CGPoint(x:_width/2,y:platformNum.frame.height+platformNum.frame.origin.y+5+platformNumDescript.frame.height/2)
        self.view.addSubview(platformNumDescript)
        
        tableTitleView=UIView(frame: CGRectMake(0, platformNumDescript.frame.height+platformNumDescript.frame.origin.y+15, _width, 36))
        tableTitleView.backgroundColor=_constant._redColor
        self.view.addSubview(tableTitleView)
        tableTitle=UILabel()
        tableTitle.text="实时监控信息"
        tableTitle.font=UIFont(name: _constant._textFont, size: 16)
        tableTitle.textColor=UIColor.whiteColor()
        tableTitle.sizeToFit()
        tableTitle.center=CGPoint(x: 20+tableTitle.frame.width/2,y: tableTitleView.frame.height/2)
        tableTitleView.addSubview(tableTitle)
    }
    
    func weChatLogin(){
        
        print ("weChatLogin")
        var weChatLoginVC=WeChatLoginViewController()
        self.navigationController?.pushViewController(weChatLoginVC, animated: false)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

