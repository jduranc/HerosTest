//
//  Mutex.swift
//  HeroTest
//
//  Created by Luis Duran on 3/8/21.
//

import UIKit

class Mutex: NSObject {
	
	/**
	Perform synced call of closure, based on the object as mutex.
	- Parameters:
		- lock: object used as mutex.
		- closure: the code to be executed on synced way.
	*/
	static func synced(_ lock: Any, closure: () -> ()) {
		objc_sync_enter(lock)
		closure()
		objc_sync_exit(lock)
	}
}
