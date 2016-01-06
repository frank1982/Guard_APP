
import UIKit

class AddProductViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    var _constant:Constant=Constant()
    var selectTable:UITableView!
    var _width:CGFloat!
    var _height:CGFloat!
    var prodctDicArray0:NSMutableArray!
    var prodctDicArray1:NSMutableArray!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()

        var titleLabel=UILabel(frame:CGRectMake(0, 0, 80, 44))
        titleLabel.text="添加监控"
        titleLabel.font=UIFont(name: _constant._textFont, size: 20)
        titleLabel.textColor=_constant._redColor
        self.navigationItem.titleView = titleLabel;
        self.navigationController!.navigationBar.translucent = false//取消渐变效果...
        
        _width=self.view.frame.width
        _height=self.view.frame.height
        var searchTextField=UITextField(frame:CGRectMake(0,0, _width, 44))
        searchTextField.placeholder="请输入要监控的产品"
        searchTextField.borderStyle=UITextBorderStyle.Line
        searchTextField.layer.borderColor=_constant._redColor.CGColor
        searchTextField.leftView=UIView(frame:CGRectMake(0,0, 20, 44))
        searchTextField.leftViewMode=UITextFieldViewMode.Always
        searchTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        searchTextField.delegate=self
        //监听中文需要添加
        searchTextField.addTarget(self, action: "textFieldDidChanged:", forControlEvents: UIControlEvents.EditingChanged)
        self.view.addSubview(searchTextField)
        
        var tableHeight=UIScreen.mainScreen().bounds.height-searchTextField.frame.origin.y-searchTextField.frame.height
        selectTable=UITableView(frame: CGRectMake(0, searchTextField.frame.origin.y+searchTextField.frame.height
            , _width, tableHeight))
        selectTable.backgroundColor=UIColor.grayColor()
        selectTable.delegate=self
        selectTable.dataSource=self
        self.view.addSubview(selectTable)
        
        //get local product
        prodctDicArray0=Dao.getLocalProduct()
        prodctDicArray1=Dao.getLocalProduct()
        
    }
    
    //监听中文
    func textFieldDidChanged(textField:UITextField){
        
        print(textField.text)
        var inputStr=textField.text
        //word filter
        var tmpDicArry:NSMutableArray=NSMutableArray()
        if inputStr != ""{
            
            for mydictionary in prodctDicArray0{
                var str=mydictionary["productName"] as! String
                if str.rangeOfString(inputStr!) != nil {
                    tmpDicArry.addObject(mydictionary)
                }
            }
            prodctDicArray1=tmpDicArry
            self.selectTable.reloadData()
            
        }else{
            
            prodctDicArray1=prodctDicArray0
            self.selectTable.reloadData()
        }
    }
    
    //监听输入，这个只监听英文
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print(string)
        return true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //最多显示20条;
        return prodctDicArray1.count >= 20 ? 20:prodctDicArray1.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "cellIdentifier"
        var cell=ProductCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier,dic: prodctDicArray1[indexPath.row] as! NSMutableDictionary,cellHeight:60,cellWidth:_width)
        return cell
        
    }
    
    //click cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 }
