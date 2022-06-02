//
//  ReusableView.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }

}
