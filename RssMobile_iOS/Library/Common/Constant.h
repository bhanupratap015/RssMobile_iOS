
#ifndef VagaApp_Constant_h
#define VagaApp_Constant_h

// IOS VERSION
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]
#define AppName @"Rss Mobile"

#define DATABASE_NAME @"  .sqlite"


// COLOR SCHEME
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.f)

#define colorBlueTheme RGB(22, 35, 74)
#define colorToolBarBG RGB(122, 206, 235)



// NSLOG CUSTOMS
#define aLogFunction()        NSLog(@"%s", __FUNCTION__)
#define aLog(...)             NSLog(@"%s: %@", __FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])


// UIImageView
#define aImg(img,...)    [UIImage imageNamed:((img), ##__VA_ARGS__)]


// ALERT VIEW
#define Alert(msg, ...)      [[[UIAlertView alloc] initWithTitle:AppName message:((msg), ##__VA_ARGS__) delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil] show]
#define AlertYesNo(msg, delegate)      [[[UIAlertView alloc] initWithTitle:AppName message:((msg), ##__VA_ARGS__) delegate:delegate cancelButtonTitle:NSLocalizedString(@"Yes", @"Yes") otherButtonTitles:NSLocalizedString(@"No", @"No"), nil] show]

// APP Delegate
#define AppDel ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// NSUserDefaults
#define UserDefaults    [NSUserDefaults standardUserDefaults]
#define USER_LOGIN_STATUS @"USER_LOGIN_STATUS"
#define USER_USER_DETAILS @"USER_USER_DETAILS"
#define USER_ID @"userid"
#define Password @"Password"
#define Customer_ID @"customerid"

#define Alert_Blank @"blank.png"
#define Alert_FreePremium @"pic18.png"
#define Alert_Premium @"pic31.png"
#define Alert_DeactivateAccount @"pic241.png"
#define Alert_WorldWebAddress @"pic9.png"
#define Alert_CameraTime @"pic18_1.png"
#define Alert_ShareUlockProfile @"pic21.png"
#define Alert_UnfollowByUser @"pic30.png"
#define Alert_OKonly @"AlertOK.png"




// TYPE ITEM SELECTIONS
typedef enum {
    K_EVENTS,
    K_VENUES,
    K_ARTICLES,
    K_PROMOTIONS
}Item_Type;

// PAYPAL SandBox Account
#define PaypalClient  @"IDAU7Uon0C8oO42LFFkLtiF02ZOwCFJD01K-BvqkSRv8J9I8RTRnUfS1ROYKKQA0lgkF9s7rDO8WcxQ9sn"
#define PaypalSecret @"EOk_AruTQx6h66hKH2DpMPT_XlDNZyM5gITod3DfBCyedbl2KE4WMs5MjLAa4oNl0xQEXOlgzhqPPSeR"


// GOOGLE API KEY
#define GoogleAPIKEY @"AIzaSyDdSbxiVD7R0a0aAFfiqfKhgeYfqbZVmC8"
#define RequestKEY @"AIzaSyB5FYCf_2ggQNqZLF7LlE_4LckVTd6PHuM"

#define BASE_API_URL @"https://maps.googleapis.com/maps/api/place"
#define TYPE_AUTOCOMPLETE @"/autocomplete"
#define COMPONENT @"country:in"
#define DIRECTION_API_BASE @"https://maps.googleapis.com/maps/api/directions"
#define OUTPUT @"/json"



#endif

