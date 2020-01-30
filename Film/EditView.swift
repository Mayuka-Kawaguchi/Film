import UIKit

@available(iOS 13.0, *)
class EditView: UIView {
    @IBOutlet var cameraImageView: UIImageView!
//    var view: UIView!
    var filter: CIFilter!
    var filterText: String?
    var pic: UIImage!
    
    @IBAction func sliderValue(_ sender: UISlider) {
        filterText = String(sender.value * 2)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.imageName = pic
        let filterImage: CIImage = CIImage(image: pic)!
        let imageName: CIImage = CIImage(image: appDelegate.imageName)!
        cameraImageView.image = appDelegate.imageName

        print(cameraImageView.image)
        print(filterText)
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue(filterText, forKey: "inputSaturation")
        print(filter)
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage: cgImage!)
    }
}
