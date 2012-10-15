//
//  FeedViewController.m
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedItemTableViewController.h"
#import "RSSWriter.h"

//#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation FeedViewController

- (void)viewDidLoad
{
    fileName=@"feed.xml";
    [super viewDidLoad];
    RSSLoaderAndParser * rssParser=[[[RSSLoaderAndParser alloc] init] autorelease];
    [rssParser setDelegate:self];
    [rssParser parseRSSFromFile:fileName];
    self.title=@"Ленты";
    UIBarButtonItem *btnAdd=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFeed)];
    self.navigationItem.rightBarButtonItem=btnAdd;
}

- (void) RSSDidLoadAndRead:(NSArray *)arrItem
{
    arrFeeds=[[NSMutableArray alloc] initWithArray:arrItem];
    [self.tableView reloadData];
}

- (void) addFeed
{
    ViewWithText * viewNewFeed=[[ViewWithText alloc] init];
    [viewNewFeed setDelegate:self];
    [self.navigationController pushViewController:viewNewFeed animated:YES];
    [viewNewFeed release];
}

- (void) FeedDidInput:(NSString *)feedName withLink:(NSString *)link
{
    NSDictionary *item=[[NSDictionary alloc] initWithObjectsAndKeys:feedName,@"title",link,@"link",nil];
    [arrFeeds addObject:item];
    [item release];
    //[self SaveFeedsToFile:fileName];
    RSSWriter * rssWriter=[[[RSSWriter alloc] init] autorelease];
    [rssWriter SaveArrFeeds:arrFeeds ToFile:fileName]; 
    [self.tableView reloadData];
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

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrFeeds count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    [[cell textLabel] setText:[[arrFeeds objectAtIndex:indexPath.row] objectForKey:@"title"]];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSString *link=[[arrFeeds objectAtIndex:indexPath.row] objectForKey:@"link"];
    FeedItemTableViewController *feedItemTableViewController=[[FeedItemTableViewController alloc] initWithRSSLink:link];
    [self.navigationController pushViewController:feedItemTableViewController animated:YES];
    [feedItemTableViewController release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
