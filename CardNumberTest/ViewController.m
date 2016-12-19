//
//  ViewController.m
//  CardNumberTest
//
//  Created by JP on 16/10/24.
//  Copyright © 2016年 JP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
//    NSArray* bankName;
//    NSArray* bankBin;
    
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ViewController
- (IBAction)transfer:(id)sender {
    if(self.textField.text.length<=0 || self.textField.text.length<16 || self.textField.text.length>19) {
        return;
    }
    if ([self returnBankName:self.textField.text].length>0) {
        _resultLabel.text = [self returnBankName:self.textField.text];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
//    [self returnBankName:@"你的银行卡号"];
}

- (NSString *)returnBankName:(NSString*) idCard{
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
        _resultLabel.text = @"卡号不合法";
        return @"";
        
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];

    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else{
        _resultLabel.text = @"plist文件中不存在请自行添加对应卡种";
        return @"";
    }
    return @"";
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
        NSString *text = [self.textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }
        
        [self.textField setText:newString];
        
        return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
