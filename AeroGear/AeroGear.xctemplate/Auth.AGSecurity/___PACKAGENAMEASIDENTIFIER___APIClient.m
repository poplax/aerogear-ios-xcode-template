//  ___PACKAGENAMEASIDENTIFIER___APIClient.m
//
//  Generated by the the JBoss AeroGear Xcode Project Template on ___DATE___.
//  See Project's web site for more details http://www.aerogear.org
//

#import "___PACKAGENAMEASIDENTIFIER___APIClient.h"

static NSString * const k___PACKAGENAMEASIDENTIFIER___APIBaseURLString = @"<# Service URL #>";

@implementation ___PACKAGENAMEASIDENTIFIER___APIClient

@synthesize pipe = _pipe;

+ (___PACKAGENAMEASIDENTIFIER___APIClient *)sharedInstance {
    static ___PACKAGENAMEASIDENTIFIER___APIClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)())success
                  failure:(void (^)(NSError *error))failure {

    NSURL *baseURL = [NSURL URLWithString:k___PACKAGENAMEASIDENTIFIER___APIBaseURLString];

    // create the Pipeline object 
    AGPipeline *pipeline = [AGPipeline pipelineWithBaseURL:baseURL];

    // create the Authenticator object
    AGAuthenticator *authenticator = [AGAuthenticator authenticator];

    // initialize authentication module with the correct 
    // authentication type, set on project creation
    id<AGAuthenticationModule> authModule = [authenticator auth:^(id<AGAuthConfig> config) {
        [config setName:@"authModule"]; // assign it a name
        [config setBaseURL:baseURL]; // the base url to authenticate to
        [config setType:@"AG_SECURITY"];
    }];

    // login to the service
    [authModule login:@{@"loginName": @"<# Username #>", @"password":@"<# Password #>"}
         success:^(id object) {
            // if successfully logged in, it is time to construct our pipes.
            // Note that we assign the authentication module we
            // created earlier, so every request can be properly
            // authenticated against the remote endpoints.
            _pipe = [pipeline pipe:^(id<AGPipeConfig> config) {
                [config setName:@"<# Endpoint Name #>"]; 
                [config setAuthModule:authModule];
            }];
            // ..add your own pipes here

            // inform client that we have successfully logged in
            success();

    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end