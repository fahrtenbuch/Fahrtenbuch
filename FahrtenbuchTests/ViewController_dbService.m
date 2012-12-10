//
//  ViewController.m
//  jsonProject
//
//  Created by juju on 06.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]
//#define kLatestKivaLoansURL [NSURL URLWithString:@"http://paddelsuechtige.de/REST/index.php"]

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = [NSString stringWithFormat:@"http://paddelsuechtige.de/REST/?location=Weine"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray* location = [json valueForKey: @"wo"]; //2
    NSLog(@"%@", location);
    
    //load values ansynchron into background queue
    dispatch_async(kBgQueue, //queue is defined as macro
                   ^{
                       NSData* data = [NSData dataWithContentsOfURL: kLatestKivaLoansURL];
                       [self performSelectorOnMainThread:@selector(fetchedData:) 
                                              withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions 
                          error:&error];
    
    NSArray* location = [json valueForKey:@"wo"]; //2
    
    NSLog(@"location: %@", location); //3
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)openMail:(id)sender {
}
@end
