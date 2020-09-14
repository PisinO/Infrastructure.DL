//
//  PersistantContainer.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation
import CoreData

/// NSPersistentContainer has to be inherited in order to initialize xcdatamodeld from framework https://stackoverflow.com/a/51295347
class PersistentContainer: NSPersistentContainer { }
