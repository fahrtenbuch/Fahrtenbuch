//
//  ViewController.m
//  GetCityName
//
//  Created by Aaron Heckel on 01.11.12.
//  Copyright (c) 2012 Aaron Heckel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if (manager==locationManagerCityName) {
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            for (CLPlacemark *placemark in placemarks) {
                
                //Zusammensetzen der Adresse
                /*NSString *address = [NSString stringWithFormat:@"%@ %@, %@ %@",
                                     [placemark subThoroughfare], [placemark thoroughfare], [placemark locality], [placemark administrativeArea]];
                */
                //labelCity.text = address;
                labelCity.text = [placemark locality];
                [locationManagerCityName stopUpdatingLocation];
            }
        }];
    }
    
    else if (manager==locationManagerRoute) {
    
        //Gesamtstrecke berechnen
        distance  += [newLocation distanceFromLocation:oldLocation];
    
        labelDistance.text = [[NSString alloc] initWithFormat:@"%i", (int)distance];
    
        //Geschwindigkeit berechnen
        labelSpeed.text = [[NSString alloc] initWithFormat:@"%i", (int)(distance/([start timeIntervalSinceNow]*-1)*3.6)];
    }

}

-(IBAction)startPressed {
    start = [NSDate date];
    
    labelStartTime.text = [dateFormatter stringFromDate:start];
    labelStopTime.text = @"00.00 00:00";
    
    distance = 0;
    locationManagerRoute = [[CLLocationManager alloc] init];
    locationManagerRoute.delegate = self;
    
    //soll in App einstellbar sein
    locationManagerRoute.distanceFilter = kCLDistanceFilterNone;
    
    locationManagerRoute.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManagerRoute startUpdatingLocation];
}

-(IBAction)stopPressed {
    [locationManagerRoute stopUpdatingLocation];
    labelStopTime.text = [dateFormatter stringFromDate:[NSDate date]];
}

@end
