//
//  Product+CoreDataProperties.swift
//  P2PGuard
//
//  Created by frank on 16/1/10.
//  Copyright © 2016年 frank. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Product {

    @NSManaged var companyName: String?
    @NSManaged var id: NSNumber?
    @NSManaged var productName: String?
    @NSManaged var updateTime: NSDate?
    @NSManaged var isGuard: NSNumber?

}
