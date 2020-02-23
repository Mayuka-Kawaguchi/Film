//
//  FilterView.swift
//  Film
//
//  Created by K Mayuka on 2020/02/23.
//  Copyright © 2020 K Mayuka. All rights reserved.
//

import UIKit

protocol FilterViewDelegate: class {
    func passSliderValue()
}


class FilterView: UIView {
    
//    @IBOutlet var inversionButton: UIButton!
    var filter: CIFilter!
    var filterText: String?
    var pic: UIImage!
    var view: UIView! {
        didSet {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    var transMiller = CGAffineTransform()
    weak var delegate: FilterViewDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantinateFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantinateFromNib()
    }
    
    func instantinateFromNib() {
        view = Bundle(for: type(of: self)).loadNibNamed("FilterView", owner: self, options: nil)?.first as? UIView
        addSubview(view)
        NSLayoutConstraint.activate([
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
   @IBAction func inversion() {
        let picker = view
        transMiller = CGAffineTransform(scaleX: -1, y: 1)
        picker!.transform = transMiller
        print("inversion")
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

