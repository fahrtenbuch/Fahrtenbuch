//
//  AufzeichenViewController.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AufzeichenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
@property (weak, nonatomic) IBOutlet UILabel *lbl_distance;
@property (weak, nonatomic) IBOutlet UILabel *lbl_speed;
@property (weak, nonatomic) IBOutlet UILabel *lbl_startTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_endTime;

- (IBAction)btn_start:(id)sender;
- (IBAction)btn_stop:(id)sender;

@end


CLLocationManager *locationManagerRoute;
CLLocationManager *locationManagerCityName;

NSDateFormatter *dateFormatter;
NSDate *start;

double distance;
