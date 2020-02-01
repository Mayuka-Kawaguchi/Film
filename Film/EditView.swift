import UIKit

@available(iOS 13.0, *)
class EditView: UIView {
    
    var delegate: Delegate? 
    @IBOutlet var cameraImageView: UIImageView!
    var filter: CIFilter!
    var filterText: String?
    var pic: UIImage!
    
    @IBAction func sliderValue(_ sender: UISlider) {
        filterText = String(sender.value * 2)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.filterText = filterText
        
        print(appDelegate.filterText)
        reload()
    }
    
    func reload() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        pic = appDelegate.imageName
        let filterImage: CIImage = CIImage(image: pic)!
        filterText = appDelegate.filterText
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(filterText, forKey: "inputSaturation")
        print(filter)
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
//        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
}
