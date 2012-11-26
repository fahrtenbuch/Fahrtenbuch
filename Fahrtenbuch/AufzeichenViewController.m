//
//  AufzeichenViewController.m
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AufzeichenViewController.h"

@implementation AufzeichenViewController
@synthesize pck_water;
@synthesize txt_water;
@synthesize lbl_city;
@synthesize lbl_distance;
@synthesize lbl_speed;
@synthesize lbl_startTime;
@synthesize lbl_endTime;


#pragma mark - viewDidLoad on RecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM HH:mm"];
    
    locationManagerCityName = [[CLLocationManager alloc] init];
    locationManagerCityName.delegate = self; //fixme: we should move the delegator to a sepperate class
    locationManagerCityName.distanceFilter = kCLDistanceFilterNone;
    locationManagerCityName.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManagerCityName startUpdatingLocation];
    
}


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
                
                //FIXME: shoulden't be done during location update, because it's just the start location. Maybe we can move this out of these method.
                if( [[lbl_city text] length] <= 0) {

                    lbl_city.text = [placemark locality];
                    
                } if ([[lbl_city text] length] > 0) {

                    NSString *urlString = [NSString stringWithFormat:@"http://paddelsuechtige.de/REST/?location=%@",[lbl_city text]];
                    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSURL *url = [NSURL  URLWithString:urlString];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    NSError *error;
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    water = [json valueForKey: @"was"];

                    [pck_water reloadAllComponents];
                    [txt_water setText:[water objectAtIndex:0]];
                }
                
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
    locationManagerRoute.delegate = self; //fixme: we should move the delegator to a sepperate class
    
    //soll in App einstellbar sein
    locationManagerRoute.distanceFilter = kCLDistanceFilterNone;
    
    locationManagerRoute.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManagerRoute startUpdatingLocation];
    
    //disable all unnecessary elements on the view after start button was pressed
    [pck_water setHidden:TRUE];
    
}


#pragma mark - Necessary Picker View methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return [water count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [water objectAtIndex:row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
        NSString *selection = [water objectAtIndex:row];
        [txt_water setText:selection]; //set water textfield value
}


- (IBAction)btn_stop:(id)sender {
    
    [locationManagerRoute stopUpdatingLocation];
    lbl_endTime.text = [dateFormatter stringFromDate:[NSDate date]];
    
    //enable all necessary view elements after stop button was pressed
    [pck_water setHidden:FALSE];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    
    //this method removes the keyboard from textfield
    [sender resignFirstResponder];
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
    [self setPck_water:nil];
    [self setTxt_water:nil];
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
