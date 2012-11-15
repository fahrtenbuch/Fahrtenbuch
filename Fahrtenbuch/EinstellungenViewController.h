//
//  EinstellungenViewController.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface EinstellungenViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UITextField *intervallTextField;
@property (strong, nonatomic) IBOutlet UITextField *vereinsnameTextField;

@property (strong, nonatomic) NSManagedObjectContext *context;

- (IBAction)SaveUser:(id)sender;
- (IBAction)buttonPressed:(id)sender;

@end
