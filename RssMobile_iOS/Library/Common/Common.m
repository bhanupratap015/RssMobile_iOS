//
//  Common.m
//  TeamCommish
//
//  Created by Zeeshan Ahmed on 28/09/15.
//  Copyright © 2015 Teknowledge. All rights reserved.
//

#import "Common.h"
#import <CRToast/CRToast.h>
#import "Reachability.h"
#import <sys/utsname.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation Common

//22,35,74
UIColor *themeBlueColor () {
    return [UIColor colorWithRed:22.0/255.0 green:35.0/255.0 blue:74.0/255.0 alpha:1.0];
}
UIColor *themeDarkBlueColor () {
    return [UIColor colorWithRed:20.0/255.0 green:36.0/255.0 blue:72.0/255.0 alpha:1.0];
}
UIColor *themeButtonBlueColor () {
    return [UIColor colorWithRed:21.0/255.0 green:112.0/255.0 blue:195.0/255.0 alpha:1.0];
}
UIColor *themeLightBlueColor () {
    return [UIColor colorWithRed:(0.0/255.0) green:(173/255.0) blue:(239/255.0) alpha:1.0];
}
UIColor *themeGreenColor () {
    return [UIColor colorWithRed:39.0/255.0 green:195.0/255.0 blue:43.0/255.0 alpha:0.5];
}
UIColor *themeGreenColorFullAlpha () {
    return [UIColor colorWithRed:39.0/255.0 green:195.0/255.0 blue:43.0/255.0 alpha:1.0];
}
UIColor *themeLightPurpleColor () {
    return [UIColor colorWithRed:78.0/255.0 green:70.0/255.0 blue:164.0/255.0 alpha:1.0];
}
UIColor *themePurpleColor () {
    return [UIColor colorWithRed:94.0/255.0 green:93.0/255.0 blue:200.0/255.0 alpha:1.0];
}
UIColor *themeDarkGreyColor () {
    return [UIColor colorWithRed:(121/255.0) green:(122/255.0) blue:(122/255.0) alpha:1.0];
}
UIColor *themeLightGreyColor () {
    return [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0];
}

BOOL isEmpty (id value) {
    
    return (value == (id)[NSNull null] || value == nil || ([value isKindOfClass:[NSString class]] && ([value isEqualToString:@""] || [value isEqualToString:@"<null>"] || [value isEqualToString:@"(null)"]))) ? YES : NO;
}

BOOL isEmailValid(NSString * email) {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

BOOL IS_VALID_PASSWORD(NSString *strPassword){
    NSString *strPass = strPassword;
    if (![strPass isEqualToString:@""]) {
        NSString *PassRegex = @"[A-Z0-9a-z]{6,15}";
        NSPredicate *PassTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", PassRegex];
        BOOL myStringMatchesRegEx=[PassTest evaluateWithObject:strPass];
        return myStringMatchesRegEx;
    }
    else{
        return NO;
    }
}


void updateUserDefaults(NSString * key, id value) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
}
id getUserDefaults(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
//void updateUserDetails(NSString * key, id value) {
//    [AppDelegate delegate].userDetails = value;
////    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
////    [[NSUserDefaults standardUserDefaults] synchronize];
//}

void removeUserDefaults(NSString * key) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//id getUserDetails(NSString *key) {
//    return [AppDelegate delegate].userDetails;//[[NSUserDefaults standardUserDefaults] objectForKey:key];
//}

#pragma mark - View Size -

float originX(UIView *view) {
    return view.frame.origin.x;
}

float originY(UIView *view) {
    return view.frame.origin.y;
}

float height(UIView *view) {
    return view.frame.size.height;
}

float width(UIView *view) {
    return view.frame.size.width;
}

NSString *getImageString (UIImage *profileImage) {
    // From image to data
    NSData *dataImage = [NSData dataWithData:UIImagePNGRepresentation(profileImage)];
    return [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
NSString *getDeviceID (){
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
UIImage *getImageFromString (NSString *imageString) {
    NSData *dataImage = [[NSData alloc] initWithBase64EncodedString:imageString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:dataImage];
}

//-------------------------------------------------------------------------

#pragma mark - Show/Hide Progress HUD -

//-------------------------------------------------------------------------

void showHud(UIView * view) {
    //[AppDelegate delegate].window.userInteractionEnabled=NO;
    hideHud(view);
    view.userInteractionEnabled=NO;
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}
void hideHud(UIView *view) {
    //[AppDelegate delegate].window.userInteractionEnabled=YES;
    view.userInteractionEnabled=YES;
    [MBProgressHUD hideHUDForView:view animated:YES];
}

void showHudWithMessage(NSString *title, NSString *subtile, UIView *view) {
    //[AppDelegate delegate].window.userInteractionEnabled=NO;
    hideHud(view);
    view.userInteractionEnabled=NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = title;
    hud.detailsLabelText = subtile;
}

#pragma mark  Check Internet Connection
bool checkInternetConnection()
{
    Reachability *networkReachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    //    if(!networkStatus)
    //    {
    //        [self showAlert:@"" andMsg:@"No internet connection detected!"];
    //
    //    }
    return networkStatus;
    
}

#pragma mark  Check Internet Connection
bool checkSystemTimeFormat()
{
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    return ([format rangeOfString:@"a"].location == NSNotFound);
}



extern NSString *CompareTwoDates (NSString * otherDate){
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * currDate = [NSDate date];
    NSDate * endDate = [formatter dateFromString:otherDate];
    
    NSInteger month = [[[NSCalendar currentCalendar] components: NSCalendarUnitMonth
                                                       fromDate: endDate
                                                         toDate: currDate
                                                        options: 0] month];
    
    NSInteger days = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                      fromDate:endDate
                                                        toDate:currDate
                                                       options:0] day];

    NSInteger hours = [[[NSCalendar currentCalendar] components:NSCalendarUnitHour
                                                      fromDate:endDate
                                                        toDate:currDate
                                                       options:0] hour];
    NSInteger minutes = [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute
                                                      fromDate:endDate
                                                        toDate:currDate
                                                       options:0] minute];

    
    NSLog(@"%ld", (long)month);
    
    NSMutableString * strDate = [NSMutableString stringWithFormat:@"Active"];
    if(month == 1)
        [strDate appendFormat:@" %ld month",(long)month];
    else if(month >1)
        [strDate appendFormat:@" %ld months",(long)month];

    if(days == 1)
        [strDate appendFormat:@" %ld day",(long)days];
    else if(days >1)
        [strDate appendFormat:@" %ld days",(long)days];

    
    if(month == 0 && days == 0){
        if(hours == 1)
            [strDate appendFormat:@" %ld hour",hours];
        else if(hours >1)
            [strDate appendFormat:@" %ld hours",hours];
    }


    if(hours == 0){
        if(minutes/60 == 1)
            [strDate appendFormat:@" %ld min",minutes/60];
        else if(minutes/60 >1)
            [strDate appendFormat:@" %ld mins",minutes/60];
        else if(minutes >0)
            [strDate appendFormat:@" %ld mins",minutes];
        else{
            return @"Active now";
        }
    }
        [strDate appendFormat:@" ago"];
    
    return [NSString stringWithString:strDate];
}

+(NSString *)getLocalDateTimeFromUTC:(NSString *)strDate
{
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    [dtFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dtFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *aDate = [dtFormat dateFromString:strDate];
    
    [dtFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dtFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    return [dtFormat stringFromDate:aDate];
}

+(NSString *)getLocalTimeFromUTC:(NSString *)strDate
{
    NSDateFormatter *dtFormat = [[NSDateFormatter alloc] init];
    [dtFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dtFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *aDate = [dtFormat dateFromString:strDate];
    
    if (checkSystemTimeFormat())
        [dtFormat setDateFormat:@"HH:mm"];
    else
        [dtFormat setDateFormat:@"hh:mm a"];
    [dtFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    return [dtFormat stringFromDate:aDate];
}

+(MBProgressHUD *)showCustomHud:(NSString *)label label2:(NSString *)label2 {
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyle9CubeGrid color:[UIColor whiteColor]];
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
//    spinner.sizeToFit;
    [spinner startAnimating];
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];//showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = [NSString stringWithFormat:@"%@",AMLocalizedString(label, nil)];
    hud.detailsLabelText = [NSString stringWithFormat:@"%@",AMLocalizedString(label2, nil)];
    return hud;
}

//+(MBProgressHUD *)showCustomProgressBar:(float )progress {
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane];
//    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
//    [spinner startAnimating];
//    MBProgressHUD *hud = [[MBProgressHUD alloc]init];//showHUDAddedTo:self.view animated:YES];
//    hud.square = YES;
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.labelText = [NSString stringWithFormat:@"%d%@",(int)(progress*100),@"%"];
//    hud.progress = progress;
//
//    return hud;
//}

+(MBProgressHUD*)upadteHUD:(MBProgressHUD*)hud withProgress:(float)prg{
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane];
//    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
//    [spinner startAnimating];
  //  MBProgressHUD *hud = [[MBProgressHUD alloc]init];//showHUDAddedTo:self.view animated:YES];
    hud.labelText = [NSString stringWithFormat:@"%d%@",(int)(prg*100),@"%"];
    hud.progress = prg;
    return hud;
}

//- (void)doSomeFunkyStuff {
//    float progress = 0.0;
//    
//    while (progress < 1.0) {
//        progress += 0.01;
//        HUD.progress = progress;
//        usleep(50000);
//    }
//}

+(RTSpinKitView *)showCustomLogoHud{
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane];
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    //spinner.sizeToFit;
    [spinner startAnimating];
    return spinner;
}


//This is a later modification and since earlier the app contained toast messages and this method is being called from everywhere hence the alert code is change here only
+(void)showToastMessage:(NSString *)message withTitle:(NSString *)title withAction:(BOOL)action withMessageType:(BOOL)messageType
{
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
    [alertView show];
    
    
//    NSMutableDictionary *options = [@{kCRToastAnimationInDirectionKey        :  @(CRToastAnimationDirectionLeft),
//                                      kCRToastAnimationInTypeKey             :  @(CRToastAnimationTypeSpring),
//                                      kCRToastAnimationOutDirectionKey       :  @(CRToastAnimationDirectionRight),
//                                      kCRToastAnimationOutTypeKey            :  @(CRToastAnimationTypeSpring),
//                                      kCRToastTextAlignmentKey               :  @(NSTextAlignmentLeft),
//                                      kCRToastBackgroundColorKey            : [UIColor blackColor],
//                                      kCRToastTextKey                        :  [NSString stringWithFormat:@"%@",AMLocalizedString(title, nil)],
//                                      kCRToastTimeIntervalKey                :  @(2.0),
//                                      kCRToastSubtitleTextKey                :  [NSString stringWithFormat:@"%@",AMLocalizedString(message, nil)],
//                                      kCRToastSubtitleTextAlignmentKey       :  @(NSTextAlignmentLeft),
//                                      kCRToastNotificationTypeKey            :  @(CRToastTypeNavigationBar),
//                                      kCRToastNotificationPresentationTypeKey:  @(CRToastPresentationTypeCover),
//                                      kCRToastUnderStatusBarKey              :  @(YES),
//                                      kCRToastFontKey                        :   [UIFont fontWithName:@"HelveticaNeue-Bold" size:16],
//                                      } mutableCopy];
//    
//    if (messageType) {
//        options[kCRToastTextColorKey] = themeLightGreyColor();
//        options[kCRToastSubtitleTextColorKey] = themeLightGreyColor();
//    }else{
//        options[kCRToastTextColorKey] = [UIColor whiteColor];
//        options[kCRToastSubtitleTextColorKey] = [UIColor whiteColor];
//    }
//    
//    if (action) {
//        options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
//                                                                                                      automaticallyDismiss:YES
//                                                                                                                     block:^(CRToastInteractionType interactionType){
//                                                                                                                     }]];
//    }
//    
//    [CRToastManager showNotificationWithOptions:options completionBlock:nil];
}

NSString *keyUserRegistraionType        =   @"registrationtype";
NSString *keyUserSocialNetworkID        =   @"socialnetworkid";
NSString *keyUserName                   =   @"username";
NSString *keyUserEmailId                =   @"emailid";
NSString *keyUserType                   =   @"usertype";
NSString *keyUserDeviceId               =   @"deviceid";
NSString *keyUserLogintype              =   @"logintype";
NSString *keyUserFullName               =   @"fullname";
NSString *keyUserIsVarified             =   @"isVarified";

NSString *keyUserAPImessage     =   @"message";
NSString *keyUserUnlockedID     =   @"user_2";


NSString *keyUserDetails        =   @"user_details";
NSString *keyUserFirstName      =   @"firstname";
NSString *keyUserLastName       =   @"lastname";
NSString *keyUserEmail          =   @"email";
NSString *keyUserHobbies        =   @"hobbies";
NSString *keyUserGender         =   @"gender";
NSString *keyUserTagline        =   @"tagline";
NSString *keyUserImage          =   @"profile_pic";
NSString *keyUserPass           =   @"password";
NSString *keyUserOccupation     =   @"occupation";
NSString *keyUserFBID           =   @"FBID";
NSString *keyUserLat            =   @"latitude";
NSString *keyUserLong           =   @"longitude";
NSString *keyID                 =   @"id";
NSString *keyUserID             =   @"userid";
NSString *keyAPIGoogle          =   @" AIzaSyBWgfOdmNZ9bjBz_5rGAoxHFuq94mZ4jDY ";
NSString *keyBrowserGoogle      =   @"AIzaSyC9_0COp8vbrECrh-3bweQRjdrMmwPOrvs";
NSString *keyOfflineMessage     =   @"Can't find Internet :-(";
NSString *keyRequestTimeOurMessage      =   @"The request timed out. :-(";
NSString *keyServerNotConnected         =   @"Could not connect to the server :-(";
NSString *keyServerConnectionLost       =   @"The network connection was lost :-(";

NSString *keyURLErorMessage     =   @"Some error occured,please try again later";
NSString *keyLoggedInUser       =   @"isLoggedIn";
NSString *jsonKeyapiKey         =   @"apiKey";

NSString *keySportCat           =   @"sportsCategory";
NSString *keyDevToken           =   @"deviceToken";
NSString *keyJoinLeaveFrom      =   @"joinleavefromevent";
NSString *keycancelevent        =   @"cancelevent";
NSString *keyJoinLeaveTo        =   @"joinleavetoevent";


//These are the keys which are required by the APimanager Parameters,but these are declared here becuase they are also used in the Create Sport page
NSString *keyEventName          = @"eventtitle";
NSString *keyEventLoc           = @"eventlocation";
NSString *keyEventDate          = @"eventdate";
NSString *keyEventStartTime     = @"starttime";
NSString *keyEventEndTime       = @"endtime";
NSString *keyEventPlayerList    = @"playerlist";
NSString *keyEventLat           = @"eventlatitude";
NSString *keyEventLong          = @"eventlongitude";
NSString *keyEventDescription   = @"description";
NSString *keyEventTotalPlayers  = @"totalplayers";
NSString *keyEventCatID         = @"sportcategoryid";
NSString *keyEventALive         = @"iseventlive";
NSString *keyEventCreatedOn     = @"createdon";
NSString *keyEventisJoined      = @"areYouIn";

NSString *keyUserVibration      = @"editVibration";
NSString *keyUserBlinking       = @"editBlinking";
NSString *keyUserImageId        = @"imageid";
NSString *keyUserNewupdate      = @"newupdate";
NSString *keyUserImagefullImage    = @"fullimage";
NSString *keyUserImagecrop_image   = @"crop_image";
NSString *keyUserImagetype          = @"imagetype";
NSString *keyUserImagetitle         = @"imagetitle";
NSString *keyIsPremiumAlert         = @"PremiumAlert";
NSString *keyIsHomeAlert            = @"HomeAlert";
NSString *keyIsNewRegistration      = @"isNewRegistration";



NSString * KeyYes               = @"YES";
NSString * KeyNo                = @"NO";

NSString * KeyImageWidth               = @"width";
NSString * KeyImageheight              = @"height";
NSString * KeyX_Position               = @"x_position";
NSString * KeyY_Position               = @"y_position";
NSString * KeyThumbWidth               = @"thumb_width";

NSString *keyFollowingArray            = @"keyFollowingArray";
NSString *keySystemTimeFormat          = @"keySystemTimeFormat";


NSString * keyImageText                 = @"ImageText";
NSString * keyImageTextFontSize         = @"ImageTextFontSize";
NSString * keyImageTextColor            = @"ImageTextColor";
NSString * keyImageTextLocation         = @"ImageTextLocation";
NSString * keyImageTextAngle            = @"ImageTextAngle";
NSString * keyImageTextScale            = @"ImageTextScale";
NSString * keyImageTextFrame            = @"ImageTextFrame";
NSString * keyImageTextTransform        = @"ImageTextTransform";
NSString * keyImageTextEditPress        = @"ImageTextEditPress";

NSString * kNotificationGallertLoading   = @"NotificationGallertLoading";

#pragma mark -
#pragma mark - View Up & Down Method
+(void)UpDownSubView:(UIView *)view y_pos:(CGFloat )y_pos
{
    [UIView animateWithDuration:0.25 animations:^{
        view.frame = CGRectMake(view.frame.origin.x, y_pos, view.frame.size.width, view.frame.size.height);
    }];
}

#pragma mark-
#pragma mark Null String Check
+(BOOL)isNullString:(NSString*)_inputString
{
    
    NSString *InputString=_inputString;
    
    if( (InputString == nil) ||(InputString ==(NSString *)[NSNull null])||([InputString isEqual:nil])||([InputString length] == 0)||([InputString isEqualToString:@""])||([InputString isEqualToString:@"(NULL)"])||([InputString isEqualToString:@"<NULL>"])||([InputString isEqualToString:@"<null>"]||([InputString isEqualToString:@"(null)"])||([InputString isEqualToString:@""]))
       
       )
        return YES;
    else
        return NO ; 
    
}



+ (NSDictionary*) cameraResolutions {
    NSString* deviceModel = [Common hardwareString];
    
    // iPhone 4S
    if ([deviceModel isEqualToString:@"iPhone4,1"]) {
        
        NSString* lFrontCam = @"640x480";
        NSString* lBackCam = @"1920x1080";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPhone 5/5C/5S/6/6+/iPod 6
    else if ([deviceModel isEqualToString:@"iPhone5,1"]
             || [deviceModel isEqualToString:@"iPhone5,2"]
             || [deviceModel isEqualToString:@"iPhone5,3"]
             || [deviceModel isEqualToString:@"iPhone5,4"]
             || [deviceModel isEqualToString:@"iPhone6,1"]
             || [deviceModel isEqualToString:@"iPhone6,2"]
             || [deviceModel isEqualToString:@"iPhone7,1"]
             || [deviceModel isEqualToString:@"iPhone7,2"]
             || [deviceModel isEqualToString:@"iPod7,1"]) {
        
        NSString* lFrontCam = @"1280x720";
        NSString* lBackCam = @"1920x1080";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPhone 6S/6S+
    else if ([deviceModel isEqualToString:@"iPhone8,1"]
             || [deviceModel isEqualToString:@"iPhone8,2"]) {
        NSString* lFrontCam = @"1280x960";
        NSString* lBackCam = @"1920x1080";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad 2
    else if ([deviceModel isEqualToString:@"iPad2,1"]
             || [deviceModel isEqualToString:@"iPad2,2"]
             || [deviceModel isEqualToString:@"iPad2,3"]
             || [deviceModel isEqualToString:@"iPad2,4"]) {
        
        
        NSString* lFrontCam = @"640x480,480x360,192x144";
        NSString* lBackCam = @"1280x720,960x720,480x360,192x144,640x480";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad 3
    else if ([deviceModel isEqualToString:@"iPad3,1"]
             || [deviceModel isEqualToString:@"iPad3,2"]
             || [deviceModel isEqualToString:@"iPad3,3"]) {
        
        
        NSString* lFrontCam = @"640x480,480x360,192x144";
        NSString* lBackCam = @"2592x1936,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad 4/Air/Mini/Mini 2/Mini 3/iPod 5G
    else if ([deviceModel isEqualToString:@"iPad3,4"]
             || [deviceModel isEqualToString:@"iPad3,5"]
             || [deviceModel isEqualToString:@"iPad3,6"]
             || [deviceModel isEqualToString:@"iPad4,1"]
             || [deviceModel isEqualToString:@"iPad4,2"]
             || [deviceModel isEqualToString:@"iPad4,3"]
             || [deviceModel isEqualToString:@"iPad4,4"]
             || [deviceModel isEqualToString:@"iPad4,5"]
             || [deviceModel isEqualToString:@"iPad4,6"]
             || [deviceModel isEqualToString:@"iPad4,7"]
             || [deviceModel isEqualToString:@"iPad4,8"]
             || [deviceModel isEqualToString:@"iPod5,1"]) {
        
        NSString* lFrontCam = @"1280x960,1280x720,640x480,480x360,192x144";
        NSString* lBackCam = @"2592x1936,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    // iPad Air 2/Mini 4/Pro
    else if ([deviceModel isEqualToString:@"iPad5,3"]
             || [deviceModel isEqualToString:@"iPad5,4"]) {
        NSString* lFrontCam = @"1280x960,1280x720,640x480,480x360,192x144";
        NSString* lBackCam = @"3264x2448,1920x1080,1280x720,640x480,480x360,192x144";
        NSDictionary* lCamResolutions = @{@"front":lFrontCam,
                                          @"back":lBackCam};
        return lCamResolutions;
    }
    return nil;
}
+ (NSString*)hardwareString {
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

+ (NSString*)deviceModelName {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //MARK: More official list is at
    //http://theiphonewiki.com/wiki/Models
    //MARK: You may just return machineName. Following is for convenience
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"iPhone Simulator",
      @"x86_64":   @"iPad Simulator",
      
      @"iPhone1,1":    @"iPhone",
      @"iPhone1,2":    @"iPhone 3G",
      @"iPhone2,1":    @"iPhone 3GS",
      @"iPhone3,1":    @"iPhone 4",
      @"iPhone3,2":    @"iPhone 4(Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      @"iPhone4,1":    @"iPhone 4S",
      @"iPhone5,1":    @"iPhone 5(GSM)",
      @"iPhone5,2":    @"iPhone 5(GSM+CDMA)",
      @"iPhone5,3":    @"iPhone 5c(GSM)",
      @"iPhone5,4":    @"iPhone 5c(GSM+CDMA)",
      @"iPhone6,1":    @"iPhone 5s(GSM)",
      @"iPhone6,2":    @"iPhone 5s(GSM+CDMA)",
      
      @"iPhone7,1":    @"iPhone 6+ (GSM+CDMA)",
      @"iPhone7,2":    @"iPhone 6 (GSM+CDMA)",
      
      @"iPhone8,1":    @"iPhone 6S (GSM+CDMA)",
      @"iPhone8,2":    @"iPhone 6S+ (GSM+CDMA)",
      
      @"iPad1,1":  @"iPad",
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPad Mini 1G (WiFi)",
      @"iPad2,6":  @"iPad Mini 1G (GSM)",
      @"iPad2,7":  @"iPad Mini 1G (GSM+CDMA)",
      @"iPad3,1":  @"iPad 3(WiFi)",
      @"iPad3,2":  @"iPad 3(GSM+CDMA)",
      @"iPad3,3":  @"iPad 3(GSM)",
      @"iPad3,4":  @"iPad 4(WiFi)",
      @"iPad3,5":  @"iPad 4(GSM)",
      @"iPad3,6":  @"iPad 4(GSM+CDMA)",
      
      @"iPad4,1":  @"iPad Air(WiFi)",
      @"iPad4,2":  @"iPad Air(GSM)",
      @"iPad4,3":  @"iPad Air(GSM+CDMA)",
      
      @"iPad5,3":  @"iPad Air 2 (WiFi)",
      @"iPad5,4":  @"iPad Air 2 (GSM+CDMA)",
      
      @"iPad4,4":  @"iPad Mini 2G (WiFi)",
      @"iPad4,5":  @"iPad Mini 2G (GSM)",
      @"iPad4,6":  @"iPad Mini 2G (GSM+CDMA)",
      
      @"iPad4,7":  @"iPad Mini 3G (WiFi)",
      @"iPad4,8":  @"iPad Mini 3G (GSM)",
      @"iPad4,9":  @"iPad Mini 3G (GSM+CDMA)",
      
      @"iPod1,1":  @"iPod 1st Gen",
      @"iPod2,1":  @"iPod 2nd Gen",
      @"iPod3,1":  @"iPod 3rd Gen",
      @"iPod4,1":  @"iPod 4th Gen",
      @"iPod5,1":  @"iPod 5th Gen",
      @"iPod7,1":  @"iPod 6th Gen",
      };
    
    NSString *deviceName = commonNamesDictionary[machineName];
    
    if (deviceName == nil) {
        deviceName = machineName;
    }
    
    return deviceName;
}

+ (BOOL) validateUrl: (NSString *) candidate {
    
    NSUInteger length = candidate.length;
    // Empty strings should return NO
    if (length > 0) {
        NSError *error = nil;
        NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
        if (dataDetector && !error) {
            NSRange range = NSMakeRange(0, length);
            NSRange notFoundRange = (NSRange){NSNotFound, 0};
            NSRange linkRange = [dataDetector rangeOfFirstMatchInString:candidate options:0 range:range];
            if (!NSEqualRanges(notFoundRange, linkRange) && NSEqualRanges(range, linkRange)) {
                return YES;
            }
        }
        else {
            NSLog(@"Could not create link data detector: %@ %@", [error localizedDescription], [error userInfo]);
        }
    }
    return NO;
}
+(NSString *)getLastString:(NSString *)string
{
    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:charSet];
    return components.lastObject;
}


@end
