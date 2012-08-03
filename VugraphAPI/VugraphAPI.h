//
//  VugraphAPI.h
//  VugraphAPI
//
//  Created by Doaa Anwar on 12-07-27.
//  Copyright (c) 2012 Vufind Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>


@interface VugraphAPI : NSObject  <CLLocationManagerDelegate>{
    //application information
    NSString *token;
    NSString *appKey;
    NSString *secretKey;
    
    //iphone device information 
    NSString* openUDID;
    NSString *deviceName;
    NSString * systemName;
    NSString * systemVersion;
    NSString * model;
    NSString *latitude;
    NSString *longitude;
    NSString *ipAddress;
    NSString *countryName;
    NSString *cityName;
    NSString *age;
    
    //iphone location information
    CLLocationManager *locationManager;

}

/*!
 * @method initWithAppKey:secretKey:
 * @abstract create a new vufindAPI with the application key and secret key
 * @param app_Key The application unique key.
 * @param secretKey The application secret key.
 * @result new instance of VifindAPI
*/
- (id) initWithAppKey:(NSString *)app_Key secretKey:(NSString *) secret_Key;

/*!
 * @method initWithAppKey:secretKey:
 * @abstract generate the application unique token and called once on the init
 * @result return application unique token
 */
- (NSString *) getToken;


/*!
 * @method vuSubmitComment:comment:
 * @abstract Submit a Photo to be analyzed for interests and updates user interest profile with interest keywords 
 * @param user_id The application unique userid.
 * @param comment 
 * @result 
 */
- (NSString *) vuSubmitComment:(id)user_id comment:(NSString *)comment;

/*!
 * @method vuSubmitPhoto:photo:
 * @abstract create a new vufindAPI with the application key and secret key
 * @param user_id The application unique userid.
 * @param photo The photo URL
 * @result 
 */
- (NSString *) vuSubmitPhoto:(id)user_id photo:(NSString *)photo;

/*!
 * @method vuSubmitVideo:video:
 * @abstract Submits a video to be analyzed for interests and updates user interest profile 
 * @param user_id The application unique userid.
 * @param video The video URL
 * @result 
 */
- (NSString *) vuSubmitVideo:(id)user_id video:(NSString *)video;

/*!
 * @method vuSubmitCheckin:venueID:lat:lng
 * @abstract Adds location data in user's location interests 
 * @param user_id The application unique userid.
 * @param venueID Foursquare Venue ID of the location
 * @param lat The latitude of the location
 * @param lng The longitude of the location
 * @result 
 */
- (NSString *) vuSubmitCheckin:(id)user_id venueID:(NSString *)venueID lat:(long)lat lng:(long)lng;


/*!
 * @method vuSubmitFBLike:FBurl
 * @abstract Analyzes metadata of the FB page and adds the interest to the users profile 
 * @param user_id The application unique userid.
 * @param FBurl The URL of Facebook page
 * @result 
 */
- (NSString *) vuSubmitFBLike:(id)user_id  FBurl:(NSString *)url;

/*!
 * @method vuGetProfileInterest:
 * @abstract Returns the interest profile of user as JSON array keywords & weights. This API call is valid and returns a valid VuGraph interest profile only after you have submitted 15 activities (i.e 15 vu_submit API calls) for the given user-id. Otherwise, it will return an error code as detailed below. 
 * @param user_id TThe application unique userid.
 * @result Returns the interest profile of user as JSON array keywords & weights.
 */
- (NSString *) vuGetProfileInterest:(id)user_id;

/*!
 * @method vuGetRecommendation:
 * @abstract 
 * @param user_id The application unique userid.
 * @result Returns a list of recommended stuff as JSON array.
 */
- (NSString *) vuGetRecommendation:(id)user_id;


/*!
 * @method vuGetSimilarity:userB:
 * @abstract get the similarity betwen 2 user
 * @param userA The application unique userid for user A.
 * @param userB The application unique userid for user B.
 * @result return the similarity value 
 */
- (NSString *) vuGetSimilarity:(id)userA userB:(id)userB;


/*!
 * @method vuPutDeviceInfo:
 * @abstract save some collected data from the user device
 * @param user_id The application unique userid.
 * @result return true after insert
 */
- (NSString *) vuPutDeviceInfo:(id)user_id;


/*
 * CLLocationManagerDelegate Methods
 */

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
		  fromLocation:(CLLocation *)oldLocation;

-(void)locationManager:(CLLocationManager *)manager
	  didFailWithError:(NSError *)error;

- (void)stopUpdatingLocation:(NSString *)state;


/*
 some helper function
 */
- (NSString *)getIPAddress;
- (id)fetchSSIDInfo;

@end
