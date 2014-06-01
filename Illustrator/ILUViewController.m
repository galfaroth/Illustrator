//
//  ILUViewController.m
//  Illustrator
//
//  Created by Piotr Szwach on 5/28/14.
//  Copyright (c) 2014 Caps Off. All rights reserved.
//

#import "ILUViewController.h"

@interface ILUViewController ()

@end

@implementation ILUViewController

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    float buttonSize = 50;
    self.self.topRightMenuButtonController = [[ILUMenuButtonController alloc] initWithView:self.view itemSize:buttonSize buttonImageNames:@[@"button-01.png", @"button-02.png", @"button-03.png"] hintStrings:@[] mainButtonImage:[UIImage imageNamed:@"button-fold-top-left.png"] collapsedMenuImage:[UIImage imageNamed:@"button-unfold-top-left.png"] isToolChooser:NO foldsAfterClick:NO buttonType:ILUMenuButtonTypeTopRight];
    
    self.topLeftMenuButtonController = [[ILUMenuButtonController alloc] initWithView:self.view itemSize:buttonSize buttonImageNames:@[@"button-01.png", @"button-02.png", @"button-03.png", @"button-01.png", @"button-02.png", @"button-02.png", @"button-01.png", @"button-02.png", @"button-02.png"] hintStrings:@[@"Dupa", @"Cipa", @"Kox", @"Arrow", @"Tool", @"Dupka"] mainButtonImage:[UIImage imageNamed:@"button-fold-top-left.png"] collapsedMenuImage:[UIImage imageNamed:@"button-unfold-top-left.png"] isToolChooser:YES foldsAfterClick:YES buttonType:ILUMenuButtonTypeTopLeft];
    
    self.bottomLeftMenuButtonController = [[ILUMenuButtonController alloc] initWithView:self.view itemSize:buttonSize buttonImageNames:@[@"button-01.png", @"button-02.png", @"button-03.png", @"button-01.png", @"button-02.png", @"button-02.png", @"button-01.png", @"button-02.png", @"button-02.png"] hintStrings:@[] mainButtonImage:[UIImage imageNamed:@"button-fold-top-left.png"] collapsedMenuImage:[UIImage imageNamed:@"button-unfold-top-left.png"] isToolChooser:NO foldsAfterClick:NO buttonType:ILUMenuButtonTypeBottomLeft];
    
    self.bottomRightMenuButtonController = [[ILUMenuButtonController alloc] initWithView:self.view itemSize:buttonSize buttonImageNames:@[@"button-01.png", @"button-02.png", @"button-03.png", @"button-01.png", @"button-02.png", @"button-02.png", @"button-01.png", @"button-02.png", @"button-02.png"] hintStrings:@[] mainButtonImage:[UIImage imageNamed:@"button-fold-top-left.png"] collapsedMenuImage:[UIImage imageNamed:@"button-unfold-top-left.png"] isToolChooser:NO foldsAfterClick:NO buttonType:ILUMenuButtonTypeBottomRight];

}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.bottomLeftMenuButtonController.rotatedInterface = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    [self.bottomLeftMenuButtonController refresh];
    self.topRightMenuButtonController.rotatedInterface = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    [self.topRightMenuButtonController refresh];
    self.bottomRightMenuButtonController.rotatedInterface = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    [self.bottomRightMenuButtonController refresh];
    self.topLeftMenuButtonController.rotatedInterface = UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    [self.topLeftMenuButtonController refresh];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
