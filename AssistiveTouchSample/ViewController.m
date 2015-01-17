//
//  ViewController.m
//  AssistiveTouchSample
//
//  Created by Andrew Murdoch on 1/17/15.
//  Copyright (c) 2015 Andrew Murdoch. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Helper.h"
#import "PopoverTransition.h"

//String for Saving Location
static NSString *const kMenuButtonRect = @"MenuButtonRect";

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton *menuButton;
@property (nonatomic, strong) PopoverTransition *transition;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _transition = [[PopoverTransition alloc] init];
    
    //Check for location of previous spot.
    [self checkForLastSavedLocation];
}

- (void)checkForLastSavedLocation
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kMenuButtonRect];
    NSValue *point = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (point)
    {
        CGRect frame = _menuButton.frame;
        frame.origin = [point CGPointValue];
        _menuButton.frame = frame;
    }
}

- (IBAction)menuButtonDidPan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [recognizer.view snapViewToEdge:^{
            
            //Save Location for user.
            NSValue *value = [NSValue valueWithCGPoint:_menuButton.frame.origin];
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:kMenuButtonRect];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *toVC = [segue destinationViewController];
    toVC.modalPresentationStyle = UIModalPresentationCustom;
    toVC.transitioningDelegate = _transition;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
