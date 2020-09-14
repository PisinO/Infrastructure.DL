//
//  EntityResult.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 07/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public struct EntityResult<TEntity> {
    public var success: Bool {
        return result != nil && error == nil
    }
    
    public let result: TEntity?
    public let error: Error?
    
    public init(_ result: TEntity?, _ error: Error?) {
        self.result = result
        self.error = error
    }
}

extension EntityResult {
    static public func success(_ result: TEntity) -> EntityResult<TEntity> {
        return EntityResult<TEntity>(result, nil)
    }
    
    static public func failure(_ error: Error) -> EntityResult<TEntity> {
        return EntityResult<TEntity>(nil, error)
    }
}
