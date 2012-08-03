//
//  VugraphAPITests.m
//  VugraphAPITests
//
//  Created by Doaa Anwar on 12-07-27.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import "VugraphAPITests.h"
#import "VugraphAPI.h"




#define app_key @"c3d599dc6988c877ce7341aebf9df5ea"
#define secret_key @"efd6ac532596bd4818d08f6aabc41137"

@implementation VugraphAPITests



- (void)setUp
{
    [super setUp];
    
    userID= [NSNumber numberWithInt:13367567];
    
    // Set-up code here.
    test_subject = [[VugraphAPI alloc] initWithAppKey:app_key secretKey:secret_key];
    
    STAssertNotNil(test_subject, @"Could not create test subject.");
    

    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    
    NSString *comment = [NSString stringWithFormat:@"Really feel sorry for Syria -- god help them"];
    
    NSString *result = [self testSubmitComment:userID comment:comment];
    
    STAssertNotNil(result,@"fail");
    
    
    NSString *photoURL= @"http://farm2.static.flickr.com/1233/712501783_ebffe4ccd3.jpg";
    
    result = [self testSubmitPhoto:userID photo:photoURL];
    
    STAssertNotNil(result,@"fail");
    
    NSString *videoURL=@"http://developers.vufind.com/storage/cars_Vase.flv";
    
    result = [self testSubmitVideo:userID video:videoURL];
    
    STAssertNotNil(result,@"fail");
    
    NSString *venue_id=@"432a0b00f964a520d9271fe3";
    long lat=37.763495;
    long lng=-122.434645;

    
    result = [self testSubmitCheckin:userID lat:lat lng:lng venue_id:venue_id];
    
    STAssertNotNil(result,@"fail");
    
    
    NSString *url=@"http://graph.facebook.com/cocacola/";
    result = [self testSubmitFBLike:userID  FBurl:url];
    STAssertNotNil(result,@"fail");
    
    
    result = [self testGetRecommendation:userID];
    STAssertNotNil(result,@"fail");

    
    result = [self testGetProfileInterest:userID];
     
    STAssertNotNil(result,@"fail");
    
    result = [self testPutDeviceInfo:userID];
    
     STAssertNotNil(result,@"fail");
    
    //TODO will change this ID when calling many submit for the second user
    NSNumber *userB= [NSNumber numberWithInt:12348765];

    result = [self testGetSimilarity:userID userB:userB];
    STAssertNotNil(result,@"fail");
}



- (NSString *) testSubmitComment:(id)user_id comment:(NSString *)comment
{
    NSString *result = [test_subject vuSubmitComment:user_id comment:comment];
    return result;
}

- (NSString *) testSubmitPhoto:(id)user_id photo:(NSString *)photo
{
    
    NSString *result = [test_subject vuSubmitPhoto:user_id photo:photo];
    return result;
}

- (NSString *) testSubmitVideo:(id)user_id video:(NSString *)video
{
    
    NSString *result = [test_subject vuSubmitVideo:user_id video:video];
    return result;
}

- (NSString *) testSubmitCheckin:(id)user_id lat:(long)lat lng:(long)lng venue_id:(NSString *)venue_id
{
    NSString *result = [test_subject vuSubmitCheckin:user_id venueID:venue_id lat:lat lng:lng];
    return result;
}

- (NSString *) testGetProfileInterest:(id)user_id
{
    NSString *result = [test_subject vuGetProfileInterest:user_id];
    return result;
}


- (NSString *) testSubmitFBLike:(id)user_id  FBurl:(NSString *)url
{
    NSString *result = [test_subject vuSubmitFBLike:user_id FBurl:url];
    return result;
}

- (NSString *) testGetSimilarity:(id)userA userB:(id)userB
{
    NSString *result = [test_subject vuGetSimilarity:userA userB:userB];
    return result;
}

- (NSString *) testGetRecommendation:(id)user_id
{
    NSString *result = [test_subject vuGetRecommendation:user_id];
    return result;
}

- (NSString *) testPutDeviceInfo:(id)user_id
{
    NSString *result = [test_subject  vuPutDeviceInfo:user_id];
    return result;
}

@end
