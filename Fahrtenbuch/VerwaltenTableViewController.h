//
//  VerwaltenTableViewController.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Aufzeichnung;

@interface VerwaltenTableViewController : UITableViewController
<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic,strong) Aufzeichnung *aufzeichnung;
@end
