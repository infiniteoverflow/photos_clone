//
//  DispatchClass.swift
//  photos_clone
//
//  Created by Aswin Gopinathan on 17/04/24.
//

import Foundation

class DispatchClass {
    private init() {
        // Empty Init
    }
    
    static let shared = DispatchClass()
    
    let dispatchGroup = DispatchGroup()
}
