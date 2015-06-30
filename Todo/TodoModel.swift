//
//  TodoModel.swift
//  Todo
//
//  Created by iLarry on 15/6/23.
//  Copyright (c) 2015年 iLarry. All rights reserved.
//

import Foundation

//封装4个图片名
var imageSelect = (child:"child-selected", phone:"phone-selected", shopping:"shopping-cart-selected", travel:"travel-selected")

//保存过滤后的数据
var todoFilter:[TodoModel] = []

//在运行时保存数据
var testData:[TodoModel] = [TodoModel(image: imageSelect.child, title: "要去游乐场", content: "上次答应小胖子的", date: NSDate(timeIntervalSinceNow: 60*60*24*3)),  TodoModel(image: imageSelect.phone, title: "打一个电话给周", content: "", date: NSDate(timeIntervalSinceNow: 60*60*24*2)), TodoModel(image: imageSelect.shopping, title: "去家乐福", content: "买米，方便面", date: NSDate(timeIntervalSinceNow: 60*60*24*5)), TodoModel(image: imageSelect.travel, title: "苏州", content: "看外婆", date: NSDate(timeIntervalSinceNow: 60*60*24*15))]

class TodoModel {
    var image:String?
    var title:String?
    var content:String?
    var date:NSDate?
    
    
    init(image:String, title:String, content:String, date:NSDate) {
        self.image = image
        self.title = title
        self.content = content
        self.date = date
    }
    
    //将日期转换成字符串
    func dateToString() -> String {
        var dateMatter = NSDateFormatter()
        dateMatter.dateFormat = "yyyy-MM-dd"
        var dateString = dateMatter.stringFromDate(date!)
        return dateString
    }
    
    //计算目标日期和当前日期相差的天数
    func nowIntervalDateDay() -> Double {
        var now = NSDate()
        var interval:Double = now.timeIntervalSinceDate(date!)
        var intervalDay = interval / 60 / 60 / 24
        return intervalDay
    }
}
