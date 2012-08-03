//
//  VugraphAPITests.h
//  VugraphAPITests
//
//  Created by Doaa Anwar on 12-07-27.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "VugraphAPI.h"


@interface VugraphAPITests : SenTestCase {
	
	VugraphAPI *test_subject;
    NSNumber *userID;
    
}

- (NSString *) testSubmitComment:(id)user_id comment:(NSString *)comment;
- (NSString *) testSubmitPhoto:(id)user_id photo:(NSString *)photo;
- (NSString *) testSubmitVideo:(id)user_id video:(NSString *)video;
- (NSString *) testSubmitCheckin:(id)user_id lat:(long)lat lng:(long)lng venue_id:(NSString *)venue_id;
- (NSString *) testGetProfileInterest:(id)user_id;
- (NSString *) testGetRecommendation:(id)user_id;
- (NSString *) testSubmitFBLike:(id)user_id  FBurl:(NSString *)url;
- (NSString *) testGetSimilarity:(id)userA userB:(id)userB;
- (NSString *) testPutDeviceInfo:(id)user_id;

@end
