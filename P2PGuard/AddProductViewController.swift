
import UIKit

class AddProductViewController: UIViewController{
    
    var _constant:Constant=Constant()
    //var searchBar:UISearchBar!
    var _width:CGFloat!
    var _height:CGFloat!
 
    
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
        self.view.addSubview(searchTextField)
        
        

        
        /*
        searchBar=UISearchBar(frame:CGRectMake(0,0, _width, 44))
        //searchBar.delegate=self
        
        for view in searchBar.subviews {
            
            if view.isKindOfClass(NSClassFromString("UIView")!) && view.subviews.count > 0{
                
                view.subviews[0].removeFromSuperview()
            }
        }
        searchBar.barTintColor=UIColor.redColor()
        
        // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
        var textField=searchBar.subviews[0].subviews.last as! UITextField
        textField.backgroundColor=UIColor.orangeColor()
        textField.layer.cornerRadius = 4.0;
        //textField.frame.origin=CGPoint(x: 100,y: 20)
        
        searchBar.layer.borderWidth=1
        searchBar.layer.borderColor=_constant._redColor.CGColor
        searchBar.placeholder="请输入要监控的产品"
        self.view.addSubview(searchBar)
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 }
