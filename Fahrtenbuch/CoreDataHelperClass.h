//
//  CoreDataHelperClass.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 12.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelperClass : NSObject

+ (NSString*) directoryForDatabaseFileName;
+ (NSString*) databaseFileName;

+ (NSManagedObjectContext*) managedObjectContext;

+ (id) insertManagedObjectOfClass : (Class) aClass inManagedObjectContext: (NSManagedObjectContext*)managedObjectContext;

+ (BOOL) saveManagedObjectContext : (NSManagedObjectContext*) managedObjectContext;

+ (NSArray*) fetchEntitiesForClass: (Class) aClass withPredicates: (NSPredicate*) predicate inManagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

+ (BOOL) peformFetchOnFetchedResultsController: (NSFetchedResultsController *) fetchedResultscontroller;
@end
