import UIKit

class TapPointViewController: UIViewController {
    var tapPoint = CGPoint(x: 0, y: 0)
    var originalTapPoint = CGPoint(x: 0, y: 0)
    var myView: UIScreen!
    
    //    override func viewDidLoad() {
    //        myView = UIScreen.main
    //        myView.userInteractionEnabled = true
    //        myView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction:"))
    //    }
    //    func tapAction(sender:UITapGestureRecognizer) {
    //        tapPoint = sender.location(in: self.view)
    //
    //        originalTapPoint.x = UIScreen.main.bounds.size.width * tapPoint.x
    //        originalTapPoint.y = UIScreen.main.bounds.size.height * tapPoint.y
    //        print(originalTapPoint)
    //        print("aaaaaaaaaa")
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let location = t.location(in: self.view)
            print(location)
        }
    }
}
