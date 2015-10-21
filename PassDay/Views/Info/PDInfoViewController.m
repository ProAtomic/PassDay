//
//  PDInfoViewController.m
//  PassDay
//
//  Created by Guillermo Saenz on 1/21/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PDInfoViewController.h"

#import <Flurry.h>
#import <MessageUI/MessageUI.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIDevice-Hardware.h>

#import "UIApplication+Extras.h"

#define Debug 0

@interface PDInfoViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation PDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Flurry logEvent:NSStringFromClass(self.class)];
    
    [self.textView setText:NSLocalizedString(@"InfoText", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    ReallyDebug
    [super viewDidLayoutSubviews];
    
    [self.textView setContentOffset:CGPointZero];
}

- (IBAction)writeUs:(id)sender {
    ReallyDebug
    
    if (![MFMailComposeViewController canSendMail]) return;
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    // Email Subject
    NSArray *toRecipents = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"contacto@proatomicdev.com"], nil];
    
    [mc setMailComposeDelegate:self];
    [mc setSubject:[NSLocalizedString(@"Desde", nil) stringByAppendingString:@": PassDay"]];
    
    NSString *appVersionString = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Versión", nil), [UIApplication versionBuildNumber]];
    NSString *deviceString = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Dispositivo", nil), [[UIDevice currentDevice] modelName]];
    NSString *iOSString = [NSString stringWithFormat:@"iOS: %@", [[UIDevice currentDevice] systemVersion]];
    NSMutableString *connetionType = [NSMutableString stringWithFormat:@"%@: ", NSLocalizedString(@"Tipo de conexión", nil)];
    
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    NSString *currentConnectionType = telephonyInfo.currentRadioAccessTechnology;
    if ([currentConnectionType isEqualToString:CTRadioAccessTechnologyEdge]) {
        [connetionType appendString:@"Edge"];
    }else if ([currentConnectionType isEqualToString:CTRadioAccessTechnologyLTE]){
        [connetionType appendString:@"LTE"];
    }else if ([currentConnectionType isEqualToString:CTRadioAccessTechnologyWCDMA]){
        [connetionType appendString:@"CDMA"];
    }else{
        [connetionType appendString:@"WiFi"];
    }
    
    [mc setMessageBody:[NSString stringWithFormat:@"\n\n%@\n%@\n%@\n%@\n%@", NSLocalizedString(@"Especificaciones", nil), appVersionString, deviceString, iOSString, connetionType] isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    ReallyDebug
    
    switch (result) {
        case MFMailComposeResultCancelled:
            if (IfDebug) NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            if (IfDebug) NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            if (IfDebug) NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            if (IfDebug) NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
