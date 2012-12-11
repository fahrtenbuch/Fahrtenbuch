//
//  AufzeichnungDetailsViewController.h
//  Fahrtenbuch
//
//  Created by Yasin Makin on 10.12.12.
//
//

#import "ViewController.h"
@class Aufzeichnung;
@interface AufzeichnungDetailsViewController : ViewController

@property (nonatomic, strong) Aufzeichnung *aufzeichnung;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *stopTime;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *water;
@property (strong, nonatomic) IBOutlet UILabel *averageSpeed;
@property (strong, nonatomic) IBOutlet UILabel *averageDistance;

@end
