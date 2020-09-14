//
//  Entity.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation
import CoreData

public protocol Entity {
    associatedtype TKey: CVarArg

    var id: TKey { get }
}

public protocol DBEntity: NSManagedObject, Entity {
    
}
