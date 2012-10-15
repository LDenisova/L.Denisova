//
//  RSSParser.h
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPDownloader.h"

@interface RSSParser : NSObject <NSXMLParserDelegate>
{
    id delegate;
    NSMutableArray *arrItem;
    NSXMLParser *xmlParser;
    NSMutableDictionary *item;
    NSMutableString *curTitle, *curLink;
    NSString *curElement;
}

@property (nonatomic,retain) id delegate;

- (void) parseRSS:(NSData *)data;

@end

@protocol RSSParserDelegate 

- (void) RSSDidRead:(NSArray *)arrItem;

@end

