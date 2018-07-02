//
//  ViewController.m
//  FeedbackGenerator
//
//  Created by sunkai on 2018/7/2.
//  Copyright © 2018年 kook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSInteger generatorType;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    generatorType = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)prepare:(id)sender {
    generatorType ++;
    if (generatorType == 1) {
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc]init];
        [generator notificationOccurred:UINotificationFeedbackTypeSuccess];
        [generator prepare];
        NSLog(@"UINotificationFeedbackTypeSuccess");
    } else if (generatorType == 2) {
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator notificationOccurred:UINotificationFeedbackTypeWarning];
        [generator prepare];
        NSLog(@"UINotificationFeedbackTypeWarning");
    } else if (generatorType == 3) {
        UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc] init];
        [generator notificationOccurred:UINotificationFeedbackTypeError];
        [generator prepare];
        NSLog(@"UINotificationFeedbackTypeError");
    } else if (generatorType == 4) {
        UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
        [impactGenerator prepare];
        [impactGenerator impactOccurred];
        NSLog(@"UIImpactFeedbackStyleHeavy");
    } else if (generatorType == 5) {
        UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactGenerator prepare];
        [impactGenerator impactOccurred];
        NSLog(@"UIImpactFeedbackStyleLight");
    } else if (generatorType == 6) {
        UIImpactFeedbackGenerator *impactGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [impactGenerator prepare];
        [impactGenerator impactOccurred];
        NSLog(@"UIImpactFeedbackStyleMedium");
    } else if (generatorType == 7) {
        UISelectionFeedbackGenerator *selection = [[UISelectionFeedbackGenerator alloc] init];
        [selection prepare];
        NSLog(@"UISelectionFeedbackGenerator");
        generatorType = 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
