

import Foundation
import QuartzCore
import UIKit

var traitPollingTimer: CADisplayLink?

extension KeyboardViewController {
    
    func addInputTraitsObservers() {
        traitPollingTimer?.invalidate()
        traitPollingTimer?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
}