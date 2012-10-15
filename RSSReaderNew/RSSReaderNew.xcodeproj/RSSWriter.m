//
//  RSSWriter.m
//  RSSReaderNew
//
//  Created by Людмила on 13.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSWriter.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation RSSWriter

- (NSString *) generateXMLStringForFeedItem:(NSDictionary *)item
{
    NSMutableString *str=[NSMutableString stringWithString:@""];
    [str appendFormat:@"<item>\n<title>%@</title>\n",[item objectForKey:@"title"]];
    [str appendFormat:@"<link>%@</link>\n",[item objectForKey:@"link"]];
    [str appendString:@"<description></description>\n"];
    [str appendString:@"<pubDate></pubDate>\n"];
    [str appendString:@"<content:encoded></content:encoded>\n"];
    [str appendString:@"</item>\n"];
    return str;
}

- (void) SaveArrFeeds:(NSArray *) arrFeeds ToFile:(NSString *)fName
{
    NSString *head=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"head"ofType:@"xml"] encoding:NSUTF8StringEncoding  error:NULL];
    NSString *foot=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foot"ofType:@"xml"] encoding:NSUTF8StringEncoding  error:NULL];
    NSMutableString *res=[NSMutableString stringWithString:head];
    for (NSDictionary * item in arrFeeds)
    {
        [res appendString:[self generateXMLStringForFeedItem:item]];
    }
    [res appendString:foot];
    NSLog(@"RESULT=%@",res);
    NSString *filePath = [DOCUMENTS stringByAppendingPathComponent:fName];
    NSLog(@"%@",filePath);
    [res writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


@end
