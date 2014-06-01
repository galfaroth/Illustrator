//
//  ILUViewController.h
//  Illustrator
//
//  Created by Piotr Szwach on 5/28/14.
//  Copyright (c) 2014 Caps Off. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILUMenuButtonController.h"

@interface ILUViewController : UIViewController

@property (nonatomic, strong) ILUMenuButtonController *topLeftMenuButtonController;
@property (nonatomic, strong) ILUMenuButtonController *topRightMenuButtonController;
@property (nonatomic, strong) ILUMenuButtonController *bottomLeftMenuButtonController;
@property (nonatomic, strong) ILUMenuButtonController *bottomRightMenuButtonController;
@end
