//
//  REST.m
//  VufindAPI
//
//  Created by Doaa Anwar on 12-07-27.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import "REST.h"

#define BASE_URL	@"http://services.vufind.com/vugraph/v11"


@implementation REST

+ (NSString *) executeMethod:(NSString *)method 
					  onPath:(NSString *)path 
					withData:(NSString *)data 
				 contentType:(NSString *)contentType {
	
   
    NSString *urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSURL *url = [NSURL URLWithString:webStringURL];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:method];
    
	if (data) {
		void *bytes = (void*)[data UTF8String];
		[request setHTTPBody:[NSData dataWithBytesNoCopy:bytes length:strlen(bytes)]];
		
		if (contentType)
			[request setValue:contentType forHTTPHeaderField:@"Content-Type"];
	}
	
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *responseData = 
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if (responseData && [responseData length] > 0)
		return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	else
		return nil;
}


@end
