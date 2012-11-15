//
//  ViewController.h
//  GetCityName
//
//  Created by Aaron Heckel on 01.11.12.
//  Copyright (c) 2012 Aaron Heckel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    
    CLLocationManager *locationManagerRoute;
    CLLocationManager *locationManagerCityName;
    IBOutlet UILabel *labelCity;
    IBOutlet UILabel *labelDistance;
    IBOutlet UILabel *labelSpeed;
    IBOutlet UILabel *labelStartTime;
    IBOutlet UILabel *labelStopTime;
    NSDateFormatter *dateFormatter;
    NSDate *start;
    double distance;
}
-(IBAction)startPressed;
-(IBAction)stopPressed;

@end
