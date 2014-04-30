//
//  MBViewController.m
//  TouchGestures
//
//  Created by Markus on 30.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBViewController.h"

@interface MBViewController ()
@property (weak, nonatomic) IBOutlet UIView *targetView;

@property(nonatomic, strong) NSArray *colors;
@property(nonatomic, assign) int colorIndex;


-(void)targetViewTapped:(id)sender;
-(void)targetViewDoubleTapped:(id)sender;
-(void)targetViewDragged:(UIPanGestureRecognizer*)sender;
-(void)targetViewRotated:(UIRotationGestureRecognizer*)sender;

@end

@implementation MBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.colors = @[ [UIColor yellowColor],
                     [UIColor greenColor],
                     [UIColor blueColor],
                     [UIColor redColor],
                     [UIColor purpleColor],
                     [UIColor orangeColor]];
    self.colorIndex = 0;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]            initWithTarget:self
                action:@selector(targetViewTapped:)];
    
    [self.targetView addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                    action:@selector(targetViewDoubleTapped:)];
    
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.targetView addGestureRecognizer:doubleTapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
            action:@selector(targetViewDragged:)];
    
    [self.targetView addGestureRecognizer:panGesture];
    
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(targetViewRotated:)];
    [self.view addGestureRecognizer:rotateGesture];
}

-(void)targetViewTapped:(UITapGestureRecognizer*)sender
{
    NSLog(@"-targetViewTapped:");
    
    if (++self.colorIndex >= self.colors.count) {
        self.colorIndex = 0;
    }
   
    sender.view.backgroundColor = self.colors[self.colorIndex];
}

-(void)targetViewDoubleTapped:(id)sender
{
    NSLog(@"-targetViewDoubleTapped:");
    
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.targetView.center = CGPointMake(self.targetView.center.x + 100, self.targetView.center.y + 100);
    } completion:NULL];
    
//    [UIView animateWithDuration:1.25
//                          delay:0.5
//                        options:UIViewAnimationOptionAutoreverse
//                     animations:^{
//        self.targetView.transform =
//                CGAffineTransformScale(self.targetView.transform, 2, 2);
//    } completion:^(BOOL finished) {
//        self.targetView.transform = CGAffineTransformIdentity;
//    }];
}

-(void)targetViewDragged:(UIPanGestureRecognizer*)sender
{
    CGPoint translation = [sender translationInView:self.view];
    
    NSLog(@"-targetViewDragged: tx=%f; ty=%f", translation.x, translation.y);
    
    sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                     sender.view.center.y + translation.y);
    [sender setTranslation:CGPointZero inView:self.view];
}

-(void)targetViewRotated:(UIRotationGestureRecognizer*)sender
{
    NSLog(@"-targetViewRotated: r=%f", sender.rotation);
    
    self.view.transform = CGAffineTransformRotate(
                        self.view.transform, sender.rotation);
    sender.rotation = 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
