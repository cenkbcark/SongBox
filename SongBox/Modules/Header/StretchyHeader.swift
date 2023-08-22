//
//  StretchyHeader.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import UIKit

class StretchyHeader: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet var iconImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var iconImageViewBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        let nib = UINib(nibName: String(describing: StretchyHeader.self), bundle: nil)
        if let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeightConstraint.constant = scrollView.contentInset.top
                let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
                containerView.clipsToBounds = offsetY <= 0
        iconImageViewBottomConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        iconImageViewHeightConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
