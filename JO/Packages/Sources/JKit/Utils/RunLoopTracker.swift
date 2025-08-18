//
//  RunLoopTracker.swift
//  WGKit
//
//  Created by laichunhui on 2023/3/14.
//


import Foundation
import Combine

public final class RunLoopTracker: @unchecked Sendable, ObservableObject {
    /// rooloop切换到tracking模式，比如滑动tableView
    @Published public var isTracking = false
    
    private let runLoop: RunLoop
    private var taskSet = false
    /// 应用空闲状态
    @Published public var isFree = false
    var timeoutCount = 0
    
    var runloopObserver: CFRunLoopObserver?
    @Published public var runLoopActivity: CFRunLoopActivity?
    var dispatchSemaphore: DispatchSemaphore?
    
    public init(runLoop: RunLoop = .main) {
        self.runLoop = runLoop
        submitTaskForTrackingMode()
    }
    
    private func submitTaskForTrackingMode() {
        if !taskSet {
            runLoop.perform(inModes: [.tracking]) { [weak self] in
                self?.notify()
            }
            taskSet = true
        }
    }
    
    private func notify() {
        isTracking = true
        taskSet = false
        submitTaskForDefaultMode()
    }
    
    private func submitTaskForDefaultMode() {
        if !taskSet {
            runLoop.perform(inModes: [.default]) { [weak self] in
                guard let self = self else {return}
                self.isTracking = false
                self.submitTaskForTrackingMode()
            }
        }
    }
    
    // 原理：进入睡眠前方法的执行时间过长导致无法进入睡眠，或者线程唤醒之后，一直没进入下一步
    public func start() {
        let uptr = Unmanaged.passRetained(self).toOpaque()
        let vptr = UnsafeMutableRawPointer(uptr)
        var context = CFRunLoopObserverContext.init(version: 0, info: vptr, retain: nil, release: nil, copyDescription: nil)
        
        runloopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                  CFRunLoopActivity.allActivities.rawValue,
                                                  true,
                                                  0,
                                                  observerCallBack(),
                                                  &context)
        CFRunLoopAddObserver(CFRunLoopGetMain(), runloopObserver, .commonModes)
        
        // 初始化的信号量为0
        dispatchSemaphore = DispatchSemaphore.init(value: 0)
        
        DispatchQueue.global().async {
            while true {
                // 方案一：可以通过设置单次超时时间来判断 比如250毫秒
                // 方案二：可以通过设置连续多次超时就是卡顿 戴铭在GCDFetchFeed中认为连续三次超时80秒就是卡顿
                let st = self.dispatchSemaphore?.wait(timeout: DispatchTime.now() + .milliseconds(80))

                if st == .timedOut {
                    guard self.runloopObserver != nil else {
                        self.dispatchSemaphore = nil
                        self.runLoopActivity = nil
                        self.timeoutCount = 0
                        return
                    }

                    if self.runLoopActivity == .afterWaiting || self.runLoopActivity == .beforeSources {
                        self.timeoutCount += 1
                        if self.timeoutCount < 3 { continue }
                        print("发生卡顿")
                    }
                }
            }
        }
    }
    
    public func end() {
        guard let _ = runloopObserver else { return }
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), runloopObserver, .commonModes)
        runloopObserver = nil
    }
    
    private func observerCallBack() -> CFRunLoopObserverCallBack {
        return { (observer, activity, context) in
            let weakself = Unmanaged<RunLoopTracker>.fromOpaque(context!).takeUnretainedValue()
            weakself.isFree = activity == .beforeWaiting
            weakself.runLoopActivity = activity
            weakself.dispatchSemaphore?.signal()
        }
    }
    
}

