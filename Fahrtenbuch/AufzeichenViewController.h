//
//  AufzeichenViewController.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"

@interface AufzeichenViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pck_water;
@property (weak, nonatomic) IBOutlet UILabel *lbl_water;
@property (weak, nonatomic) IBOutlet UITextField *txt_water;

@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
@property (weak, nonatomic) IBOutlet UILabel *lbl_distance;
@property (weak, nonatomic) IBOutlet UILabel *lbl_speed;
@property (weak, nonatomic) IBOutlet UILabel *lbl_startTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_endTime;

@property (strong, nonatomic) NSManagedObjectContext *context;

- (IBAction)btn_start:(id)sender;
- (IBAction)btn_stop:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
-(void) myTask;

@end

NSArray *water;

CLLocationManager *locationManagerRoute;
CLLocationManager *locationManagerCityName;

NSDateFormatter *dateFormatter;
NSDate *start;
NSDate *stop;

NSString *selection;
NSString *location;

double distance,speed;

