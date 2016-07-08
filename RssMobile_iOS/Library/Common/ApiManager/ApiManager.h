//
//  ApiManager.h
//  Fisho
//
//  Created by Priyesh Das on 3/19/15.
//  Copyright (c) 2015 teks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

extern NSString *imgBaseURL;

# pragma mark
# pragma mark - user

+(void)userLogin:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)usercheckEmailExist:(NSString *)logintype socialnetworkid:(NSString *)socialnetworkid withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;

+(void)forgotPassword:(NSString *)email withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userLogout:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userDeacticeProfile:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;

+(void)userFollowingUser_list :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;

+(void)searchUser:(NSString *)userid DeviceID:(NSString *)deviceID SearchKeyword:(NSString *)searchKeyword withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;
+(void)userFollowingUser :(NSString *)userID UnlockedUserID:(NSString *)unlockedUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userFollowerList :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userUnFollowingUser :(NSString *)userID FollowerId:(NSString *)followerId :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)User_FollowerPendingRequestListCount :(NSString *)userID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)User_FollowerPendingRequestList :(NSString *)userID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)User_FollowerRequestAccept :(NSString *)userID FollowerUserID:(NSString *)FollowerUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)User_FollowerRequestDeny :(NSString *)userID FollowerUserID:(NSString *)FollowerUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;


+(void)getProfile:(NSString *)userID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)user_total_followers:(NSString *)userid withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;

+(void)UserFollowerBlock :(NSString *)userID FollowerUserID:(NSString *)FollowerUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)UserFollowerUnBlock :(NSString *)userID unlockuserID:(NSString *)unlockuserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)unLockUser:(NSString *)userid DeviceID:(NSString *)deviceID unlockuser:(NSString *)Unlockuser withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;
+(void)userChangeFollowingType:(NSString *)userID FollowersUserID:(NSString *)followersUserID  Followerstype:(NSString  *)followerstype :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;

+(void)userUpdateVibration:(NSString *)userID deviceId:(NSString *)DeviceId  vibrationstatus:(NSString  *)Vibrationstatus vibrationstarttime:(NSString  *)vibrationstarttime vibrationendtime:(NSString  *)vibrationendtime :(void (^) (id result))success withFailure:(void (^) (NSError * error))failure ;
+(void)userUpdateBlinking:(NSString *)userID deviceId:(NSString *)DeviceId  Blinkingtatus:(NSString  *)Blinkingstatus Blinkingtarttime:(NSString  *)Blinkingstarttime Blinkingnendtime:(NSString  *)Blinkingendtime :(void (^) (id result))success withFailure:(void (^) (NSError * error))failure ;


+(void)userChangePassword:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userUpdateProfileImage:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userUpdateProfile:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)user_usernameExist:(NSString *)userId userName:(NSString *)username withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)user_getAllUser:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;


+(void)galleryImageShare:(NSDictionary *)dictDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)LoggeduserGetImageList:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;
+(void)userGetImageList:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure ;
+(void)userRemoveImage:(NSString *)ImageId withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;


+(void)userUploadImage:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure withProgress:(void (^) (float progress))progress;
+(void)userUpdateImageTitle:(NSString *)userid DeviceID:(NSString *)deviceID imageID:(NSString *)imageID imageTitle:(NSString *)imageTitle withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;
+(void)userUpdateImage:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure withProgress:(void (^) (float progress))progress;




+(void)userUploadShareImage:(NSData *)imageData imageName:(NSString *)imageName withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure;

@end

