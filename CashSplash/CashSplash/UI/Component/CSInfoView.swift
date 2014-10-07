//
//  CSInfoView.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 07/10/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

class CSInfoView: UIView {
    
    // MARK: - Properties
    
    var text : NSString?
    private let textLabel : UILabel

    // MARK: - Init
    
    override init(frame: CGRect) {
        self.textLabel = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10.0
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        
        self.textLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        self.textLabel.textColor = UIColor.whiteColor()
        self.textLabel.backgroundColor = UIColor.clearColor()
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.textLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.textLabel = UILabel()
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel.text = self.text
    }
    
    // MARK: - Public methods
    
    class func animateWithDuration(duration: Double, fadeDuration: Double, text: String) {
        let window = UIApplication.sharedApplication().keyWindow
        CSInfoView.animateWithDuration(duration, fadeDuration: fadeDuration, text: text, containerView: window)
    }
    
    class func animateWithDuration(duration: Double, fadeDuration: Double, text: String, containerView: UIView) {
        let viewSize = containerView.frame.size
        var offset = CGPointZero
        if containerView is UIScrollView {
            let scrollView = containerView as UIScrollView
            offset = scrollView.contentOffset
        }
        
        let defaultWidth = CGFloat(100.0)
        let defaultHeight = CGFloat(75.0)
        
        // Centered in container view with default width/height
        let frame = CGRectMake((viewSize.width - defaultWidth) / 2.0, (viewSize.height - defaultHeight) / 2.0, defaultWidth, defaultHeight)
        
        let infoView = CSInfoView(frame: frame)
        infoView.text = text
        infoView.alpha = 0
        containerView.addSubview(infoView)
        
        UIView.animateWithDuration(fadeDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            infoView.alpha = 1
            }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(fadeDuration, delay: duration, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                infoView.alpha = 0
                }, completion: { (finished: Bool) -> Void in
                infoView.removeFromSuperview()
            })
        }
    }

}
