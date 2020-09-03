//
//  SplashscreenView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/1/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

@IBDesignable
class SplashscreenView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib(nibName: "SplashscreenView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        addSubview(contentView)
    }

    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view
    }

}
