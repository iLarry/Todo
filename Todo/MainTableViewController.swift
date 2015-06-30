//
//  MainTableViewController.swift
//  Todo
//
//  Created by iLarry on 15/6/23.
//  Copyright (c) 2015年 iLarry. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //存储tableview的编辑状态
    var editStatus = false
    
    //保存searchbar是否激活
    var searchActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        tableView.separatorColor = UIColor.grayColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //设置表格的section
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    //设置cell的数量
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (searchActive == true) {
            return todoFilter.count
        } else {
            return testData.count
        }
        
    }

    //设置Cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell, forIndexPath: indexPath) as! CustomTableViewCell

        // Configure the cell...

        var todo:TodoModel?
        
        if (searchActive == true) {
            todo = todoFilter[indexPath.row]
        } else {
            todo = testData[indexPath.row]
        }
        
        
        cell.customImage.image = UIImage(named: todo!.image!)
        cell.title.text = todo!.title!
        cell.date.text = todo!.dateToString()
        
        return cell
    }
    
    //设置Cell的行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    //在选中单元格后，将单元格的indx存储进cellIndexPath
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Override to support conditional editing of the table view.
    //设置表格的设置状态
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    //设置确认删除的标题
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "确认删除？"
    }
    
    //设置是删除还是插入
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    
    // Override to support editing the table view.
    //提交编辑，如果为删除，将删除数据源和单元格
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            testData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    //设置是否可移动
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return editStatus
    }
    
    //移动单元格
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = testData.removeAtIndex(sourceIndexPath.row)
        testData.insert(todo, atIndex: destinationIndexPath.row)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //通过StoryboardSegue传递参数
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        //如果选中的是DetialView
        if(segue.identifier == "DetialView") {
            //获得目标控制器
            var detailView = segue.destinationViewController as! DetailViewController
            //获得当前选中Cell的indexPath，设置为可选类型是为了防止发生没拿到行数而发生崩溃
            var indexCell:NSIndexPath? = tableView.indexPathForSelectedRow()!
            //解包
            if let row = indexCell?.row {
                if searchActive == true {
                    detailView.todoDetail = todoFilter[indexCell!.row]
                } else {
                    //将数据传递给目标控制器的对象
                    detailView.todoDetail = testData[indexCell!.row]
                }
            }
            
        }
    }
    
    //在详细页面确定返回后，重载表格的数据
    @IBAction func unwind(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    //左侧BarButtonItem的单击事件，实现普通状态和编辑状态的切换
    @IBAction func editClick(sender: AnyObject) {
        if editStatus {
            leftBarButton.title = "编辑"
            editStatus = false
            tableView.setEditing(editStatus, animated: true)
        } else {
            leftBarButton.title = "完成"
            editStatus = true
            tableView.setEditing(editStatus, animated: true)
        }
    }
    
    //在输入内容发生变化时
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        todoFilter = testData.filter({(todo:TodoModel) ->Bool in
            let temp = todo.title?.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return temp != nil
        })
        
        if todoFilter.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.tableView.reloadData()
        
        
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = false
        if searchActive {
            println("true")
        } else {
            println("false")
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        if searchActive {
            println("true")
        } else {
            println("false")
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        if searchActive {
            println("true")
        } else {
            println("false")
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        if searchActive {
            println("true")
        } else {
            println("false")
        }
    }
    
}
