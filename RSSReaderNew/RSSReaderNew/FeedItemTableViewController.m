//
//  FeedItemTableViewController.m
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedItemTableViewController.h"
#import "RSSLoaderAndParser.h"
#import "WebViewController.h"

@implementation FeedItemTableViewController
@synthesize arrItems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithRSSLink:(NSString *)rssLink
{
    self=[super init];
    rssUrlLink=[rssLink copy];
    self.title=@"Новости";
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    RSSLoaderAndParser *rssParser=[[RSSLoaderAndParser alloc] init];
    [rssParser setDelegate:self];
    NSLog(@"Будем парсить %@",rssUrlLink);
    [rssParser parseRSSFromURL:rssUrlLink];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void) RSSDidLoadAndRead:(NSArray *)arrItem
{
    self.arrItems=[[NSMutableArray alloc] initWithArray:arrItem];
    [self.tableView reloadData];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [[cell textLabel] setText:[[arrItems objectAtIndex:indexPath.row] objectForKey:@"title"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *link=[[arrItems objectAtIndex:indexPath.row] objectForKey:@"link"];
    WebViewController *webViewController=[[WebViewController alloc] initWithLinkURL:link];
    [self.navigationController pushViewController:webViewController animated:YES];
    [webViewController release];
}

@end
