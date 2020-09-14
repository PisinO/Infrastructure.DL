//
//  FetchParameters.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public struct FetchParameters {
    public var predicate: NSPredicate?
    public var sortDescriptors: [NSSortDescriptor]?
    public var limit: Int?
    public var offset: Int?
    
    public init(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, limit: Int?, offset: Int?) {
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
        self.limit = limit
        self.offset = offset
    }
    
    public static func empty() -> FetchParameters {
        return FetchParameters(predicate: nil, sortDescriptors: nil, limit: nil, offset: nil)
    }
}
