//
//  RSSLoaderAndParser.h
//  RSSReaderNew
//
//  Created by Людмила on 13.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPDownloader.h"
#import "RSSParser.h"

@interface RSSLoaderAndParser : NSObject <HTTPDownloaderDelegate,RSSParserDelegate>
{
    id delegate;
}

@property (nonatomic,retain) id delegate;

- (void) parseRSSFromFile:(NSString *)fName;
- (void) parseRSSFromURL:(NSString *)urlStr;

@end

@protocol RSSLoaderAndParserDelegate 

- (void) RSSDidLoadAndRead:(NSArray *)arrItem;

@end
