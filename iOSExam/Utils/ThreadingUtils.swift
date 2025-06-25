//
//  ThreadingUtils.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import Foundation

func runOnMain(_ work: @escaping () -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async { work() }
    }
}
