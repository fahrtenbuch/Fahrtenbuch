//
//  EinstellungenViewController.m
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EinstellungenViewController.h"
#import "CoreDataHelperClass.h"
#import "Einstellungen.h"

@implementation EinstellungenViewController
@synthesize nameTextField;
@synthesize intervallTextField;
@synthesize vereinsnameTextField;
@synthesize context;


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    context = [CoreDataHelperClass managedObjectContext];
    
    //---Update
    /*
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Einstellungen" inManagedObjectContext:context];
    request.entity = entity;
    request.predicate = nil;
    
    NSError *error;
    Einstellungen *ein = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
    ein.name = @"Youssef";
    ein.vereinsname = @"Schwimmen";
    
    NSNumber *intervallnummer = [NSNumber numberWithInt:1];
    
    ein.intervall = intervallnummer;
    //---/Update
    */
    
    
    //---Delete
    /*
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Einstellungen" inManagedObjectContext:context];
     request.entity = entity;
     request.predicate = nil;
     
     NSError *error;
    
     Einstellungen *ein = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
     
    [context deleteObject:ein];
    */
    //---/Delete
     
    
    
    /*
    //-----Insert 
    Einstellungen *einstellungen_insert = [CoreDataHelperClass insertManagedObjectOfClass:[Einstellungen class] inManagedObjectContext:context];
    einstellungen_insert.name = @"Test1";
    einstellungen_insert.vereinsname = @"TestVerein1";
    
    NSNumber *n = [[NSNumber alloc] initWithInt:3];
    einstellungen_insert.intervall = n;
    //---/insert
    */
    
    //[CoreDataHelperClass saveManagedObjectContext:context];
    
    
    NSArray *items = [CoreDataHelperClass fetchEntitiesForClass:[Einstellungen class] withPredicates:nil inManagedObjectContext:context];
    
    NSLog(@"Inhalt vom Array: %@", items);
    
    if([items count] == 0)
    {
        
        intervallTextField.text = [NSString stringWithFormat:@"1"];
        
    }
    else
    {
        
        for(Einstellungen *e in items)
        {
            NSLog(@"Name: %@", e.name);
            NSLog(@"VereinsName: %@", e.vereinsname);
            NSLog(@"Intervall: %@", e.intervall);
                        
            nameTextField.text = e.name;
            vereinsnameTextField.text = e.vereinsname;
            intervallTextField.text = [NSString stringWithFormat:@"%@", e.intervall];
        }
        
    }
    
}




- (void)viewDidUnload
{
    [self setNameTextField:nil];
    
    [self setIntervallTextField:nil];
    [self setVereinsnameTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)SaveUser:(id)sender {
   NSArray *items = [CoreDataHelperClass fetchEntitiesForClass:[Einstellungen class] withPredicates:nil inManagedObjectContext:context];
    
    if([items count] != 0)
    {
        NSLog(@"Es ist nicht leer");
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Einstellungen" inManagedObjectContext:context];
        request.entity = entity;
        request.predicate = nil;
        
        NSError *error;
        Einstellungen *ein = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
        ein.name = nameTextField.text;
        ein.vereinsname = vereinsnameTextField.text;
        ein.intervall = [[NSNumber alloc ] initWithInt:[intervallTextField.text intValue]];
    }
    else
    {
        NSLog(@"Es ist leer");
        Einstellungen *einstellungen_insert = [CoreDataHelperClass insertManagedObjectOfClass:[Einstellungen class] inManagedObjectContext:context];
        einstellungen_insert.name = nameTextField.text;
        einstellungen_insert.vereinsname = vereinsnameTextField.text;
        einstellungen_insert.intervall = [[NSNumber alloc] initWithInt:[intervallTextField.text intValue]];
    }
    
    [CoreDataHelperClass saveManagedObjectContext:context];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)buttonPressed:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.vereinsnameTextField resignFirstResponder];
    [self.intervallTextField resignFirstResponder];
}
@end
