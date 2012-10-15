//
//  RSSLoaderAndParser.m
//  RSSReaderNew
//
//  Created by Людмила on 13.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSLoaderAndParser.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation RSSLoaderAndParser

@synthesize delegate;

- (void) startRSSParser:(NSData *) data
{
    RSSParser * rssParser=[[[RSSParser alloc] init] autorelease];
    [rssParser setDelegate:self];
    [rssParser parseRSS:data];
}

- (void) parseRSSFromFile:(NSString *)fName
{
    NSString *pathFileName = [DOCUMENTS stringByAppendingPathComponent:fName];
    NSData *data=[NSData dataWithContentsOfFile:pathFileName];
    [self startRSSParser:data];
}

- (void) parseRSSFromURL:(NSString *)urlStr
{
    HTTPDownloader *httpDownloader=[[HTTPDownloader alloc] init];
    [httpDownloader setDelegate:self];
    [httpDownloader loadFromURL:urlStr];
    [httpDownloader release];
}

- (void) HTTPDidLoad:(NSData *)data
{
    //arrItem=[[NSMutableArray alloc] init];
    [self startRSSParser:data];
}

- (void) RSSDidRead:(NSArray *)arrItem
{
    [delegate RSSDidLoadAndRead:arrItem];
}

@end
