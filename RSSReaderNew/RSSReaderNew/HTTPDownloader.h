//
//  HTTPDownloader.h
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPDownloader : NSObject {
    id delegate;
    NSMutableData *dowloadData;
}

@property (nonatomic,retain) id delegate;

-(void)loadFromURL:(NSString *)urlString;

@end

@protocol HTTPDownloaderDelegate

- (void) HTTPDidLoad:(NSData *)data;

@end

