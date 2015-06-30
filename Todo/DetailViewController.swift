//
//  DetailViewController.swift
//  Todo
//
//  Created by iLarry on 15/6/23.
//  Copyright (c) 2015年 iLarry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    //存储传递过来的Todo对象
    var todoDetail:TodoModel?
    
    //四个图片按钮
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var submit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置textField的delegate为自身
        titleText.delegate = self
        contentText.delegate = self

        // Do any additional setup after loading the view.
        
        //设置提交按钮的圆角
        submit.layer.cornerRadius = 5
        
        //如果有传入数据，则载入传入数据
        if todoDetail != nil {
            self.navigationItem.title = "编辑代办事"
            titleText.text = todoDetail?.title
            contentText.text = todoDetail?.content
            datePicker.setDate((todoDetail?.date)!, animated: true)
            
            if(todoDetail?.image == imageSelect.child) {
                childButton.selected = true
            } else if(todoDetail?.image == imageSelect.phone) {
                phoneButton.selected = true
            } else if(todoDetail?.image == imageSelect.shopping) {
                shoppingButton.selected = true
            } else {
                travelButton.selected = true
            }
        } else {
            self.navigationItem.title = "新建代办事"
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
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
    
    //在输入框中点击return后，输入框失去焦点
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        contentText.resignFirstResponder()
        return true
    }
    
    //当触发结束后，输入框失去焦点
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        titleText.resignFirstResponder()
        contentText.resignFirstResponder()
    }
    
    //在每次点击事件后，先把所有的按钮的selected状态都设定为false，再对单个的按钮进行设置
    func setButtonState() {
        childButton.selected = false
        phoneButton.selected = false
        shoppingButton.selected = false
        travelButton.selected = false
    }
    
    
    /*
    
    */
    @IBAction func childTap(sender: AnyObject) {
        setButtonState()
        childButton.selected = true
    }
    @IBAction func phoneTap(sender: AnyObject) {
        setButtonState()
        phoneButton.selected = true
    }
    @IBAction func shoppingCartTap(sender: AnyObject) {
        setButtonState()
        shoppingButton.selected = true
    }
    
    @IBAction func travelTap(sender: AnyObject) {
        setButtonState()
        travelButton.selected = true
    }
    
    
    @IBAction func submit(sender: AnyObject) {
        var image:String?
        if(childButton.selected) {
            image = imageSelect.child
        } else if(phoneButton.selected) {
            image = imageSelect.phone
        } else if(shoppingButton.selected) {
            image = imageSelect.shopping
        } else {
            image = imageSelect.travel
        }
        
        var title = titleText.text
        var content = contentText.text
        var date = datePicker.date
        
        if todoDetail == nil {
            var todo = TodoModel(image: image!, title: title, content: content, date: date)
            testData.append(todo)
        } else {
            todoDetail?.title = title
            todoDetail?.image = image
            todoDetail?.content = content
            todoDetail?.date = date
        }
        
    }
}
