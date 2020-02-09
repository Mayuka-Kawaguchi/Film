import UIKit

protocol EditViewDelegate: class {
    func passSliderValue()
}


class EditView: UIView {
    
    var delegate: EditViewDelegate?
    @IBOutlet var cameraImageView: UIImageView!
    var filter: CIFilter!
    var filterText: String?
    var pic: UIImage!
    var colorSlider: UISlider!
    
    @IBAction func sliderValue(_ sender: UISlider) {
//        filterText = String(sender.value * 2)
//        let appDelegate = UIApplication.shared.delegate as! EditViewDelegate
//        appDelegate.filterText = filterText
//
//        print(appDelegate.filterText)
//        reload()
        delegate?.passSliderValue()
    }
    
    func reload() {
        let appDelegate = UIApplication.shared.delegate as! EditViewDelegate
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
