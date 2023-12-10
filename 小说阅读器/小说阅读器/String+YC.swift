//
//  String+YC.swift
//  ULCommon
//
//  Created by shetong on 2023/8/9.
//

import Foundation
import UIKit

public extension String {

    var isValidString: Bool {
        return self.isEmpty == false
    }


    func calculateTextSize(textFont: UIFont, maxWidth: CGFloat) -> CGSize {
        var textSize = CGSize.zero
        let attributes: [NSAttributedString.Key: Any] = [.font: textFont]
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let boundingRect = self.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
                                             options: options,
                                             attributes: attributes,
                                             context: nil)
        textSize = boundingRect.size
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
        return textSize
    }


    func calculateTextSize(textFont: UIFont, maxHeight: CGFloat) -> CGSize {
        var textSize = CGSize.zero
        let attributes: [NSAttributedString.Key: Any] = [.font: textFont]
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let boundingRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight),
                                             options: options,
                                             attributes: attributes,
                                             context: nil)
        textSize = boundingRect.size
        textSize.width = ceil(textSize.width)
        textSize.height = ceil(textSize.height)
        return textSize
    }
}
