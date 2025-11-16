//
//  NameLoggable.swift
//  iOSModule
//
//  Created by Suraj kahar on 28/02/25.
//

import Foundation

protocol NameLoggable {
    
    var className: String { get }
    static var className : String { get }
    
}

extension NameLoggable {
    
    var className: String {
        String(describing: type(of: self))
    }
    
    static var className : String {
        String(describing: self)
    }
    
}

extension NSObject : NameLoggable { }
