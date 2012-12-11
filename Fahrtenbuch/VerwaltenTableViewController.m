//
//  VerwaltenTableViewController.m
//  Fahrtenbuch
//
//  Created by Baba Makin on 11.11.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VerwaltenTableViewController.h"
#import "CoreDataHelperClass.h"
#import "Aufzeichnung.h"
#import "AufzeichnungDetailsViewController.h"

@interface VerwaltenTableViewController() <UISearchBarDelegate>
@property (nonatomic, strong) UIBarButtonItem *barButtonItemDone;
@property (nonatomic, strong) UIBarButtonItem *barButtonItemCancel;
@property (nonatomic, strong) UIBarButtonItem *barButtonItemSearch;
@property (nonatomic, strong) UIBarButtonItem *barButtonItemEdit;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSPredicate *basePredicate;
@property (nonatomic, strong) NSPredicate *fetchPredicate;

@end


@implementation VerwaltenTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize context;

@synthesize barButtonItemCancel;
@synthesize barButtonItemDone;
@synthesize barButtonItemSearch;
@synthesize barButtonItemEdit;

@synthesize basePredicate;
@synthesize fetchPredicate;

@synthesize searchBar;

@synthesize aufzeichnung;
/*
-(NSFetchedResultsController *) getFetchedResultsController
{
    if(self.fetchedResultsController != nil)
    {
        return self.fetchedResultsController;
    }
    
    context = [CoreDataHelperClass managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Aufzeichnung" inManagedObjectContext:context];
    request.entity = entity;
    request.fetchBatchSize = 64;
    request.predicate = fetchPredicate;
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
    
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    request.sortDescriptors = sortArray;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    return self.fetchedResultsController;
}
*/

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //-------FetchedResultsController----------//
    
    context = [CoreDataHelperClass managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Aufzeichnung" inManagedObjectContext:context];
    request.entity = entity;
    request.fetchBatchSize = 64;
    request.predicate = fetchPredicate;
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
    
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    request.sortDescriptors = sortArray;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController.delegate = self;
    
    [CoreDataHelperClass peformFetchOnFetchedResultsController:self.fetchedResultsController];
    
    barButtonItemEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(barButtonItemEditPressed:)];
    
    barButtonItemSearch = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(barButtonItemSearchPressed:)];
    
    barButtonItemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(barButtonItemCancelPressed:)];
    
    barButtonItemDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(barButtonItemDonePressed:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barButtonItemEdit, barButtonItemSearch, nil];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    //self.searchBar.barStyle =
    self.searchBar.showsCancelButton = NO;
    
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    barButtonItemCancel = nil;
    barButtonItemDone = nil;
    barButtonItemSearch = nil;
    barButtonItemEdit = nil;
    searchBar = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
	//cell.textLabel.text = [array objectAtIndex:indexPath.row];
    Aufzeichnung *auf = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = auf.location;
    NSString *detailText = [NSString stringWithFormat:@"%@ - %@",auf.startTime,auf.stopTime];
    cell.detailTextLabel.text = detailText;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return self.tableView.isEditing;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
    }   
     
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void) barButtonItemEditPressed: (id) sender
{
    [self.navigationController setToolbarHidden:NO animated:YES];
    [self.tableView setEditing:YES animated:YES];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:barButtonItemDone,barButtonItemSearch,nil] animated:YES];
    [self.navigationItem setLeftBarButtonItem:barButtonItemCancel animated:YES];
    self.navigationItem.hidesBackButton = YES;
}

-(void) barButtonItemDonePressed: (id) sender
{
    [CoreDataHelperClass saveManagedObjectContext:context];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.tableView setEditing:NO animated:YES];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:barButtonItemEdit,barButtonItemSearch,nil] animated:YES];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.navigationItem.hidesBackButton = NO;
}

-(void) barButtonItemCancelPressed: (id) sender
{
    [context rollback];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.tableView setEditing:NO animated:YES];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:barButtonItemEdit,barButtonItemSearch,nil] animated:YES];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
    self.navigationItem.hidesBackButton = NO;
}

-(void) barButtonItemSearchPressed: (id) sender
{
    if(self.tableView.tableHeaderView == nil) //Die SearchBar ist noch nicht da.
    {
        [self.searchBar sizeToFit];
        self.tableView.tableHeaderView = self.searchBar;
        [self.tableView setContentOffset:CGPointMake(0, self.searchBar.frame.size.height) animated:NO];
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    else
    {
        self.searchBar.text = nil;
        [self searchBar:self.searchBar textDidChange:nil];
        if(self.tableView.contentOffset.y <= self.tableView.tableHeaderView.frame.size.height)
        {
            [self.tableView setContentOffset:CGPointMake(0, self.searchBar.frame.size.height) animated:YES];
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                           {
                               self.tableView.tableHeaderView = nil;
                               [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
                           });
        }
        else
        {
            CGFloat yOffSet = self.tableView.contentOffset.y - self.tableView.tableHeaderView.frame.size.height;
            self.tableView.tableHeaderView = nil;
            [self.tableView setContentOffset:CGPointMake(0, yOffSet) animated:NO];
        }
        
        
    }
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length > 0)
    {
        self.barButtonItemSearch.tintColor = [UIColor orangeColor];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"location contains[c] %@ OR startTime contains[c] %@",searchText, searchText];
        self.fetchPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObject:filterPredicate]];
    }
    else
    {
        self.barButtonItemSearch.tintColor = nil;
        self.fetchPredicate = nil;
    }
    
    
    self.fetchedResultsController = nil;
    
    context = [CoreDataHelperClass managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Aufzeichnung" inManagedObjectContext:context];
    request.entity = entity;
    request.fetchBatchSize = 64;
    request.predicate = fetchPredicate;
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
    
    NSArray *sortArray = [NSArray arrayWithObject:sort];
    request.sortDescriptors = sortArray;
    
    NSFetchedResultsController *ThefetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = ThefetchedResultsController;
    
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    
    [self.tableView reloadData];
    
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.searchBar.isFirstResponder)
    {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - NSFRC Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showAufzeichnung"])
    {
        AufzeichnungDetailsViewController *controller = segue.destinationViewController;
        controller.aufzeichnung = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    }
}


@end
