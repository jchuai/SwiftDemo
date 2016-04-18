//
//  MutexLock.swift
//  baomingba
//
//  Created by Junna on 4/18/16.
//  Copyright © 2016 杭州求道网络科技有限公司. All rights reserved.
//

import Foundation

class MutexLock {
    private var mutex = pthread_mutex_t()
    private func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    private func unlock() {
        pthread_mutex_unlock(&mutex)
    }
    
    func run(block: Void -> Void) {
        lock()
        block()
        unlock()
    }
}