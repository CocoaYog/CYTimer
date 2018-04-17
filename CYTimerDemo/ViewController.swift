//
//  ViewController.swift
//  CYTimerDemo
//
//  Created by CocoaYog on 2018/4/16.
//  Copyright © 2018年 CocoaYog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer:CYTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useMethod1()
        
       
    }
    
    
    /// 设置一个重复执行的定时器
    /// 默认在主队列执行，且不立即执行
    func useMethod1() {
        // 注意： CYTimer 对象必须被其他实例对象持有，否则在创建后会立即销毁 ！！！！
        timer = CYTimer.init(timeInterval: 2, repeats: true, block: {[weak self]  (timer) in
             self?.timerAction()
        })
         print("计时器已创建，并启动",NSDate.init().description)
    }
    
    /// 设置一个立即执行一次的重复执行的定时器
    /// isIMEXE = true 为立即执行，默认为不立即执行, 该参数只对重复执行的定时器有效
    /// 默认在主队列执行，且立即执行
    func useMethod2(){
       
        timer = CYTimer.init(queue: nil, timeInterval: 10, repeats: true, isIMEXE: true, block: {[weak self]  (timer) in
            self?.timerAction()
        })
         print("计时器已创建，并启动",NSDate.init().description)
    }
    
    
    /// 设置一个在指定队列执行的重复定时器
    /// queue 参数为指定的队列，默认在主队列执行
    func useMethod3(){
        timer = CYTimer.init(queue: DispatchQueue.init(label: "custom-queue"), timeInterval: 2, repeats: true, isIMEXE: true, block: {[weak self]  (timer) in
            self?.timerAction()
        })
        print("计时器已创建，并启动",NSDate.init().description)
    }
    
    
    /// 设置一个延时执行的定时器，不重复
    /// 默认在主队列
    func useMethod4(){
        timer = CYTimer.init(timeInterval: 2, repeats: false, block: {[weak self]  (timer) in
            self?.timerAction()
        })
        print("计时器已创建，并启动",NSDate.init().description)
    }
    
    
    /// 设置一个在指定队列执行的延时定时器，不重复
    func useMethod5(){
        timer = CYTimer.init(queue: DispatchQueue.init(label: "custom-queue"), timeInterval: 2, repeats: false, isIMEXE: false, block: { [weak self]  (timer) in
            self?.timerAction()
        })
        print("计时器已创建，并启动",NSDate.init().description)
    }
    
    
    /// 暂停控制器
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func suspendTimerAction(_ sender: UIButton) {
        timer?.suspend()
       print("定时器暂停：",NSDate.init())
    }
    
    
    /// 启动定时器
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func resumeTimerAction(_ sender: UIButton) {
        timer?.resume()
          print("定时器启动/重启：",NSDate.init())
    }
    
    
    /// 取消定时器
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func cancelTimer(_ sender: UIButton) {
        timer?.cancel()
        print("定时器取消：",NSDate.init())
    }
    
    
    /// 重设定时器
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func resetTimer(_ sender: UIButton) {
        timer?.timer(queue: DispatchQueue.global(), timeInterval: 4, repeats: true, block: { [weak self](_) in
            self?.timerAction()
        })
         print("定时器重设：",NSDate.init())
    }
    
}

extension ViewController {
    
    func timerAction() {
        print("定时器执行时间:",NSDate.init().description)
        print("当前线程:",Thread.current)
        
    }
}

