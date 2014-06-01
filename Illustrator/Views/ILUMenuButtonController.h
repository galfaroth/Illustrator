//
//  ILUMenuButton.h
//  Illustrator
//
//  Created by Piotr Szwach on 5/28/14.
//  Copyright (c) 2014 Caps Off. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ILUMenuButtonDelegate <NSObject>

- (void)didSelectButton:(int)index;

@end

typedef enum : int {
    ILUMenuButtonTypeTopLeft = 1,
    ILUMenuButtonTypeTopRight,
    ILUMenuButtonTypeBottomLeft,
    ILUMenuButtonTypeBottomRight,
} ILUMenuButtonType;

@interface ILUMenuButtonController : NSObject

@property (nonatomic, assign) NSObject<ILUMenuButtonDelegate> *delegate;
@property (nonatomic, assign, readonly) BOOL unfolded;
@property (nonatomic, assign, readonly) int chosenTool;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, assign) CGSize toolSize;
@property (nonatomic, strong) NSArray *labelTexts;
@property (nonatomic, strong) NSArray *buttonImages;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;
@property (nonatomic, strong) UIView *blackFrame;
@property (nonatomic, strong) UIButton *mainButton;
@property (nonatomic, strong) UIImage *mainButtonImage;
@property (nonatomic, strong) UIImage *collapsedMenuImage;
@property (nonatomic, strong) UIImage *collapsedIcon;
@property (nonatomic, strong) UIImageView *mainButtonUnfold;
@property (nonatomic, assign) BOOL toolChooser;
@property (nonatomic, assign) BOOL foldAfterClick;
@property (nonatomic, assign) ILUMenuButtonType buttonType;

@property (nonatomic, assign) CGPoint buttonAnchorPoint;
@property (nonatomic, assign) CGRect scrollViewFrame;
@property (nonatomic, assign) CGRect scrollViewContentViewFrame;
@property (nonatomic, assign) CGRect blackViewFrame;
@property (nonatomic, assign) CGAffineTransform unfoldTransform;
@property (nonatomic, assign) CGRect unfoldFrame;
@property (nonatomic, assign) CGPoint unfoldOffset;
@property (nonatomic, assign) BOOL isHorizontal;
@property (nonatomic, assign) BOOL reversedIndex;

@property (nonatomic, assign) BOOL rotatedInterface;

- (id)initWithView:(UIView *)parentView itemSize:(int)size buttonImageNames:(NSArray *)buttonImageNames hintStrings:(NSArray *)labelTexts mainButtonImage:(UIImage *)mainButtonImage collapsedMenuImage:(UIImage *)collapsedMenuImage isToolChooser:(BOOL)toolChooser foldsAfterClick:(BOOL)foldAfterClick buttonType:(ILUMenuButtonType)buttonType;

- (void)showHints;
- (void)hideHinds;
- (void)fold;
- (void)unfold;
- (void)refresh;
@end
