//
//  ViewController.h
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)openMail:(id)sender;


@end
