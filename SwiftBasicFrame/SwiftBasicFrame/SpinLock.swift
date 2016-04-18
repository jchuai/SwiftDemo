//
//  SpinLock.swift
//  baomingba
//
//  Created by XiaoshaQuan on 3/3/16.
//  Copyright © 2016 杭州求道网络科技有限公司. All rights reserved.
//

import Foundation


class SpinLock {
    
    private var _lock : OSSpinLock
    
    init() {
        _lock = OS_SPINLOCK_INIT
    }
    
    func lock() {
        OSSpinLockLock(&_lock)
    }
    
    func unlock() {
        OSSpinLockUnlock(&_lock)
    }
    
    func run(block: Void -> Void) {
        lock()
        block()
        unlock()
    }
    
}




