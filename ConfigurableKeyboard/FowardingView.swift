
import UIKit

class ForwardingView: UIView {
    
    var touchToView: [UITouch:UIView]
    
    override init(frame: CGRect) {
        self.touchToView = [:]
        
        super.init(frame: frame)
        
        self.contentMode = UIViewContentMode.Redraw
        self.multipleTouchEnabled = true
        self.userInteractionEnabled = true
        self.opaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func drawRect(rect: CGRect) {}
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        if self.hidden || self.alpha == 0 || !self.userInteractionEnabled {
            return nil
        }
        else {
            return (CGRectContainsPoint(self.bounds, point) ? self : nil)
        }
    }
    
    func handleControl(view: UIView?, controlEvent: UIControlEvents) {
        if let control = view as? UIControl {
            let targets = control.allTargets()
            for target in targets {
                let actions = control.actionsForTarget(target, forControlEvent: controlEvent)
                if (actions != nil) {
                    for action in actions! {
                        let selector = Selector(action )
                        control.sendAction(selector, to: target, forEvent: nil)
                    }
                }
            }
        }
    }
    
    func findNearestView(position: CGPoint) -> UIView? {
        if !self.bounds.contains(position) {
            return nil
        }
        
        var closest: (UIView, CGFloat)? = nil
        
        for anyView in self.subviews {
            let view = anyView 
            
            if view.hidden {
                continue
            }
            
            view.alpha = 1
            
            let distance = distanceBetween(view.frame, point: position)
            
            if closest != nil {
                if distance < closest!.1 {
                    closest = (view, distance)
                }
            }
            else {
                closest = (view, distance)
            }
        }
        
        if closest != nil {
            return closest!.0
        }
        else {
            return nil
        }
    }
    
    func distanceBetween(rect: CGRect, point: CGPoint) -> CGFloat {
        if CGRectContainsPoint(rect, point) {
            return 0
        }
        
        var closest = rect.origin
        
        if (rect.origin.x + rect.size.width < point.x) {
            closest.x += rect.size.width
        }
        else if (point.x > rect.origin.x) {
            closest.x = point.x
        }
        if (rect.origin.y + rect.size.height < point.y) {
            closest.y += rect.size.height
        }
        else if (point.y > rect.origin.y) {
            closest.y = point.y
        }
        
        let a = pow(Double(closest.y - point.y), 2)
        let b = pow(Double(closest.x - point.x), 2)
        return CGFloat(sqrt(a + b));
    }
    
    func resetTrackedViews() {
        for view in self.touchToView.values {
            self.handleControl(view, controlEvent: .TouchCancel)
        }
        self.touchToView.removeAll(keepCapacity: true)
    }
    
    func ownView(newTouch: UITouch, viewToOwn: UIView?) -> Bool {
        var foundView = false
        
        if viewToOwn != nil {
            for (touch, view) in self.touchToView {
                if viewToOwn == view {
                    if touch == newTouch {
                        break
                    }
                    else {
                        self.touchToView[touch] = nil
                        foundView = true
                    }
                    break
                }
            }
        }
        
        self.touchToView[newTouch] = viewToOwn
        return foundView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for obj in touches {
            let touch = obj as? UITouch
            let position = touch!.locationInView(self)
            let view = findNearestView(position)
            
            let viewChangedOwnership = self.ownView(touch!, viewToOwn: view)
            
            if !viewChangedOwnership {
                self.handleControl(view, controlEvent: .TouchDown)
                
                if touch!.tapCount > 1 {
                    self.handleControl(view, controlEvent: .TouchDownRepeat)
                }
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for obj in touches {
            let touch = obj as? UITouch
            let position = touch!.locationInView(self)
            
            let oldView = self.touchToView[touch!]
            let newView = findNearestView(position)
            
            if oldView != newView {
                self.handleControl(oldView, controlEvent: .TouchDragExit)
                
                let viewChangedOwnership = self.ownView(touch!, viewToOwn: newView)
                
                if !viewChangedOwnership {
                    self.handleControl(newView, controlEvent: .TouchDragEnter)
                }
                else {
                    self.handleControl(newView, controlEvent: .TouchDragInside)
                }
            }
            else {
                self.handleControl(oldView, controlEvent: .TouchDragInside)
            }
        }

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for obj in touches {
            let touch = obj 
            
            let view = self.touchToView[touch]
            
            let touchPosition = touch.locationInView(self)
            
            if self.bounds.contains(touchPosition) {
                self.handleControl(view, controlEvent: .TouchUpInside)
            }
            else {
                self.handleControl(view, controlEvent: .TouchCancel)
            }
            
            self.touchToView[touch] = nil
        }

    }
  
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        for obj in touches! {
            let touch = obj as! UITouch
            
            var view = self.touchToView[touch]
            
            self.handleControl(view, controlEvent: .TouchCancel)
            
            self.touchToView[touch] = nil
        }
    }
}
