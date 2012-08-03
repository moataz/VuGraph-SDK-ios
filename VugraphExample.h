//
//  VugraphExample.h
//  VuGraphSDK
//
//  Created by Doaa Anwar on 12-08-01.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "VugraphAPI.h"

@interface VugraphExample : NSObject
{
    NSString *appKey;
    NSString *secretKey;
    NSString *userID;
    NSString *token;
    VugraphAPI *vugraphInst;
}

- (void) callVugraphAPI;

@end
