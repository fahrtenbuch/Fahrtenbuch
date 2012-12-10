//
//  CoreDataHelperClass.m
//  Fahrtenbuch
//
//  Created by Baba Makin on 12.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataHelperClass.h"

@implementation CoreDataHelperClass

+ (NSString*) directoryForDatabaseFileName
{
    return [NSHomeDirectory() stringByAppendingString:@"/Library/Private Documents"];
}
+ (NSString*) databaseFileName
{
    return @"database.sqlite";
}

+ (NSManagedObjectContext*) managedObjectContext
{
    static NSManagedObjectContext *managedObjectContext;
    if(managedObjectContext != nil)
    {
        return managedObjectContext;
    }
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:[CoreDataHelperClass directoryForDatabaseFileName] withIntermediateDirectories:YES attributes:nil error:&error];
    if(error)
    {
        NSLog(@"Fehler %@", error.localizedDescription);
        return nil;
    }
     
     NSString *path = [NSString stringWithFormat:@"%@/%@", [CoreDataHelperClass directoryForDatabaseFileName], [CoreDataHelperClass databaseFileName]];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
    {
        NSLog(@"Fehler %@", error.localizedDescription);
        return nil;
    }
     
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    
    return managedObjectContext;
    
}

+ (id) insertManagedObjectOfClass : (Class) aClass inManagedObjectContext: (NSManagedObjectContext*)managedObjectContext
{
    NSManagedObjectContext *managedObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(aClass) inManagedObjectContext:managedObjectContext];
    
    return managedObject;
}

+ (BOOL) saveManagedObjectContext : (NSManagedObjectContext*) managedObjectContext
{
    NSError *error;
    if(![managedObjectContext save: &error])
    {
        NSLog(@"Fehler %@",error.localizedDescription);
        return NO;
    }
    
    return YES;
}

+ (NSArray*) fetchEntitiesForClass: (Class) aClass withPredicates: (NSPredicate*) predicate inManagedObjectContext: (NSManagedObjectContext*) managedObjectContext
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(aClass) inManagedObjectContext:managedObjectContext];
    
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;
    
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(error)
    {
        NSLog(@"Fehler %@", error.localizedDescription);
        return nil;
    }
    return items;
}

+ (BOOL) peformFetchOnFetchedResultsController: (NSFetchedResultsController *) fetchedResultsController
{
    NSError *error;
    if(! [fetchedResultsController performFetch:&error])
    {
        NSLog(@"Fehler: %@",error.localizedDescription);
        return NO;
    }

    return YES;

}



@end
