//
//  Einstellungen.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 12.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Einstellungen : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * vereinsname;
@property (nonatomic, retain) NSNumber * intervall;

@end
