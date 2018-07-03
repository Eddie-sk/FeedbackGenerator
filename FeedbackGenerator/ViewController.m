//
//  ViewController.m
//  FeedbackGenerator
//
//  Created by sunkai on 2018/7/2.
//  Copyright © 2018年 kook. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, kMenuStatus) {
    kMenuStatusShow = 0,
    kMenuStatusWillShow,
    kMenuStatusHide,
    kMenuStatusWillHide,
};

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger generatorType;
    
    NSInteger _subsidiaryHeight;
    
    kMenuStatus _subsidiaryStatus;
}

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    generatorType = 0;
    _subsidiaryHeight = 60;
    _subsidiaryStatus = kMenuStatusHide;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addObserver];
}

#pragma mark - Observer

- (void)addObserver {
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
    UIPanGestureRecognizer *panGesture = self.tableView.panGestureRecognizer;
    [panGesture addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"state"]) {
        [self tableViewGestureStateChange:[change[NSKeyValueChangeNewKey] integerValue]];
    } else if ([keyPath isEqualToString:@"contentOffset"]) {
        [self tableViewContentOffsetChange:change];
    }
}

#pragma mark - TableView DataSource/Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)tableViewGestureStateChange:(UIGestureRecognizerState)state {
    
    if (state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    [self updateMenuView];
}

- (void)tableViewContentOffsetChange:(NSDictionary<NSKeyValueChangeKey,id> *)change {
    if (self.tableView.contentOffset.y > 0) {
        return;
    }
    if (self.tableView.panGestureRecognizer.state != UIGestureRecognizerStateBegan &&
        self.tableView.panGestureRecognizer.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    CGPoint newPoint = [change[NSKeyValueChangeNewKey] CGPointValue];
    
    
    BOOL needUpdateState = newPoint.y <= -_subsidiaryHeight;
    if (_subsidiaryStatus == kMenuStatusHide) {
        if (!needUpdateState) {
            return;
        }
        NSLog(@"kMenuStatusHide");
        _subsidiaryStatus = kMenuStatusWillShow;
        UIImpactFeedbackGenerator *impactFeedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactFeedback prepare];
        [impactFeedback impactOccurred];
    } else if (_subsidiaryStatus == kMenuStatusWillShow) {
        if (!needUpdateState) {
            _subsidiaryStatus = kMenuStatusWillHide;
        }
        NSLog(@"kMenuStatusWillShow");
    } else if (_subsidiaryStatus == kMenuStatusWillHide) {
        if (needUpdateState) {
            _subsidiaryStatus = kMenuStatusWillShow;
        }
        NSLog(@"kMenuStatusWillHide");
    } else if (_subsidiaryStatus == kMenuStatusShow) {
        CGPoint oldPoint = [change[NSKeyValueChangeOldKey] CGPointValue];
        
        if (newPoint.y > oldPoint.y) {
            _subsidiaryStatus = kMenuStatusWillHide;
        }
        NSLog(@"kMenuStatusShow");
    }
    
}

- (void)updateMenuView {
    if (_subsidiaryStatus == kMenuStatusWillHide) {
        _subsidiaryStatus = kMenuStatusHide;
        UIImpactFeedbackGenerator *impactFeedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
        [impactFeedback prepare];
        [impactFeedback impactOccurred];
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL finished) {
        }];
    } else if (_subsidiaryStatus == kMenuStatusWillShow) {
        _subsidiaryStatus = kMenuStatusShow;
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(self->_subsidiaryHeight, 0, 0, 0);
        } completion:nil];
    }
}

#pragma mark - event

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
