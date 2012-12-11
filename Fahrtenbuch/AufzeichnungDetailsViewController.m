//
//  AufzeichnungDetailsViewController.m
//  Fahrtenbuch
//
//  Created by Yasin Makin on 10.12.12.
//
//

#import "AufzeichnungDetailsViewController.h"
#import "Aufzeichnung.h"

@interface AufzeichnungDetailsViewController ()

@end

@implementation AufzeichnungDetailsViewController
@synthesize aufzeichnung;
@synthesize startTime;
@synthesize stopTime;
@synthesize location;
@synthesize water;
@synthesize averageDistance;
@synthesize averageSpeed;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    startTime.text = aufzeichnung.startTime;
    stopTime.text = aufzeichnung.stopTime;
    location.text = aufzeichnung.location;
    water.text = aufzeichnung.water;
    
    
    averageSpeed.text = [NSString stringWithFormat:@"%@", aufzeichnung.averageSpeed];
    averageDistance.text = [NSString stringWithFormat:@"%@", aufzeichnung.averageDistance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setStartTime:nil];
    [self setStopTime:nil];
    [self setLocation:nil];
    [self setWater:nil];
    [self setAverageSpeed:nil];
    [self setAverageDistance:nil];
    self.aufzeichnung = nil;
    [super viewDidUnload];
}
@end
