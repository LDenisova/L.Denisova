//
//  WebViewController.m
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithLinkURL:(NSString *)linkURL
{
    self=[super init];
    link=[[NSString alloc ]initWithString:linkURL];
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [link release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    NSURL *url=[NSURL URLWithString:link];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    webView.scalesPageToFit=YES;
    self.view=webView;
    webView.delegate=self;
    [webView release];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.title=@"Читаем...";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title=@"";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
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
