/*
The MIT License (MIT)

Copyright (c) 2015 Max Konovalov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import UIKit

class MKRingProgressGroupButton: UIButton {
    
    let contentView = MKRingProgressGroupView()
    
    let selectionIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    var contentMargin: CGFloat = 2 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        selectionIndicatorView.userInteractionEnabled = false
        selectionIndicatorView.backgroundColor = UIColor.clearColor()
        selectionIndicatorView.layer.masksToBounds = false
        selectionIndicatorView.layer.shadowColor = UIColor.whiteColor().CGColor
        selectionIndicatorView.layer.shadowOpacity = 1.0
        selectionIndicatorView.layer.shadowRadius = 1.0
        selectionIndicatorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        addSubview(selectionIndicatorView)
        selectionIndicatorView.hidden = true
        
        contentView.userInteractionEnabled = false
        addSubview(contentView)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = min(bounds.width, bounds.height) - contentMargin * 2
        contentView.frame = CGRect(x: (bounds.width - size)/2, y: (bounds.height - size)/2, width: size, height: size)
        selectionIndicatorView.frame = contentView.frame
        selectionIndicatorView.layer.shadowPath = CGPathCreateCopyByStrokingPath(UIBezierPath(ovalInRect: selectionIndicatorView.bounds.insetBy(dx: -1, dy: -1)).CGPath, nil, 1.0, .Round, .Round, 0)
    }

    override var highlighted: Bool {
        didSet {
            contentView.alpha = highlighted ? 0.3 : 1.0
        }
    }
    
    override var selected: Bool {
        didSet {
            selectionIndicatorView.hidden = !selected
        }
    }
}
