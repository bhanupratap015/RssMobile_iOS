//
//  ApiManager.m
//  Fisho
//
//  Created by Priyesh Das on 3/19/15.
//  Copyright (c) 2015 teks. All rights reserved.
//

#import "ApiManager.h"
#import <AFNetworking.h>
#import "Common.h"

#import "UIView+Toast.h"



@implementation ApiManager



NSString *baseURL = @"https://flashservers.me/index.php/api/";
NSString *baseAppURL = @"https://flashservers.me/index.php/api/appuser";

//NSString *baseURL = @"http://staging.teks.co.in/flashagram/index.php/api/";
//NSString *baseAppURL = @"http://staging.teks.co.in/flashagram/index.php/api/appuser";

//NSString *imgBaseURL =imagename @"http://staging.teks.co.in/flashagram/";

NSString *jsonURLLogin                      =@"login";
NSString *jsonURLEmailexistcheck            =@"emailexistcheck";
NSString *jsonURLLogout                     =@"logout";
NSString *jsonURLSignUp                     =@"register";
NSString *jsonURLReg                        =@"registration";
NSString *jsonURLForgetPass                 =@"forgetPassword";
NSString *jsonURLLoc                        =@"location";
NSString *jsonURLUser                       =@"user";
NSString *jsonURLUsers                      =@"users";
NSString *jsonURLEvent                      =@"event";
NSString *jsonURLsearchEvent                =@"searchEvent";
NSString *jsonURLInviteList                 =@"getInviteList";
NSString *jsonURLInvitePlayer               =@"addInviteUser";
NSString *jsonURLDeletePlayer               =@"deleteInviteListUser";
NSString *jsonURLAddEvent                   =@"addEvent";
NSString *jsonURLRespMessage                =@"message";
NSString *jsonURLRespError                  =@"error";
NSString *jsonURLUnregDev                   =@"unregisterDeviceFromPush";
NSString *jsonURLRegDevice                  =@"registerDeviceForPush";
NSString *jsonURLEditProfile                =@"editUserProfile";
NSString *jsonURLMyEvents                   =@"myCreatedEventList";
NSString *jsonURLEventsIAttend              =@"eventAttendingList";
NSString *jsonURLDeleteEvent                =@"deleteEvent";
NSString *jsonURLJoinEvent                  =@"joinEvent";
NSString *jsonURLGetNotSettings             =@"getNotificationSettings";
NSString *jsonURLEditNotSettings            =@"editNotificationSettings";
NSString *jsonURLContactUs                  =@"contactUs";
NSString *jsonURLDeactivateProfile          =@"deactivate_profile";
NSString *jsonURLUpdateProfile              =@"update_profile";
NSString *jsonURLGetProfile                 =@"get_profile";
NSString *jsonURLUpdateProfileImage         =@"update_profile_image";
NSString *jsonURLChangePassword             =@"changepassword";
NSString *jsonURLFollowingUser_list         =@"following_user_list";
NSString *jsonURLSearchKeyword              =@"searchuser";
NSString *jsonURLFollowing_user             =@"following_user";
NSString *jsonURLFollower_user_list         =@"follower_user_list";
NSString *jsonURLunFollowing_user           =@"unfollowing_user";
NSString *jsonURLFollowerPendingRequestListCount          =@"follower_pending_request_list_count";
NSString *jsonURLFollower_pending_request_list            =@"follower_pending_request_list";
NSString *jsonURLFollower_request_deny                    =@"follower_request_deny";
NSString *jsonURLFollower_request_accept                  =@"follower_request_accept";


NSString *jsonURLBlock_user                 =@"block_user";
NSString *jsonURLunBlock_user               =@"unblock_user";
NSString *jsonURLunlock_user                =@"unlock_user";
NSString *jsonURLFollowing_type             =@"following_type";
NSString *jsonURLUpdate_vibration           =@"update_vibration";
NSString *jsonURLUpdate_blinking            =@"update_blinking";
NSString *jsonURLImageShare                 =@"imageshare";
NSString *jsonURLGetUSerImageList           =@"get_user_image_list";
NSString *jsonURLUpload_image               =@"upload_image";
NSString *jsonURLUpdate_image               =@"update_image";
NSString *jsonURLUpload_image_title         =@"update_image_title";
NSString *jsonURLUser_total_followers       =@"user_total_followers";
NSString *jsonURLUserDeleteImage            =@"delete_images";

NSString *jsonURL_UsernameAvailablity       =@"username_availability";
NSString *jsonURL_GetAllUserList            =@"getAllUserList";



#pragma mark - Request API Call
#pragma mark -
+(void)requestApiCall:(NSDictionary *)params andUrl:(NSString *)urlPath withSuccess:(void (^) (AFHTTPRequestOperation *operation, id responseObject))success withFailure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = true;
    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
    
//    [manager.securityPolicy setAllowInvalidCertificates:YES];
//    [manager.securityPolicy setValidatesDomainName:NO];
    
//    NSDictionary *dictApiKey = [Common loadCustomObjectWithKey:jsonKeyapiKey];

    [manager POST:urlPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        operation.securityPolicy.allowInvalidCertificates = YES;
        //NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"\n\n\nresponse - %@",json);
        
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);

        
        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([[json valueForKey:@"msg"] isEqualToString:@"Session Expired ! "]) {
                APILog(@"\n\n\nresponse -  = %@",operation.responseString);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutNotif" object:nil];
//                [Common showToastMessage:@"Cannot authenticate with server" withTitle:@"" withAction:YES withMessageType:NO];
                
            }
        }
        
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(operation,nil);
    }];
    
    
}


# pragma mark - LogIn, Logout, Forgot Password, Check Email , Deactivate Profile
# pragma mark
+(void)userLogin:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    //email, username, password, contact, profileimage, timelineimage
    NSString *urlString= [NSString stringWithFormat:@"%@%@/%@",baseURL,jsonURLUser,jsonURLLogin];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    
    NSDictionary *parameters = @{@"logintype": [dictUserDetails valueForKey:keyUserLogintype],
                                 @"socialnetworkid" : isEmpty([dictUserDetails valueForKey:keyUserSocialNetworkID])?@"":[dictUserDetails valueForKey:keyUserSocialNetworkID],
                                 keyUserName        : [dictUserDetails valueForKey:keyUserName],
                                 @"deviceid"        : getDeviceID(),
                                 @"fullname"        : isEmpty([dictUserDetails valueForKey:keyUserFullName])?@"":[dictUserDetails valueForKey:keyUserFullName],
                                 keyUserPass        : isEmpty([dictUserDetails valueForKey:keyUserPass])?@"":[dictUserDetails valueForKey:keyUserPass],
                                 };
    
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if ([dictUserDetails valueForKey:keyUserImage]) {
            [formData appendPartWithFileData:[dictUserDetails valueForKey:keyUserImage] name:@"profileimage" fileName:@"profile.jpg" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        operation.securityPolicy.allowInvalidCertificates = YES;
//        APILog(@"\n\n\nresponse - %@",responseObject);
        if ([[responseObject valueForKey:jsonURLRespMessage] isEqualToString:@"success."]) {
            success(responseObject);
        }
        else {
            failure(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}
+(void)usercheckEmailExist:(NSString *)logintype socialnetworkid:(NSString *)socialnetworkid withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLEmailexistcheck];
    NSDictionary *parameters = @{@"logintype"                : logintype,
                                 @"socialnetworkid"          : socialnetworkid
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)forgotPassword:(NSString *)email withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    //email, username, password, contact, profileimage, timelineimage
    NSString *urlString= [NSString stringWithFormat:@"%@%@/%@",baseURL,jsonURLUser,jsonURLForgetPass];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

    NSDictionary *parameters = @{@"emailid"            : email

                                 };
    
    
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        APILog(@"\n\n\nresponse - %@",responseObject);
        //        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if ([[responseObject valueForKey:jsonURLRespMessage] isEqualToString:@"success"]) {
            success([responseObject valueForKey:@"data"]);
        }
        else {
            failure(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)userLogout:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@%@/%@",baseURL,jsonURLUser,jsonURLLogout];
    NSDictionary *parameters = @{@"userid"            : userid,
                                 @"deviceid"          : deviceID,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}
+(void)userDeacticeProfile:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLDeactivateProfile];
    NSDictionary *parameters = @{@"userid"            : userid,
                                 @"deviceid"          : deviceID,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];

}

#pragma mark - User  Follower List, Following List, Following User, unfollow User, Serach User]
#pragma mark -

+(void)userFollowerList :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollower_user_list];
    NSDictionary * parameter =@{@"user_1"   : getUserDefaults(keyUserID),
                                @"deviceid" : getDeviceID(),
                                @"activeuserid"     : getUserDefaults(keyUserID)
                                };
    
    [self requestApiCall:parameter andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //        APILog(@"response: %@", json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)userFollowingUser_list :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollowingUser_list];
    NSDictionary * parameter =@{@"user_1"   : getUserDefaults(keyUserID),
                                @"deviceid" : getDeviceID(),
                                @"activeuserid"     : getUserDefaults(keyUserID)
                                };
    
    [self requestApiCall:parameter andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"response: %@", json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}






+(void)userFollowingUser :(NSString *)userID UnlockedUserID:(NSString *)unlockedUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollowing_user];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : unlockedUserID,
                                 @"deviceid"        : getDeviceID(),
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];

}


+(void)userUnFollowingUser :(NSString *)userID FollowerId:(NSString *)followerId :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLunFollowing_user];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : followerId,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)searchUser:(NSString *)userid DeviceID:(NSString *)deviceID SearchKeyword:(NSString *)searchKeyword withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLSearchKeyword];
    NSDictionary *parameters = @{@"userid"            : userid,
                                 @"deviceid"          : deviceID,
                                 @"searchkeyword"     : searchKeyword,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}
# pragma mark - user Following Pending RequestList Count, list, Deny, Accept
# pragma mark

+(void)User_FollowerPendingRequestListCount :(NSString *)userID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollowerPendingRequestListCount];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"deviceid"        : getDeviceID()
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)User_FollowerPendingRequestList :(NSString *)userID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure     {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollower_pending_request_list];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"deviceid"        : getDeviceID(),
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}
+(void)User_FollowerRequestDeny :(NSString *)userID FollowerUserID:(NSString *)FollowerUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollower_request_deny];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : FollowerUserID
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}
+(void)User_FollowerRequestAccept :(NSString *)userID FollowerUserID:(NSString *)FollowerUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollower_request_accept];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : FollowerUserID,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

# pragma mark - User Follower Block, Unblock, unlock User,
# pragma mark

+(void)UserFollowerBlock :(NSString *)userID FollowerUserID:(NSString *)FollowerUserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLBlock_user];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : FollowerUserID,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}
+(void)UserFollowerUnBlock :(NSString *)userID unlockuserID:(NSString *)unlockuserID :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLunBlock_user];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : unlockuserID,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}


+(void)unLockUser:(NSString *)userid DeviceID:(NSString *)deviceID unlockuser:(NSString *)Unlockuser withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLunlock_user];
    NSDictionary *parameters = @{@"userid"            : userid,
                                 @"deviceid"          : deviceID,
                                 @"unlockuser"        : Unlockuser,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)userChangeFollowingType:(NSString *)userID FollowersUserID:(NSString *)followersUserID  Followerstype:(NSString  *)followerstype :(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLFollowing_type];
    NSDictionary *parameters = @{@"user_1"          : userID,
                                 @"user_2"          : followersUserID,
                                 @"followerstype"   : followerstype,
                                 @"activeuserid"     : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

# pragma mark - Get Profile, Update Profile, change password, update Profile image,
# pragma mark

+(void)getProfile:(NSString *)userID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLGetProfile];
    NSDictionary *parameters = @{keyUserID                  : userID,
                                 @"deviceid"                : getDeviceID(),
                                 @"activeuserid"            : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)user_total_followers:(NSString *)userid withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUser_total_followers];
    NSDictionary *parameters = @{@"userid"            : userid,
                                 @"activeuserid"      : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}
+(void)userUpdateProfile:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpdateProfile];
    NSDictionary *parameters = @{keyUserID                  : [dictUserDetails valueForKey:keyUserID],
                                 keyUserFullName            : [dictUserDetails valueForKey:keyUserFullName],
                                 keyUserName                : [dictUserDetails valueForKey:keyUserName],
                                 keyUserType                : [dictUserDetails valueForKey:keyUserType],
                                 @"deviceid"                : getDeviceID(),
                                 @"activeuserid"            : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)userChangePassword:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLChangePassword];
    NSDictionary *parameters = @{keyUserID                  : [dictUserDetails valueForKey:keyUserID],
                                 keyUserPass                : [dictUserDetails valueForKey:keyUserPass],
                                 @"activeuserid"            : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)userUpdateProfileImage:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpdateProfileImage];
    NSDictionary *parameters = @{keyUserID                  : [dictUserDetails valueForKey:keyUserID],
                                 @"action"                  : [dictUserDetails valueForKey:@"action"],
                                 @"deviceid"                : getDeviceID(),
                                 @"activeuserid"            : getUserDefaults(keyUserID)
                                 };
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:[dictUserDetails valueForKey:@"imageData"] name:@"profileimage" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        APILog(@"\n\n\nresponse - %@",strResponse);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if ([[json valueForKey:@"error"] intValue] == 0) {
            success(json);
        }
        else {
            failure(json);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
}

+(void)user_usernameExist:(NSString *)userId userName:(NSString *)username withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURL_UsernameAvailablity];
    NSDictionary *parameters = @{@"userid"            : userId,
                                 @"username"          : username,
                                 @"activeuserid"      : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}
+(void)user_getAllUser:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURL_GetAllUserList];
    NSDictionary *parameters = @{ };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        APILog(@"\n\n\nresponse - %@",json);

        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

# pragma mark - User Update Vibration & Blinking
# pragma mark

+(void)userUpdateVibration:(NSString *)userID deviceId:(NSString *)DeviceId  vibrationstatus:(NSString  *)Vibrationstatus vibrationstarttime:(NSString  *)vibrationstarttime vibrationendtime:(NSString  *)vibrationendtime :(void (^) (id result))success withFailure:(void (^) (NSError * error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpdate_vibration];
    NSDictionary *parameters = @{@"userid"              : userID,
                                 @"deviceid"            : DeviceId,
                                 @"vibrationstatus"     : Vibrationstatus,
                                 @"vibrationstarttime"  : vibrationstarttime,
                                 @"vibrationendtime"    : vibrationendtime
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)userUpdateBlinking:(NSString *)userID deviceId:(NSString *)DeviceId  Blinkingtatus:(NSString  *)Blinkingstatus Blinkingtarttime:(NSString  *)Blinkingstarttime Blinkingnendtime:(NSString  *)Blinkingendtime :(void (^) (id result))success withFailure:(void (^) (NSError * error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpdate_blinking];
    NSDictionary *parameters = @{@"userid"              : userID,
                                 @"deviceid"            : DeviceId,
                                 @"vibrationstatus"     : Blinkingstatus,
                                 @"vibrationstarttime"  : Blinkingstarttime,
                                 @"vibrationendtime"    : Blinkingendtime
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

# pragma mark - Gallery Image, Get ImageList, user upload Image, user update image title
# pragma mark

+(void)galleryImageShare:(NSDictionary *)dictDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLImageShare];
    NSDictionary *parameters = @{@"userid"              : [dictDetails objectForKey:keyUserID],
                                 @"imageid"             : [dictDetails objectForKey:keyUserImageId],
                                 @"socialnetworkid"     : [dictDetails objectForKey:keyUserSocialNetworkID],
                                 @"deviceid"            : [dictDetails objectForKey:keyUserDeviceId],
                                 @"activeuserid"        : getUserDefaults(keyUserID)
                                 };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        APILog(@"\n\n\nresponse - %@",json);
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)LoggeduserGetImageList:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLGetUSerImageList];
    NSDictionary *parameters = @{@"userid"            : getUserDefaults(keyUserID),
                                 @"deviceid"          : deviceID,
                                 @"activeuserid"      : getUserDefaults(keyUserID)
                                 };
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)userGetImageList:(NSString *)userid DeviceID:(NSString *)deviceID withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLGetUSerImageList];
    NSDictionary *parameters = @{@"userid"            : userid,
                                 @"deviceid"          : deviceID,
                                 @"activeuserid"      : getUserDefaults(keyUserID)
                                 };
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)userUploadImage:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure withProgress:(void (^) (float progress))progress{
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpload_image];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;

    
    NSDictionary *parameters = @{@"userid"          : [dictUserDetails valueForKey:keyUserID],
                                 @"deviceid"        : [dictUserDetails valueForKey:keyUserDeviceId],
                                 @"imagetype"       : [dictUserDetails valueForKey:keyUserImagetype],
                                 @"imagetitle"      : [dictUserDetails valueForKey:keyUserImagetitle],
                                 @"activeuserid"    : getUserDefaults(keyUserID)
                                 };
    
    
    AFHTTPRequestOperation * operation  = [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFileData:[dictUserDetails valueForKey:keyUserImagefullImage] name:keyUserImagefullImage fileName:@"fullimage.jpg" mimeType:@"image/jpeg"];
    
        [formData appendPartWithFileData:[dictUserDetails valueForKey:keyUserImagecrop_image] name:keyUserImagecrop_image fileName:@"crop_image.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject valueForKey:jsonURLRespMessage] isEqualToString:@"success"]) {
            success(responseObject);
        }
        else {
            failure(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                APILog(@"\n\n\nresponse -  = %@",operation.responseString);
                APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        double percentDone = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        //Upload Progress bar here
        NSLog(@"progress updated(percentDone) : %f", percentDone);
        progress(percentDone);
        
    }];
    
}

+(void)userUpdateImageTitle:(NSString *)userid DeviceID:(NSString *)deviceID imageID:(NSString *)imageID imageTitle:(NSString *)imageTitle withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure {
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpload_image_title];
    NSDictionary *parameters = @{@"userid"              : userid,
                                 @"deviceid"            : deviceID,
                                 @"imageid"             : imageID,
                                 @"imagetitle"          : isEmpty(imageTitle) ? @"" : imageTitle,
                                 @"activeuserid"        : getUserDefaults(keyUserID)
                                };
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}

+(void)userUpdateImage:(NSDictionary *)dictUserDetails withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure withProgress:(void (^) (float progress))progress{
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUpdate_image];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;

    
    NSDictionary *parameters = @{@"user_id"             : [dictUserDetails objectForKey:keyUserID],
                                 @"image_id"            : [dictUserDetails objectForKey:@"image_id"],
                                 @"imagetitle"          : [dictUserDetails objectForKey:keyUserImagetitle],                             @"activeuserid"     : getUserDefaults(keyUserID)
                                };

    
    AFHTTPRequestOperation * operation  = [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:[dictUserDetails valueForKey:keyUserImagecrop_image] name:keyUserImagecrop_image fileName:@"crop_image.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject valueForKey:jsonURLRespMessage] isEqualToString:@"success"]) {
            success(responseObject);
        }
        else {
            failure(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        double percentDone = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        //Upload Progress bar here
        NSLog(@"progress updated(percentDone) : %f", percentDone);
        progress(percentDone);
        
    }];
}

+(void)userUploadShareImage:(NSData *)imageData imageName:(NSString *)imageName withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure{

    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,@"getShareImageLink"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.png" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        APILog(@"\n\n\nresponse - %@",responseObject);
        if ([[responseObject valueForKey:jsonURLRespMessage] isEqualToString:@"success"]) {
            success(responseObject);
        }
        else {
            failure(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}


+(void)userRemoveImage:(NSString *)ImageId withSuccess:(void (^) (id result))success withFailure:(void (^) (NSError *error))failure
{
    
    NSString *urlString= [NSString stringWithFormat:@"%@/%@",baseAppURL,jsonURLUserDeleteImage];
    NSDictionary *parameters = @{@"id"            : ImageId  };
    
    [self requestApiCall:parameters andUrl:urlString withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        APILog(@"\n\n\nresponse - %@",responseObject);
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        success(json);
    } withFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        APILog(@"\n\n\nresponse -  = %@",operation.responseString);
        APILog(@"\n\n\nresponse description - %@",error.description);
        failure(error);
    }];
}



@end
