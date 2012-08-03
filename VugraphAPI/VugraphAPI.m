//
//  VugraphAPI.m
//  VugraphAPI
//
//  Created by Doaa Anwar on 12-07-27.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import "VugraphAPI.h"
#import "REST.h"
#import "JSON.h"
#include "VU_OpenUDID.h"
#include <ifaddrs.h> 
#include <arpa/inet.h>



@implementation VugraphAPI

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}


- (id) initWithAppKey:(NSString *)app_Key secretKey:(NSString *) secret_Key;
{
    self = [super init];
    if (self) {
        // Initialization code here.
        secretKey = secret_Key;
        appKey = app_Key;
        [self getToken];

        openUDID = [OpenUDID value];
        
        NSLog(@"UDID value= %@",openUDID);
        
        cityName = nil;
        age = nil;
        
        
        deviceName=[[UIDevice currentDevice] name];
        
        NSLog(@"Device name= %@",deviceName);

        systemName = [[UIDevice currentDevice] systemName];
        NSLog(@"System name= %@",systemName);
        
        systemVersion = [[UIDevice currentDevice] systemVersion];
        NSLog(@"System version= %@",systemVersion);

        
        model = [[UIDevice currentDevice] model];
        NSLog(@"Model = %@",model);
        
       
        NSLocale *locale = [NSLocale currentLocale];
        NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
        

        countryName = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
        
        NSLog(@"Country Name = %@",countryName);
        
                     
        //Network information
        NSString *SSID=[self fetchSSIDInfo];
        NSLog(@"Network= %@",SSID);
        
        //IP address
        ipAddress = [self getIPAddress];
        NSLog(@"IP address = %@",ipAddress);
        
        latitude = @"0.0";
        longitude = @"0.0";
        
        BOOL locationAllowed = [CLLocationManager locationServicesEnabled];
        if(locationAllowed == YES)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation];
            [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:[[NSNumber numberWithDouble:30] doubleValue]];
        }
        else
        {
            latitude = @"0.0";
            longitude = @"0.0";
        }
      
    }
    
    return self;
}


- (NSString *) getToken
{
    NSString * authURL= [NSString stringWithFormat:@"/vu_auth.php?app_key=%@&secret_key=%@",appKey,secretKey];
    NSString *json = [REST executeMethod:@"GET" onPath:authURL withData:nil contentType:nil];
    
    NSDictionary *dataDic =[json JSONValue];

    token = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"token"]];
    return @"true";
   
}



- (NSString *) vuSubmitComment:(id)user_id comment:(NSString *)comment
{
   
    NSString * submitCommentURL= [NSString stringWithFormat:@"/vu_submit_comment.php?app_key=%@&user_id=%@&token=%@&comment=%@",appKey,user_id,token,comment];
    
    NSString *json = [REST executeMethod:@"GET" onPath:submitCommentURL withData:nil contentType:nil];
    
    NSLog(@"Comment result=%@",json);
    return json;

}


- (NSString *) vuSubmitPhoto:(id)user_id photo:(NSString *)photo
{
    NSString * submitPhotoURL= [NSString stringWithFormat:@"/vu_submit_photo.php?app_key=%@&user_id=%@&token=%@&media_url=%@",appKey,user_id,token,photo];
    NSString *json = [REST executeMethod:@"GET" onPath:submitPhotoURL withData:nil contentType:nil];
    NSLog(@"Photo result=%@",json);
    return json;
}

- (NSString *) vuSubmitVideo:(id)user_id video:(NSString *)video
{
    NSString * submitVideoURL= [NSString stringWithFormat:@"/vu_submit_video.php?app_key=%@&user_id=%@&token=%@&url=%@",appKey,user_id,token,video];
    NSString *json = [REST executeMethod:@"GET" onPath:submitVideoURL withData:nil contentType:nil];
     NSLog(@"Video result=%@",json);
    return json;

}


- (NSString *) vuSubmitCheckin:(id)user_id venueID:(NSString *)venueID lat:(long)lat lng:(long)lng
{
    NSString * checkinURL= [NSString stringWithFormat:@"/vu_submit_checkin.php?app_key=%@&user_id=%@&token=%@&lat=%lf&lng=%lf&venue_id=%@",appKey,user_id,token,lat,lng,venueID];
    NSString *json = [REST executeMethod:@"GET" onPath:checkinURL withData:nil contentType:nil];
    NSLog(@"Checkin result=%@",json);
    return json;
}


- (NSString *) vuSubmitFBLike:(id)user_id  FBurl:(NSString *)url
{
    NSString * submitFBLike= [NSString stringWithFormat:@"/vu_submit_fblike.php?app_key=%@&user_id=%@&token=%@&FBurl=%@",appKey,user_id,token,url];
    NSString *json = [REST executeMethod:@"GET" onPath:submitFBLike withData:nil contentType:nil];
    NSLog(@"FBlike submit result=%@",json);
    return json;
}

- (NSString *) vuGetProfileInterest:(id)user_id
{
    NSString * getInterestURL= [NSString stringWithFormat:@"/vu_get_interest_profile.php?app_key=%@&user_id=%@&token=%@",appKey,user_id,token];
    NSString *json = [REST executeMethod:@"GET" onPath:getInterestURL withData:nil contentType:nil];
    NSLog(@"Profile Interest =%@",json);
    return json;
}



- (NSString *) vuGetRecommendation:(id)user_id
{
    NSString * getRecommendationURL= [NSString stringWithFormat:@"/vu_get_recs.php?app_key=%@&user_id=%@&token=%@",appKey,user_id,token];
    NSString *json = [REST executeMethod:@"GET" onPath:getRecommendationURL withData:nil contentType:nil];
    NSLog(@"Recommendation =%@",json);
    return json;
}

- (NSString *) vuGetSimilarity:(id)userA userB:(id)userB
{
    NSString * getSimilarityURL= [NSString stringWithFormat:@"/vu_get_similarity.php?app_key=%@&user_a=%@&user_b=%@&token=%@",appKey,userA,userB,token];
    NSString *json = [REST executeMethod:@"GET" onPath:getSimilarityURL withData:nil contentType:nil];
    NSLog(@"Similarity =%@",json);
    return json;
}


- (NSString *) vuPutDeviceInfo:(id)user_id
{
    NSString * putDeviceInfoURL= [NSString stringWithFormat:@"/vu_put_info.php?app_key=%@&token=%@&user_id=%@&udid=%@&dname=%@&sysname=%@&sysversion=%@&ip=%@&lat=%@&lng=%@&country=%@&age=%@&city=%@",appKey,token,user_id,openUDID,deviceName,systemName,systemVersion,ipAddress,latitude,longitude,countryName,age,cityName];
   
    NSString *json = [REST executeMethod:@"POST" onPath:putDeviceInfoURL withData:nil contentType:nil];
    NSLog(@"Result =%@",json);
    return json;
}




- (id)fetchSSIDInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge_retained CFStringRef)ifnam);
        NSLog(@"%s: %@ => %@", __func__, ifnam, info);
        if (info && [info count]) {
            break;
        }
           }
    NSLog(@"info: %@",info);
    return info ;
}


- (NSString *)getIPAddress { 
  
  NSString *address = @"error"; 
  struct ifaddrs *interfaces = NULL; 
  struct ifaddrs *temp_addr = NULL; 
  int success = 0; 
  // retrieve the current interfaces - returns 0 on success 
   success = getifaddrs(&interfaces); 
  if (success == 0) { 
    // Loop through linked list of interfaces 
     temp_addr = interfaces; 
     while(temp_addr != NULL) 
     { 
          if(temp_addr->ifa_addr->sa_family == AF_INET) 
          { // Check if interface is en0 which is the wifi connection on the iPhone 
              if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en1"]) 
              { // Get NSString from C String 
                  address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
              } 
          } 
         temp_addr = temp_addr->ifa_next; 
     } 
  } // Free memory 
    
 freeifaddrs(interfaces); 
 return address; 
} 

    



    
#pragma mark -
#pragma mark CLLocationManagerDelegate Methods


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
                     degrees, minutes, seconds];
    NSLog(@"latitude %@",lat);
    latitude = lat;
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"", 
                       degrees, minutes, seconds];
    NSLog(@"longitude %@",longt);
    longitude = longt;

}



-(void)locationManager:(CLLocationManager *)manager
	  didFailWithError:(NSError *)error {
	
	NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
    NSLog(@"error = %@",errorType);
    
    latitude = @"0.0";
    longitude = @"0.0";
}

- (void)stopUpdatingLocation:(NSString *)state {
   
    NSLog(@"State %@",state);
     
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
   
}



#pragma mark -

@end
