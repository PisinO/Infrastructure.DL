//
//  FetchResult.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public struct FetchDatabaseResult<TEntity> {
    var success: Bool {
        return result != nil && error == nil
    }
    
    let result: TEntity?
    let error: Error?
    
    init(result: TEntity?, error: Error?) {
        self.result = result
        self.error = error
    }
    
    static func success(_ result: TEntity) -> FetchDatabaseResult<TEntity> {
        return FetchDatabaseResult(result: result, error: nil)
    }
    
    static func failure(_ error: Error) -> FetchDatabaseResult<TEntity> {
        return FetchDatabaseResult(result: nil, error: error)
    }
}
