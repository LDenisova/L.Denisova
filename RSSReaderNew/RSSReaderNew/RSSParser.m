//
//  RSSParser.m
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSParser.h"

#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation RSSParser

@synthesize delegate;

- (void) parseRSS:(NSData *)data
{
    arrItem=[[NSMutableArray alloc] init];
    xmlParser=[[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

-(void) parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"PARSING IS STARTED");
}

-(void) parser:(NSXMLParser *) parser parseErrorOccurred:(NSError *)parseError
{
    NSString *errorString=[NSString stringWithFormat:@"Unable to download. Error code is %@",parseError];
    NSLog(@"error: %@",errorString);
    /*
    if ([parseError code]==65)
    {
        UIAlertView * alert=[[UIAlertView alloc]
                            initWithTitle:@"Ошибка"
                            message:@"Невозможно загрузить файл" delegate:self
                            cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [delegate RSSDidRead:arrItem];
    }*/
}

-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    NSLog(@"Validation Error %@",[validationError description]);
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    curElement=[elementName copy];
    if ([elementName isEqualToString:@"item"])
    {
        item=[[NSMutableDictionary alloc] init];
        curTitle=[[NSMutableString alloc] init];
        curLink=[[NSMutableString alloc] init];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [item setObject:curTitle forKey:@"title"];
        [item setObject:[curLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"link"];
        [arrItem addObject:item];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([curElement isEqualToString:@"title"])
    {
        [curTitle appendString:string];
    }
    else if ([curElement isEqualToString:@"link"])
    {
        [curLink appendString:string];
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [delegate RSSDidRead:arrItem];
}

-(void) dealloc
{
    [super dealloc];
    [xmlParser release];
    [arrItem release];
}

@end