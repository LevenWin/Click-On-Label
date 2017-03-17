//
//  LWLabel.m
//  LabelText
//
//  Created by 吴狄 on 16/9/5.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "LWLabel.h"
#define HELIGHT_COLOR  [UIColor lightGrayColor]

@interface LWLabel(){
    BOOL begin;
}
@property (nonatomic,retain)NSMutableArray *recArr;
@property (nonatomic,retain)NSTextContainer *textContainer;
@property (nonatomic,retain)NSLayoutManager *layoutManager;
@property (nonatomic,retain)NSTextStorage *textStorage;


@end
@implementation LWLabel
-(void)awakeFromNib{
    [self setup];
}
-(instancetype)init{
    if (self=[super init]) {
    [self setup];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
    [self setup];
    
    }
    
    return self;
}
-(void)setRangeArr:(NSMutableArray *)rangeArr{
    _rangeArr=rangeArr;
    _recArr=[NSMutableArray array];
    self.textContainer.size = self.bounds.size;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainer.maximumNumberOfLines = self.numberOfLines;
    self.textContainer.lineBreakMode = self.lineBreakMode;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange textRange = NSMakeRange(0, attributedText.length);
    [attributedText addAttribute:NSFontAttributeName value:self.font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = self.textAlignment;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    [self.textStorage setAttributedString:attributedText];
    
    for (NSString *str in rangeArr) {
        
//        NSRange glyphRange = [self.layoutManager glyphRangeForCharacterRange:characterRange actualCharacterRange:nil];
        NSRange glyphRange=NSRangeFromString(str);
        CGRect frame= [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
        [_recArr addObject:NSStringFromCGRect(frame)];
    }
}
-(void)setup{
    self.userInteractionEnabled=YES;
    self.textStorage = [NSTextStorage new];
    self.layoutManager = [NSLayoutManager new];
    self.textContainer = [NSTextContainer new];
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
}
-(void)processPoint:(CGPoint )point{
    if (!begin) {
        [self heightRange:NSMakeRange(0, self.text.length) yon:NO];
    }
    
    for (NSString *str in self.recArr) {
        CGRect frame=CGRectFromString(str);
        if ((frame.origin.y+frame.size.height>point.y&&frame.origin.y<point.y)&&(frame.origin.x+frame.size.width>point.x&&frame.origin.x<point.x)) {
            NSInteger index=[self.recArr indexOfObject:str];
            NSRange range=NSRangeFromString(self.rangeArr[index]);
            
            NSString *str=[self.text substringWithRange:range];
            if (begin) {
                [self heightRange:range yon:YES];
            }else{
                [self heightRange:range yon:NO];
                if (self.selectBlobk) {
                    self.selectBlobk(str,range);
                }

            }
            
            return;
            
        }
    }
    
    
}
-(void)heightRange:(NSRange )range yon:(BOOL)re{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = NSMakeRange(0, attributedText.length);
    [attributedText addAttribute:NSFontAttributeName value:self.font range:textRange];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = self.textAlignment;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
    if (re) {
      [attributedText addAttribute:NSBackgroundColorAttributeName value:HELIGHT_COLOR range:range];
    }else{
       
        
        [attributedText addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:range];

     
        
    }
   
    self.attributedText=attributedText;
}
#pragma  mark Touch Delegate
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    begin=YES;
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    [self processPoint:touchLocation];

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     begin=NO;
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    [self processPoint:touchLocation];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     CGPoint touchLocation = [[touches anyObject] locationInView:self];
     begin=NO;
    [self processPoint:touchLocation];

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    begin=YES;
//    CGPoint touchLocation = [[touches anyObject] locationInView:self];
//    [self processPoint:touchLocation];

}


@end
