//
//  FetchParameters.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public struct FetchParameters {
    public let predicate: NSPredicate?
    public let sortDescriptors: [NSSortDescriptor]?
    public let limit: Int?
    public let offset: Int?
    
    public static func empty() -> FetchParameters {
        return FetchParameters(predicate: nil, sortDescriptors: nil, limit: nil, offset: nil)
    }
}
