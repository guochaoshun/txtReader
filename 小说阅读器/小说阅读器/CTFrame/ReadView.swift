//
//  ReadView.swift
//  小说阅读器
//
//  Created by 郭朝顺 on 2023/11/4.
//

import UIKit

class ReadView: UIView {


    override init(frame: CGRect) {

        super.init(frame: frame)

        // 正常使用
        self.backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    /// CTFrame
    var frameRef:CTFrame? {

        didSet{
            if frameRef != nil {
                self.setNeedsDisplay()
            }
        }
    }


    /// 绘制
    override func draw(_ rect: CGRect) {
        guard let frame = frameRef, let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        ctx.textMatrix = CGAffineTransform.identity
        ctx.translateBy(x: 0, y: bounds.size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        CTFrameDraw(frame, ctx)
    }
}
