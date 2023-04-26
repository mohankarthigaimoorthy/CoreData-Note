//
//  CustomTextView.swift
//  pepNote
//
//  Created by Mohan K on 13/03/23.
//

import Foundation
import UIKit

class CustomtextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 20)
        self.font = font
        self.autocorrectionType = .no
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
