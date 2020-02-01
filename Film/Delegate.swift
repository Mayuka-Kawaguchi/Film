import UIKit

protocol delegate {
    func reload()
}

class Delegate: UIResponder, UIApplicationDelegate {

var imageName: UIImage!
var filterText: String?
}
