//
//  SwiftyJSONHelper.swift
//  FBPage
//
//  Created by Sierra 2 on 09/10/17.
//  Copyright © 2017 SandsHellCreations. All rights reserved.
//

import UIKit
import SwiftyJSON

infix operator =>
infix operator =|
infix operator =<

typealias OptionalJSON = [String : JSON]?

func =>(key : String, json : OptionalJSON) -> String?{
    return json?[key]?.stringValue
}

func =<(key : String, json : OptionalJSON) -> [String : JSON]?{
    return json?[key]?.dictionaryValue
}

func =|(key : String, json : OptionalJSON) -> [JSON]?{
    return json?[key]?.arrayValue
}

prefix operator /

prefix func /(value: Int?) -> Int {
    return value ?? 0
}

prefix func /(value: [JSON]?) -> [JSON] {
    return value ?? []
}

prefix func /(value: [String]?) -> [String] {
    return value ?? []
}

prefix func /(value : String?) -> String {
    return value ?? ""
}

prefix func /(value : Float?) -> Float {
    return value ?? 0.0
}

prefix func /(value : Double?) -> Double {
    return value ?? 0.0
}

prefix func /(value : Bool?) -> Bool {
    return value ?? false
}

prefix func /(value : CGFloat?) -> CGFloat {
    return value ?? 0.0
}

prefix func /(value : CGPoint?) -> CGPoint {
    return value ?? CGPoint()
}

prefix func /(value : IndexPath?) -> IndexPath {
    return value ?? IndexPath()
}
