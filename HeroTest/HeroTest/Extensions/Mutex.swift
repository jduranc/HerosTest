//
//  Mutex.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

class Mutex: NSObject {
	static func synced(_ lock: Any, closure: () -> ()) {
		objc_sync_enter(lock)
		closure()
		objc_sync_exit(lock)
	}
}
