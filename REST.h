//
//  REST.h
//  VufindAPI
//
//  Created by Doaa Anwar on 12-07-27.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REST : NSObject

+ (NSString *) executeMethod:(NSString *)method 
					  onPath:(NSString *)path 
					withData:(NSString *)data 
				 contentType:(NSString *)contentType;

@end
