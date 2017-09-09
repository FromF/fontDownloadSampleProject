//
//  ViewController.m
//  fontDownloadSample
//
//  Created by FromF on 2017/08/15.
//  Copyright © 2017年 FromF. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreText/CoreText.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sampleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *fontUrlLalbel;
@property (weak, nonatomic) IBOutlet UILabel *fontNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fontUrlLalbel.text = FONT_URL;
    self.fontNameLabel.text = FONT_POSTSCRIPT_NAME;
    self.statusLabel.text = @"NONE";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadButtonAction:(id)sender {
    NSURL* url = [NSURL URLWithString:FONT_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = request.timeoutInterval;
    configuration.timeoutIntervalForResource = request.timeoutInterval;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // ダウンロードしたデータを初期化します。
    __block NSData *resultData = nil;
    __block NSURLResponse *response = nil;
    __block NSError *error = nil;
    
    // ダウンロード完了待ちのセマフォにシグナル状態になるまで待ち続けます。
    dispatch_semaphore_t completion = dispatch_semaphore_create(0);
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData *sessionTaskData, NSURLResponse *sessionTaskResponse, NSError *sessionTaskError) {
        resultData = sessionTaskData;
        if (sessionTaskResponse) {
            // レスポンスデータが受け取れる場合は正常終了です。
            response = sessionTaskResponse;
        } else {
            // レスポンスデータが受け取れない場合は異常終了です。
            error = sessionTaskError;
        }
        dispatch_semaphore_signal(completion);
    }];
    // ダウンロードを開始します。
    [sessionTask resume];
    dispatch_semaphore_wait(completion, DISPATCH_TIME_FOREVER);
    [session invalidateAndCancel];
    
    if (error) {
        ERROR_LOG(@"[ERROR]%@-%@-%@-%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoverySuggestion],[error localizedRecoveryOptions]);
        self.statusLabel.text = @"Download Error";
    }
    if ([resultData length] > 0) {
        if ([self loadFontData:resultData]) {
            self.statusLabel.text = @"Sucess Register Font";
        } else {
            self.statusLabel.text = @"Cannot Register Font";
        }
    }
}
- (IBAction)applyButtonAction:(id)sender {
    self.sampleTextLabel.font = [UIFont fontWithName:FONT_POSTSCRIPT_NAME size:20.0f];
}

- (BOOL)loadFontData:(NSData *)fontData {
    BOOL result = true;
    CFErrorRef error;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        ERROR_LOG(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
        result = false;
    }
    CFRelease(font);
    CFRelease(provider);
    
    return result;
}

@end
