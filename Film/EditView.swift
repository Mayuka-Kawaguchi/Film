import UIKit

protocol EditViewDelegate: class {
    func passSliderValue()
}


class EditView: UIView {
    
    @IBOutlet var colorSlider: UISlider!
    var filter: CIFilter!
    var filterText: String?
    var pic: UIImage!
    var view: UIView! {
        didSet {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    weak var delegate: EditViewDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantinateFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantinateFromNib()
    }
    
    func instantinateFromNib() {
        view = Bundle(for: type(of: self)).loadNibNamed("EditView", owner: self, options: nil)?.first as? UIView
        addSubview(view)
        NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @IBAction func sliderValue(_ sender: UISlider) {
        delegate?.passSliderValue()
        print("delegate Called")
    }

    
//    func reload() {
//        let appDelegate = UIApplication.shared.delegate as! EditViewDelegate
//        pic = appDelegate.imageName
//        let filterImage: CIImage = CIImage(image: pic)!
//        filterText = appDelegate.filterText
//        filter = CIFilter(name: "CIColorControls")!
//        filter.setValue(filterImage, forKey: kCIInputImageKey)
//        filter.setValue(filterText, forKey: "inputSaturation")
//        print(filter)
//        let ctx = CIContext(options: nil)
//        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
////        cameraImageView.image = UIImage(cgImage: cgImage!)
//    }
    
}
