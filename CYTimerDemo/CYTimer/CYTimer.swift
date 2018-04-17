//
//  CYTimer.swift
//  CYTimerDemo
//
//  Created by CocoaYog on 2018/4/16.
//  Copyright © 2018年 CocoaYog. All rights reserved.
//

import UIKit

class CYTimer: NSObject {
    static var shared = CYTimer.init()
    private var isSuspend:Bool = false
    
    private var timerSource:DispatchSourceTimer?
    /// 便利构造器（注意：定时器被创建后，必须被其他实例对象持有，否则将立即销毁）
    convenience init(queue:DispatchQueue? = DispatchQueue.main,timeInterval:TimeInterval,repeats:Bool,isIMEXE:Bool = false ,block:@escaping(_ timer:CYTimer?)->()){
        self.init()
        self.timer(queue: queue, timeInterval: timeInterval, repeats: repeats,isIMEXE: isIMEXE, block: block)
        
    }
    
    
    /// 创建定时器，如果定时器已存在，上一个定时器被取消重新创建
    ///
    /// - Parameters:
    ///   - queue: 指定运行的队列，默认为主队列
    ///   - timeInterval: 定时器时间间隔
    ///   - repeats: 是否重复执行
    ///   - isIMEXE: 创建后是否立即执行，默认 false
    ///   - block: 定时器任务
    func timer(queue:DispatchQueue?,timeInterval:TimeInterval,repeats:Bool,isIMEXE:Bool = false,block:@escaping(_ timer:CYTimer?)->()){
        cancel()
        var dispatchQueue  = DispatchQueue.main;
        if let queue = queue{
            dispatchQueue = queue
        }
        timerSource =    DispatchSource.makeTimerSource(flags: [.strict], queue: dispatchQueue)
        
        if repeats {
            let wallDeadline = isIMEXE == true ? DispatchWallTime.now() : DispatchWallTime.now() + timeInterval
            timerSource?.schedule(wallDeadline:wallDeadline, repeating: timeInterval)
        }else{
            let wallDeadline = DispatchWallTime.now() + timeInterval
            timerSource?.schedule(wallDeadline: wallDeadline, repeating: .infinity)
        }
        
        timerSource?.setEventHandler(handler: {[weak self] in
            block(self)
        })
        timerSource?.resume()
    }
    
    
    /// 取消定时器，取消后请重新创建
    func cancel(){
        if let sourceTime = timerSource,
            !sourceTime.isCancelled {
            
            if isSuspend {
                sourceTime.resume()
            }
            sourceTime.cancel()
            isSuspend = false
            timerSource = nil
        }
    }
    
    
    /// 暂停定时器
    func suspend(){
        if !isSuspend {
            timerSource?.suspend()
            isSuspend = true
        }
    }
    
    
    /// 启动定时器
    func resume(){
        if isSuspend {
            timerSource?.resume()
            isSuspend = false
        }
    }
    
    deinit {
        cancel()
    }

}
