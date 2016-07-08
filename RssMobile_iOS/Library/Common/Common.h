//
//  Common.h
//  TeamCommish
//
//  Created by Zeeshan Ahmed on 28/09/15.
//  Copyright © 2015 Teknowledge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SpinKit/RTSpinKitView.h>
#import "LocalizationSystem.h"


@interface Common : NSObject

#define APIDEBUG @1

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#ifdef APIDEBUG
#   define APILog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define APILog(...)
#endif


#ifdef DEBUG
#   define PUSH_KEY @"sandbox"
#else
#   define PUSH_KEY @"production"
#endif

typedef enum{
    k_EmailId =1,
    k_facebook ,
    k_twitter,
    k_google,
    k_insatagram,
}SelectLogInType;

extern UIColor *themeBlueColor();
extern UIColor *themeDarkBlueColor();
extern UIColor *themeLightGreyColor();
extern UIColor *themeGreenColor () ;
extern UIColor *themePurpleColor () ;
extern UIColor *themeLightBlueColor () ;
extern UIColor *themeButtonBlueColor () ;
extern UIColor *themeLightPurpleColor () ;
extern UIColor *themeDarkGreyColor () ;
extern UIColor *themeGreenColorFullAlpha () ;

extern BOOL isEmpty (id value);
extern BOOL isEmailValid (NSString * email);
extern BOOL IS_VALID_PASSWORD(NSString *strPassword);
extern bool checkInternetConnection();
extern bool checkSystemTimeFormat();

extern id getUserDefaults(NSString *key);
extern void removeUserDefaults(NSString * key);
extern void updateUserDefaults(NSString * key, id value);
extern id getUserDetails(NSString *key);
extern void updateUserDetails(NSString * key, id value);

extern NSString *getImageString (UIImage *profileImage);
extern UIImage *getImageFromString (NSString *imageString);
extern NSString *getDeviceID();
extern NSString *CompareTwoDates(NSString * otherDate);



#pragma mark - View Size -

extern float originX(UIView *view);
extern float originY(UIView *view);
extern float height(UIView *view);
extern float width(UIView *view);


extern void showHud(UIView * view);
extern void hideHud(UIView *view);



extern NSString *keyUserRegistraionType;
extern NSString *keyUserSocialNetworkID;
extern NSString *keyUserName;
extern NSString *keyUserEmailId;
extern NSString *keyUserType;
extern NSString *keyUserDeviceId ;
extern NSString *keyUserLogintype;
extern NSString *keyUserFullName;
extern NSString *keyUserIsVarified;
extern NSString *keyUserAPImessage;
extern NSString *keyUserUnlockedID;



extern NSString *keyUserDetails;
extern NSString *keyUserFirstName;
extern NSString *keyUserLastName;
extern NSString *keyUserEmail;
extern NSString *keyUserHobbies;
extern NSString *keyUserGender ;
extern NSString *keyUserTagline;
extern NSString *keyUserImage;
extern NSString *keyUserNewupdate;
extern NSString *keyUserOccupation;
extern NSString *keyAPIGoogle;
extern NSString *keyUserPass;
extern NSString *keyOfflineMessage;
extern NSString *keyRequestTimeOurMessage;
extern NSString *keyUserFBID;
extern NSString *keyUserLat;
extern NSString *keyUserLong;
extern NSString *keyURLErorMessage;
extern NSString *keyLoggedInUser;
extern NSString *jsonKeyapiKey;
extern NSString *keySportCat;
extern NSString *keyUserID;
extern NSString *keyID;
extern NSString *keyDevToken;
extern NSString *keyBrowserGoogle;

extern NSString *keyEventName;
extern NSString *keyEventLoc ;
extern NSString *keyEventDate;
extern NSString *keyEventStartTime ;
extern NSString *keyEventEndTime;
extern NSString *keyEventPlayerList;
extern NSString *keyEventLat;
extern NSString *keyEventLong ;
extern NSString *keyEventDescription;
extern NSString *keyEventTotalPlayers;
extern NSString *keyEventCatID;
extern NSString *keyEventALive;
extern NSString *keyEventCreatedOn;
extern NSString *keyEventisJoined;
extern NSString *keyJoinLeaveFrom;
extern NSString *keycancelevent;
extern NSString *keyJoinLeaveTo;
extern NSString *keyUserVibration;
extern NSString *keyUserBlinking;
extern NSString *keyUserImageId;
extern NSString *keyUserImagefullImage;
extern NSString *keyUserImagecrop_image;
extern NSString *keyUserImagetype;
extern NSString *keyUserImagetitle;
extern NSString *keyIsPremiumAlert;
extern NSString *keyIsHomeAlert;
extern NSString *keyIsNewRegistration;

extern NSString * KeyYes;
extern NSString * KeyNo;

extern NSString * KeyImageWidth;
extern NSString * KeyImageheight;
extern NSString * KeyX_Position;
extern NSString * KeyY_Position;
extern NSString * KeyThumbWidth;

extern NSString * keyFollowingArray;
extern NSString * keySystemTimeFormat;
extern NSString * keyServerNotConnected;
extern NSString * keyServerConnectionLost;

extern NSString * keyImageText;
extern NSString * keyImageTextFontSize;
extern NSString * keyImageTextColor;
extern NSString * keyImageTextLocation;
extern NSString * keyImageTextAngle;
extern NSString * keyImageTextScale;
extern NSString * keyImageTextFrame;
extern NSString * keyImageTextTransform;
extern NSString * keyImageTextEditPress;



extern NSString * kNotificationGallertLoading;


+(MBProgressHUD *)showCustomHud:(NSString *)label label2:(NSString *)label2 ;
+(void)showToastMessage:(NSString *)message withTitle:(NSString *)title withAction:(BOOL)action withMessageType:(BOOL)messageType;
+(RTSpinKitView *)showCustomLogoHud;
//+(MBProgressHUD *)showCustomProgressBar:(float )progress;
#pragma mark -
#pragma mark - View Up & Down Method
+(void)UpDownSubView:(UIView *)view y_pos:(CGFloat )y_pos;
+(BOOL)isNullString:(NSString*)_inputString;
+(MBProgressHUD*)upadteHUD:(MBProgressHUD*)hud withProgress:(float)prg;

+ (NSDictionary*) cameraResolutions;
+ (NSString*)hardwareString;
+(NSString *)getLocalDateTimeFromUTC:(NSString *)strDate;
+(NSString *)getLocalTimeFromUTC:(NSString *)strDate;


+(BOOL) validateUrl: (NSString *) candidate ;
+(NSString *)getLastString:(NSString *)string;


@end
