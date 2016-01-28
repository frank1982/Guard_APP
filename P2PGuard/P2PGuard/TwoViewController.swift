
import UIKit

class TwoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var _constant:Constant=Constant()
    var _width:CGFloat!
    var _height:CGFloat!
    var infoTable:UITableView!
    var infoDicArray:NSMutableArray!
    var refreshControl: UIRefreshControl!
    var netDao:NetDao=NetDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //判断有没有登录？
        if Dao.getLoginId() == nil {//未登录
            
            var des=LoginViewController()
            var animation=CATransition()
            animation.duration=0.5
            animation.timingFunction=CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
            animation.type="pageCurl"
            animation.subtype=kCATransitionFromBottom
            self.navigationController!.view.layer.addAnimation(animation, forKey: nil)
            self.navigationController?.pushViewController(des, animated: false)
 
        }
        
        _width=self.view.frame.width
        _height=UIScreen.mainScreen().bounds.height
        self.view.backgroundColor=UIColor.whiteColor()

        
        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        //titleLabel.backgroundColor=UIColor.greenColor()
        titleLabel.text="我的通知"
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        
        //加载表格
        infoTable=UITableView(frame:CGRectMake(0,0,_width,_height))
        infoTable.backgroundColor=UIColor.whiteColor()
        infoTable.dataSource=self
        infoTable.delegate=self
        self.view.addSubview(infoTable)
        infoTable.separatorStyle=UITableViewCellSeparatorStyle.None
        
        //下拉刷新控件初始化...
        refreshControl=UIRefreshControl()
        infoTable.addSubview(refreshControl)
        refreshControl.attributedTitle=NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)

        //infoTable.tableFooterView
        
        //首次加载前10条
        infoDicArray=netDao.getMyNews(Dao.getLoginId()!, limit: "10", offset: "0")
        //print(infoDicArray)
        
    }
    
    func refresh(){
        
        print("refresh")
        infoDicArray=netDao.getMyNews(Dao.getLoginId()!, limit: "10", offset: "0")
        self.infoTable.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("select cell")
        var des=GuardDetailViewController()
        des._dic=infoDicArray[indexPath.row] as! NSMutableDictionary
        var animation=CATransition()
        animation.duration=0.5
        animation.timingFunction=CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
        animation.type="pageCurl"
        animation.subtype=kCATransitionFromBottom
        self.navigationController!.view.layer.addAnimation(animation, forKey: nil)
        self.navigationController?.pushViewController(des, animated: false)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return infoDicArray.count
    }
    
    //table的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return _height/10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "GuardCell"
        var cell=GuardCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier,dic: infoDicArray[indexPath.row] as! NSMutableDictionary,cellHeight:_height/10,cellWidth:_width)

        return cell

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
