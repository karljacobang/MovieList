//
//  Results.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import Foundation

enum Results<Value> {
    case success(Value)
    case failure(String)
}
