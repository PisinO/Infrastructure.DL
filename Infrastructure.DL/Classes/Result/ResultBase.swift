//
//  ResultBase.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 07/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public struct ResultBase {
    public var success: Bool {
        return self.error == nil
    }
    
    public let error: Error?
    
    public init(_ error: Error?) {
        self.error = error
    }
}

extension ResultBase {
    static public func success() -> ResultBase {
        return ResultBase(nil)
    }
    
    static public func failure(_ error: Error) -> ResultBase {
        return ResultBase(error)
    }
}
