//
//  Aufzeichnung.h
//  Fahrtenbuch
//
//  Created by Yasin Makin on 09.12.12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Aufzeichnung : NSManagedObject

@property (nonatomic, retain) NSString * startTime;
@property (nonatomic, retain) NSString * stopTime;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * averageSpeed;
@property (nonatomic, retain) NSNumber * averageDistance;
@property (nonatomic, retain) NSString * water;

@end
