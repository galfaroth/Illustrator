//
//  ILUMenuButton.m
//  Illustrator
//
//  Created by Piotr Szwach on 5/28/14.
//  Copyright (c) 2014 Caps Off. All rights reserved.
//

#import "ILUMenuButtonController.h"

@interface ILUMenuButtonController (Private)


@end

@implementation ILUMenuButtonController

- (id)initWithView:(UIView *)parentView itemSize:(int)size buttonImageNames:(NSArray *)buttonImageNames hintStrings:(NSArray *)labelTexts mainButtonImage:(UIImage *)mainButtonImage collapsedMenuImage:(UIImage *)collapsedMenuImage isToolChooser:(BOOL)toolChooser foldsAfterClick:(BOOL)foldAfterClick buttonType:(ILUMenuButtonType)buttonType{
    self = [super init];
    if(self){
        self.view = parentView;
        self.toolSize = CGSizeMake(size, size);
        self.buttonImages = buttonImageNames;
        self.labelTexts = labelTexts;
        self.mainButtonImage = mainButtonImage;
        self.collapsedMenuImage = collapsedMenuImage;
        self.toolChooser = toolChooser;
        self.foldAfterClick = foldAfterClick;
        self.buttonType = buttonType;
        [self refreshType];
        [self initialize];
        [self refresh];
        [self updateMainButton];
        //[self prepareFold];
    }
    return self;
}
- (void)initialize{
    self.buttons = [NSMutableArray new];
    self.labels = [NSMutableArray new];
    
    self.mainButton = [UIButton new];
    [self.mainButton setBackgroundImage:self.mainButtonImage forState:UIControlStateNormal];
    self.mainButton.backgroundColor = [UIColor blackColor];
    [self.mainButton addTarget:self action:@selector(mainButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.mainButtonUnfold = [[UIImageView alloc] initWithImage:self.collapsedMenuImage];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollViewContentView = [UIView new];
    self.blackFrame = [UIView new];
    self.blackFrame.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.mainButton];
    [self.mainButton addSubview:self.mainButtonUnfold];
    [self.scrollView addSubview:self.scrollViewContentView];
    [self.scrollViewContentView addSubview:self.blackFrame];
    
    for(int i = 0; i < self.buttonImages.count; i++){
        int index = self.reversedIndex?self.buttonImages.count-i-1:i;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.toolSize.width*i*(self.isHorizontal), self.toolSize.height*i*(1-self.isHorizontal), self.toolSize.width, self.toolSize.height)];
        button.backgroundColor = [self colorForIndex:index maxIndex:self.buttonImages.count];
        [button setBackgroundImage:[UIImage imageNamed:[self.buttonImages objectAtIndex:index]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(subButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        [self.scrollViewContentView addSubview:button];
        
        if(index<self.labelTexts.count){
            NSString *text = [self.labelTexts objectAtIndex:index];
            if(text){
                float width = [self widthOfString:text withFont:[UIFont systemFontOfSize:17]];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 16, 30+width, 30)];
                label.text = text;
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
                label.layer.cornerRadius = 15;
                label.layer.masksToBounds = YES;
                label.alpha = 0;
                [self.labels addObject:label];
                [button addSubview:label];
            }
        }
    }
}
- (void)refreshType{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if(self.rotatedInterface)
        screenSize = CGSizeMake(screenSize.height, screenSize.width);
    BOOL widthBigger = screenSize.width < (2+self.buttonImages.count)*self.toolSize.width;
    BOOL heightBigger = screenSize.height < (2+self.buttonImages.count)*self.toolSize.height;

    switch (self.buttonType) {
        case ILUMenuButtonTypeTopLeft:
            self.unfoldOffset = CGPointMake(0,500);
            self.unfoldFrame = CGRectMake(0, self.toolSize.height, self.toolSize.width, self.toolSize.height);
            self.unfoldTransform = CGAffineTransformIdentity;
            self.blackViewFrame = CGRectMake(0, -500, self.toolSize.width, 500);
            self.scrollViewFrame = CGRectMake(0, self.toolSize.height, self.toolSize.width, heightBigger?screenSize.height-2*self.toolSize.height:self.toolSize.height*self.buttonImages.count);
            self.buttonAnchorPoint = CGPointZero;
            self.scrollViewContentViewFrame = CGRectMake(0, 0, self.toolSize.width, self.toolSize.height*self.buttonImages.count);
            self.isHorizontal = NO;
            self.reversedIndex = NO;
            break;
    case ILUMenuButtonTypeTopRight:
            self.unfoldOffset = CGPointMake(-500,0);
            self.unfoldFrame = CGRectMake(-self.toolSize.width, 0, self.toolSize.width, self.toolSize.height);
            self.unfoldTransform = CGAffineTransformMakeRotation(M_PI*90/180);
            self.blackViewFrame = CGRectMake(self.toolSize.width*self.buttonImages.count, 0, 500, self.toolSize.height);
            self.scrollViewFrame = CGRectMake(widthBigger?self.toolSize.width:screenSize.width-self.toolSize.width*(1+self.buttonImages.count), 0, widthBigger?screenSize.width-2*self.toolSize.width:self.toolSize.width*self.buttonImages.count, self.toolSize.height);
            self.buttonAnchorPoint = CGPointMake(1,0);
            self.scrollViewContentViewFrame = CGRectMake(0, 0, self.toolSize.width*self.buttonImages.count, self.toolSize.height);
            self.isHorizontal = YES;
            self.reversedIndex = YES;
            break;
        case ILUMenuButtonTypeBottomLeft:
            self.unfoldOffset = CGPointMake(500,0);
            self.unfoldFrame = CGRectMake(self.toolSize.width, 0, self.toolSize.width, self.toolSize.height);
            self.unfoldTransform = CGAffineTransformMakeRotation(M_PI*-90/180);
            self.blackViewFrame = CGRectMake(-500, 0, 500, self.toolSize.height);
            self.scrollViewFrame = CGRectMake(self.toolSize.width, screenSize.height-self.toolSize.height, widthBigger?screenSize.width-2*self.toolSize.width:self.toolSize.width*self.buttonImages.count, self.toolSize.height);
            self.buttonAnchorPoint = CGPointMake(0,1);
            self.scrollViewContentViewFrame = CGRectMake(0, 0, self.toolSize.width*self.buttonImages.count, self.toolSize.height);
            self.isHorizontal = YES;
            self.reversedIndex = NO;
            break;
        case ILUMenuButtonTypeBottomRight:
            self.unfoldOffset = CGPointMake(0,-500);
            self.unfoldFrame = CGRectMake(0, -self.toolSize.height, self.toolSize.width, self.toolSize.height);
            self.unfoldTransform = CGAffineTransformMakeRotation(M_PI*180/180);
            self.blackViewFrame = CGRectMake(0, self.toolSize.height*self.buttonImages.count, self.toolSize.width, 500);
            self.scrollViewFrame = CGRectMake(screenSize.width-self.toolSize.width, heightBigger?self.toolSize.height:screenSize.height-self.toolSize.height*(self.buttonImages.count+1), self.toolSize.width, heightBigger?screenSize.height-2*self.toolSize.height:self.toolSize.height*self.buttonImages.count);
            self.buttonAnchorPoint = CGPointMake(1,1);
            self.scrollViewContentViewFrame = CGRectMake(0, 0, self.toolSize.width, self.toolSize.height*self.buttonImages.count);
            self.isHorizontal = NO;
            self.reversedIndex = YES;
            break;
            
        default:
            break;
    }
    self.buttonAnchorPoint = CGPointMake(self.buttonAnchorPoint.x*(screenSize.width-self.toolSize.width), self.buttonAnchorPoint.y*(screenSize.height-self.toolSize.height));
}
- (void)prepareFold{
    self.scrollView.center = CGPointMake(self.scrollView.center.x-[self unfoldOffset].x, self.scrollView.center.y-[self unfoldOffset].y);
    self.scrollView.alpha = 0;
}
- (void)prepareUnfold{
    self.scrollView.center = CGPointMake(self.scrollView.center.x-[self unfoldOffset].x, self.scrollView.center.y+[self unfoldOffset].y);
    self.scrollView.alpha = 1;
}
- (void)refresh{
    [self refreshType];
    if(!self.unfolded)
        [self prepareUnfold];
    CGPoint buttonAnchorPoint = [self buttonAnchorPoint];
    self.mainButton.frame = CGRectMake(buttonAnchorPoint.x, buttonAnchorPoint.y, self.toolSize.width, self.toolSize.height);
    self.mainButtonUnfold.frame = [self unfoldFrame];
    self.mainButtonUnfold.transform = [self unfoldTransform];
    self.scrollView.frame = [self scrollViewFrame];
    self.scrollViewContentView.frame = self.scrollViewContentViewFrame;
    self.scrollView.contentSize = self.scrollViewContentView.frame.size;
    self.blackFrame.frame = self.blackViewFrame;
    if(!self.unfolded)
        [self prepareFold];
}
- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}
-(void)mainButtonClicked{
    if(self.unfolded)
        [self fold];
    else
        [self unfold];
}
-(void)updateMainButton{
    if(self.toolChooser){
        UIImage *image = [[self.buttons objectAtIndex:self.chosenTool] backgroundImageForState:UIControlStateNormal];
        [self.mainButton setBackgroundImage:image forState:UIControlStateNormal];
    }
}
-(void)subButtonClicked:(UIButton *)sender{
    int index = [self.buttons indexOfObject:sender];
    [self.delegate didSelectButton:index];
    _chosenTool = index;
    [self updateMainButton];
    if(self.foldAfterClick)
        [self fold];
}
-(void)fold{
    //NSLog(@"FOLD");
    _unfolded = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.scrollView.center = CGPointMake(self.scrollView.center.x-[self unfoldOffset].x, self.scrollView.center.y-[self unfoldOffset].y);
        self.scrollView.alpha = 0;
        self.mainButtonUnfold.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
-(void)unfold{
    //NSLog(@"UNFOLD");
    _unfolded = YES;
    
    [UIView animateWithDuration:.3 animations:^{
        self.scrollView.alpha = 1;
        self.scrollView.center = CGPointMake(self.scrollView.center.x+[self unfoldOffset].x, self.scrollView.center.y+[self unfoldOffset].y);
        self.mainButtonUnfold.alpha = 0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.3 animations:^{
            for(UILabel *label in self.labels){
                label.alpha = 1;
            }
        } completion:^(BOOL finished) {
            //todo: make one after the other go from the label right
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:.3 animations:^{
                    for(UILabel *label in self.labels){
                        label.alpha = 0;
                    }
                }];
            });
        }];
        
    }];
    if(self.toolChooser){
        for(UIButton *button in self.buttons){
            button.enabled = YES;
        }
        UIButton *selectedButton = [self.buttons objectAtIndex:self.chosenTool];
        selectedButton.enabled = NO;
    }
}
-(void)showHints{
    [UIView animateWithDuration:.3 animations:^{
        for(UILabel *label in self.labels){
            label.alpha = 1;
        }
    }];
}
-(void)hideHinds{
    [UIView animateWithDuration:.3 animations:^{
        for(UILabel *label in self.labels){
            label.alpha = 0;
        }
    }];
}
-(UIColor *)colorForIndex:(int)index maxIndex:(int)maxIndex{
    return [UIColor colorWithWhite:(((float)(1+index)/maxIndex)*.8) alpha:1];
}

@end
