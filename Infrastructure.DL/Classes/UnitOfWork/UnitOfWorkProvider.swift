//
//  UnitOfWorkProvider.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public protocol UnitOfWorkProvider {
    var main: UnitOfWork { get }
    var background: UnitOfWork { get }
}
