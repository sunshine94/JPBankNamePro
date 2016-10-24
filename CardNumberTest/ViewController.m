//
//  ViewController.m
//  CardNumberTest
//
//  Created by JP on 16/10/24.
//  Copyright © 2016年 JP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
//    NSArray* bankName;
//    NSArray* bankBin;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self returnBankName:@"你的银行卡号"];
}

- (NSString *)returnBankName:(NSString*) idCard{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankName = [resultDic objectForKey:@"bankName"];
    NSArray *bankBin = [resultDic objectForKey:@"bankBin"];
    
    int index = -1;
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
        
        return @"";
        
    }
    
    //6位Bin号
    
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    
    for (int i = 0; i < bankBin.count; i++) {
        
        if ([cardbin_6 isEqualToString:bankBin[i]]) {
            
            index = i;
            
        }
        
    }
    
    if (index != -1) {
        
        return bankName[index];
        
    }
    
    //8位Bin号
    
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    for (int i = 0; i < bankBin.count; i++) {
        
        if ([cardbin_8 isEqualToString:bankBin[i]]) {
            
            index = i;
            
        }
        
    }
    
    if (index != -1) {
        
        return bankName[index];
        
    }
    
    return @"";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
