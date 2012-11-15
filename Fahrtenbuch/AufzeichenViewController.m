//
//  AufzeichenViewController.m
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AufzeichenViewController.h"

@implementation AufzeichenViewController
@synthesize lbl_city;
@synthesize lbl_distance;
@synthesize lbl_speed;
@synthesize lbl_startTime;
@synthesize lbl_endTime;


#pragma mark - viewDidLoad on RecordViewController

/*- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM HH:mm"];
    
    locationManagerCityName = [[CLLocationManager alloc] init];
    locationManagerCityName.delegate = self;
    locationManagerCityName.distanceFilter = kCLDistanceFilterNone;
    locationManagerCityName.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManagerCityName startUpdatingLocation];
    
}*/


#pragma mark - locationManager record methods

//methode to handle current location
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if (manager==locationManagerCityName) {
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            for (CLPlacemark *placemark in placemarks) {
                
                //concatination of adress
                /*NSString *address = [NSString stringWithFormat:@"%@ %@, %@ %@",
                 [placemark subThoroughfare], [placemark thoroughfare], [placemark locality], [placemark administrativeArea]];
                 */
                //labelCity.text = address;
                lbl_city.text = [placemark locality];
                [locationManagerCityName stopUpdatingLocation];
            }
        }];
    }
    
    else if (manager==locationManagerRoute) {
        
        //calculate average route
        distance  += [newLocation distanceFromLocation:oldLocation];
        
        lbl_distance.text = [[NSString alloc] initWithFormat:@"%i", (int)distance];
        
        //calculate avarage speed
        lbl_speed.text = [[NSString alloc] initWithFormat:@"%i", (int)(distance/([start timeIntervalSinceNow]*-1)*3.6)];
    }
}

#pragma mark - Button methods to handle location record

//methods to start and stop watching
- (IBAction)btn_start:(id)sender {
    
    start = [NSDate date];
    
    lbl_startTime.text = [dateFormatter stringFromDate:start];
    lbl_endTime.text = @"00.00 00:00";
    
    distance = 0;
    locationManagerRoute = [[CLLocationManager alloc] init];
    locationManagerRoute.delegate = self;
    
    //soll in App einstellbar sein
    locationManagerRoute.distanceFilter = kCLDistanceFilterNone;
    
    locationManagerRoute.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManagerRoute startUpdatingLocation];
    
}

- (IBAction)btn_stop:(id)sender {
    
    [locationManagerRoute stopUpdatingLocation];
    lbl_endTime.text = [dateFormatter stringFromDate:[NSDate date]];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setLbl_city:nil];
    [self setLbl_distance:nil];
    [self setLbl_speed:nil];
    [self setLbl_startTime:nil];
    [self setLbl_endTime:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
