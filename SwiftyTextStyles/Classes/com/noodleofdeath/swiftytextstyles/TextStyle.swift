//
// The MIT License (MIT)
//
// Copyright © 2019 NoodleOfDeath. All rights reserved.
// NoodleOfDeath
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Foundation

public func + <Key: Hashable, Value: Any>(lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
    var dict = lhs
    rhs.forEach { dict[$0.key] = $0.value }
    return dict
}

public func + <Key: Hashable, Value: Any>(lhs: Dictionary<Key, Value>?, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value>? {
    var dict = lhs
    rhs.forEach { dict?[$0.key] = $0.value }
    return dict
}

public func + <Key: Hashable, Value: Any>(lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>?) -> Dictionary<Key, Value> {
    var dict = lhs
    rhs?.forEach { dict[$0.key] = $0.value }
    return dict
}

public func + <Key: Hashable, Value: Any>(lhs: Dictionary<Key, Value>?, rhs: Dictionary<Key, Value>?) -> Dictionary<Key, Value>? {
    var dict = lhs
    rhs?.forEach { dict?[$0.key] = $0.value }
    return dict
}

public func += <Key: Hashable, Value: Any>(lhs: inout Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) {
    rhs.forEach { lhs[$0.key] = $0.value }
}

public func += <Key: Hashable, Value: Any>(lhs: inout Dictionary<Key, Value>?, rhs: Dictionary<Key, Value>) {
    rhs.forEach { lhs?[$0.key] = $0.value }
}

public func += <Key: Hashable, Value: Any>(lhs: inout Dictionary<Key, Value>, rhs: Dictionary<Key, Value>?)  {
    rhs?.forEach { lhs[$0.key] = $0.value }
}

public func += <Key: Hashable, Value: Any>(lhs: inout Dictionary<Key, Value>?, rhs: Dictionary<Key, Value>?) {
    rhs?.forEach { lhs?[$0.key] = $0.value }
}

extension NSAttributedStringKey: Codable {}

// MARK: - NSAttributedStringKey Class Extensions
extension NSAttributedStringKey {
    
    /// Attribute name key for alpha.
    public static let alpha
        = NSAttributedStringKey("NSAlpha")
    
    /// Attribute name key for icon alpha.
    public static let iconAlpha
        = NSAttributedStringKey("NSIconAlpha")
    
    /// Attribute name key for icon shadow.
    public static let iconShadow
        = NSAttributedStringKey("NSIconShadow")
    
    /// Attribute name key for icon tint color.
    public static let iconTintColor
        = NSAttributedStringKey("NSIconTintColor")
    
    /// Attribute name key for point size.
    public static let pointSize
        = NSAttributedStringKey("NSPointSize")
    
    /// Attribute name key for shadow blur radius.
    public static let shadowBlurRadius
        = NSAttributedStringKey("NSShadowBlurRadius")
    
    /// Attribute name key for shadow color.
    public static let shadowColor
        = NSAttributedStringKey("NSShadowColor")
    
    /// Attribute name key for shadow offset.
    public static let shadowOffset
        = NSAttributedStringKey("NSShadowOffset")
    
    /// Attribute name key for tint color.
    public static let textAlignment
        = NSAttributedStringKey("NSTextAlignment")
    
    /// Attribute name key for tint color.
    public static let tintColor
        = NSAttributedStringKey("NSTintColor")
    
}

public typealias TextStyle = [NSAttributedStringKey: Any]

public protocol JSONEncodable {
    
    var jsonObject: [String: Any] { get }
    
}

public protocol JSONDecodable {
    
    associatedtype DecodableType
    
    static func decode(from object: Any?) -> DecodableType?
    
}

public typealias JSONCodable = JSONEncodable & JSONDecodable

extension NSParagraphStyle: JSONCodable {
    
    public typealias DecodableType = NSParagraphStyle
    
    open var jsonObject: [String: Any] {
        var map = [String: Any]()
        
        return map
    }
    
    open class func decode(from object: Any?) -> DecodableType? {
        if let object = object as? DecodableType { return object }
        return nil
    }
    
}

extension NSShadow: JSONCodable {
    
    public typealias DecodableType = NSShadow
    
    open var jsonObject: [String: Any] {
        var map = [String: Any]()
        map[NSAttributedStringKey.foregroundColor] = color
        map[NSAttributedStringKey.shadowBlurRadius] = shadowBlurRadius
        map[NSAttributedStringKey.shadowOffset] = shadowOffset
        return map
    }
    
    open class func decode(from object: Any?) -> DecodableType? {
        if let object = object as? DecodableType { return object }
        return nil
    }
    
}

extension NSTextAttachment: JSONCodable {
    
    public typealias DecodableType = NSTextAttachment
    
    open var jsonObject: [String: Any] {
        var map = [String: Any]()
        
        return map
    }
    
    open class func decode(from object: Any?) -> DecodableType? {
        if let object = object as? DecodableType { return object }
        return nil
    }
    
}

extension UIColor: JSONCodable {
    
    public typealias DecodableType = UIColor
    
    open var jsonObject: [String: Any] {
        var map = [String: Any]()
        map[NSAttributedStringKey.foregroundColor] = rgbaValue
        return map
    }
    
    open class func decode(from object: Any?) -> DecodableType? {
        if let object = object as? DecodableType { return object }
        if let hex = object as? UInt {
            return UIColor(hex)
        } else if let dict = object as? [String: Any],
            let hex = dict[NSAttributedStringKey.foregroundColor] as? UInt {
            return UIColor(hex, alpha: dict[NSAttributedStringKey.alpha] as? CGFloat)
        }
        return nil
    }
    
}

extension UIFont: JSONCodable {
    
    public typealias DecodableType = UIFont
    
    open var jsonObject: [String: Any] {
        var map = [String: Any]()
        map[NSAttributedStringKey.font] = fontName
        map[NSAttributedStringKey.pointSize] = pointSize
        return map
    }
    
    open class func decode(from object: Any?) -> DecodableType? {
        if let object = object as? DecodableType { return object }
        if let fontName = object as? String {
            return UIFont(name: fontName, size: UIFont.systemFontSize)
        } else if
            let dict = object as? [String: Any],
            let fontName = dict[NSAttributedStringKey.font] as? String,
            let pointSize = dict[NSAttributedStringKey.pointSize] as? CGFloat {
            return UIFont(name: fontName, size: pointSize)
        }
        return nil
    }
    
}

extension Dictionary where Key == NSAttributedStringKey, Value == Any {
    
    public var attachment: NSTextAttachment? {
        get { return NSTextAttachment.decode(from: self[.attachment]) }
        set { self[.attachment] = newValue }
    }
    
    public var backgroundColor: UIColor? {
        get { return UIColor.decode(from: self[.backgroundColor]) }
        set { self[.backgroundColor] = newValue }
    }
    
    public var baselineOffset: Any? {
        get { return nil }
        set { self[.baselineOffset] = newValue }
    }
    
    public var expansion: Double {
        get { return self[.expansion] as? Double ?? 0 }
        set { self[.expansion] = newValue }
    }
    
    public var font: UIFont? {
        get { return UIFont.decode(from: self[.font])  }
        set { self[.font] = newValue }
    }
    
    public var foregroundColor: UIColor? {
        get { return UIColor.decode(from: self[.foregroundColor]) }
        set { self[.foregroundColor] = newValue }
    }
    
    public var iconAlpha: CGFloat {
        get { return self[.iconAlpha] as? CGFloat ?? 1.0 }
        set { self[.iconAlpha] = newValue }
    }
    
    public var iconShadow: NSShadow? {
        get { return NSShadow.decode(from: self[.iconShadow]) }
        set { self[.iconShadow] = newValue }
    }
    
    public var iconTintColor: UIColor? {
        get { return UIColor.decode(from: self[.iconTintColor]) }
        set { self[.iconTintColor] = newValue }
    }
    
    public var kern: Double {
        get { return self[.kern] as? Double ?? 0.0 }
        set { self[.kern] = newValue }
    }
    
    public var ligature: Int {
        get { return self[.ligature] as? Int ?? 1 }
        set { self[.ligature] = newValue }
    }
    
    public var link: URL? {
        get { return self[.link] as? URL }
        set { self[.link] = newValue }
    }
    
    public var lineBreakMode: NSLineBreakMode? {
        get { return paragraphStyle?.lineBreakMode }
        set {
            let style = paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle
            style?.lineBreakMode ?= newValue
            paragraphStyle = style
        }
    }
    
    public var obliqueness: Double? {
        get { return self[.obliqueness] as? Double }
        set { self[.obliqueness] = newValue }
    }
    
    public var paragraphStyle: NSParagraphStyle? {
        get { return NSParagraphStyle.decode(from: self[.paragraphStyle]) }
        set { self[.paragraphStyle] = newValue }
    }
    
    public var shadow: NSShadow? {
        get { return NSShadow.decode(from: self[.shadow]) }
        set { self[.shadow] = newValue }
    }
    
    public var strikethroughColor: UIColor? {
        get { return UIColor.decode(from: self[.strikethroughColor]) }
        set { self[.strikethroughColor] = newValue }
    }
    
    public var strikethroughStyle: NSUnderlineStyle {
        get { return NSUnderlineStyle(rawValue: self[.strikethroughStyle] as? Int ?? 0) ?? .styleNone }
        set { self[.strikethroughStyle] = newValue }
    }
    
    public var strokeColor: UIColor? {
        get { return UIColor.decode(from: self[.strokeColor]) }
        set { self[.strokeColor] = newValue }
    }
    
    public var strokeWidth: Double {
        get { return self[.strokeWidth] as? Double ?? 0.0 }
        set { self[.strokeWidth] = newValue }
    }
    
    public var textAlignment: NSTextAlignment? {
        get { return paragraphStyle?.alignment }
        set {
            let style = paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle
            style?.alignment ?= newValue
            paragraphStyle = style
        }
    }
    
    public var textColor: UIColor? {
        get { return foregroundColor }
        set { foregroundColor = newValue }
    }
    
    public var textEffect: String? {
        get { return self[.textEffect] as? String }
        set { self[.textEffect] = newValue }
    }
    
    public var underlineColor: UIColor? {
        get { return UIColor.decode(from: self[.underlineColor]) }
        set { self[.underlineColor] = newValue }
    }
    
    public var underlineStyle: NSUnderlineStyle {
        get { return NSUnderlineStyle(rawValue: self[.underlineStyle] as? Int ?? 0) ?? .styleNone }
        set { self[.underlineStyle] = newValue }
    }
    
    public var verticalGlyphForm: Int {
        get { return self[.verticalGlyphForm] as? Int ?? 0 }
        set { self[.verticalGlyphForm] = newValue }
    }
    
    public var writingDirection: [Int] {
        get { return self[.writingDirection] as? [Int] ?? [] }
        set { self[.writingDirection] = newValue }
    }
    
    public var jsonObject: [Key: Value] {
        return mapValues { ($0 as? JSONEncodable)?.jsonObject ?? $0 }
    }
    
    public mutating func decode() {
        forEach {
            switch $0.key {
                
            case .attachment:
                self[$0.key] = NSTextAttachment.decode(from: $0.value)
                break
                
            case .backgroundColor, .foregroundColor,
                 .iconTintColor, .strokeColor, .strikethroughColor,
                 .tintColor, .underlineColor:
                self[$0.key] = UIColor.decode(from: $0.value)
                break
                
            case .font:
                self[$0.key] = UIFont.decode(from: $0.value)
                break
                
            case .paragraphStyle:
                self[$0.key] = NSParagraphStyle.decode(from: $0.value)
                break
                
            case .shadow:
                self[$0.key] = NSShadow.decode(from: $0.value)
                break
                
            default:
                break
                
            }
        }
    }
    
    public func decoded() -> TextStyle {
        var textStyle = self
        textStyle.decode()
        return textStyle
    }
    
}

open class TextStyleError: Error {
    
    public init() {
        
    }
    
}

open class TextStyleInitializationError: TextStyleError {
    
    override public init() {
        super.init()
    }
    
}
