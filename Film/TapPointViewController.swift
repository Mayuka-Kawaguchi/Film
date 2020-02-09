import UIKit

class TapPointViewController: UIViewController {
    var tapPoint = CGPoint(x: 0, y: 0)
    var originalTapPoint = CGPoint(x: 0, y: 0)
    var myView: UIScreen!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let location = t.location(in: self.view)
            print(location)
        }
    }
}
