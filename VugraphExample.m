//
//  VugraphExample.m
//  VuGraphSDK
//
//  Created by Doaa Anwar on 12-08-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VugraphExample.h"

@implementation VugraphExample

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
      
    
        appKey = @"<your application key here>"; 
        secretKey = @"<your application secret key here>";        
        
        userID = @""; //your user unique ID
        
        //initialize vugraphAPI class here to set appKey and secretKey and get the token
        vugraphInst = [[VugraphAPI alloc] initWithAppKey:appKey secretKey:secretKey];
        
        
    
    }
    
    return self;
}


- (void) callVugraphAPI
{
   
    
    //To submit photo
    
    NSString *photoURL= @"<photo url here>";
    
    NSString *result = [vugraphInst vuSubmitPhoto:userID photo:photoURL];
    
    
    //To submit video
    
    NSString *videoURL=@"<video url here>";
    
    result = [vugraphInst vuSubmitVideo:userID video:videoURL];
    
    
    
    //To submit comment
    
    NSString *comment = [NSString stringWithFormat:@"<put the comment comment here>"];
    
    result = [vugraphInst vuSubmitComment:userID comment:comment];
    
    
    
    
   
    //To submit checkin 
   
    NSString *venue_id=@"<put venue ID value here>";
    long lat=0.0; // <latitude value here>
    long lng=-0.0; // <longitude value here>
    
    
    result = [vugraphInst vuSubmitCheckin:userID venueID:venue_id lat:lat lng:lng];
    
   
    //To submit facebook page like
    
    NSString *url=@"<put facebook page url here>";
    result = [vugraphInst vuSubmitFBLike:userID  FBurl:url];
       
    
    
    //To get user profile
    result = [vugraphInst vuGetProfileInterest:userID];

    
    //To get recommendation for the user
    result = [vugraphInst vuGetRecommendation:userID];
      
        
    //To get similarity between 2 user, call submit APIs for another user ID then call the similarity API
    NSNumber *userB= 0 ;// <the user B unique ID>
    
    result = [vugraphInst vuGetSimilarity:userID userB:userB];
   
    
    //To save collected data from the user device
    result = [vugraphInst vuPutDeviceInfo:userID];
    
    
      
}

@end
