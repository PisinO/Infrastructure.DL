//
//  ContextInitializer.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public protocol ContextInitializer {
    var datamodelName: String { get }
    var datamodelBundle: Bundle { get }
    var onFinishedLoading: ((Error?) -> ())? { get }
}
