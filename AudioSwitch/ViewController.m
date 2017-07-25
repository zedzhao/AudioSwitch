//
//  ViewController.m
//  AudioSwitch
//
//  Created by Kun on 15/05/2017.
//  Copyright © 2017 Kun. All rights reserved.
//

#import "ViewController.h"
@import CoreAudio;


@interface Model:NSObject

@property(nonatomic, strong) NSString *label;

@end

@implementation Model



@end

@interface ViewController()

@property (nonatomic, strong) NSString *now;
@property (nonatomic, strong) NSString *fullPath;
@property (nonatomic, assign) NSInteger interger;

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableIndexSet *set;
@end

@implementation ViewController

@synthesize arr;

- (void)viewDidLoad {
    [super viewDidLoad];

    UInt32 size;
    AudioDeviceID outputDevice;
    
//    AudioObjectPropertyAddress propertyAddress = {
//        kAudioHardwareServiceDeviceProperty_VirtualMasterVolume,
//        kAudioDevicePropertyScopeOutput,
//        kAudioObjectPropertyElementMaster
//    };
//
//    AudioHardwareServiceSetPropertyData([self.class defaultOutputDeviceID],
//                                        &propertyAddress,
//                                        0,
//                                        NULL,
//                                        sizeof(Float32),
//                                        &volume);
    
    AudioHardwareGetProperty(kAudioHardwarePropertyDefaultOutputDevice,
                             &size,
                             &outputDevice);
        // Do any additional setup after loading the view.
    AudioDeviceID theDevice = NewGetDefaultInputDevice();
    Float32 volumeScalar = NewGetVolumeScalar(theDevice, NO, 0);
    OSStatus changeVolumeStatus = NewSetVolumeScalar(theDevice, 0.5);
    NSLog(@"asdf");
    
    
    
}

OSStatus NewSetVolumeScalar(AudioDeviceID inDevice, Float32 scalar){
    
    AudioObjectPropertyAddress theAddress = {kAudioDevicePropertyVolumeScalar, kAudioDevicePropertyScopeOutput, 0};
    UInt32 theSize = sizeof(Float32);
    OSStatus theError = AudioObjectSetPropertyData(inDevice, &theAddress, 0, NULL, &theSize , &scalar);
    return theError;
}

Float32 NewGetVolumeScalar(AudioDeviceID inDevice, bool inIsInput, UInt32 inChannel)
{
    Float32 theAnswer = 0;
    UInt32 theSize = sizeof(Float32);
    AudioObjectPropertyScope theScope = inIsInput ? kAudioDevicePropertyScopeInput :
    kAudioDevicePropertyScopeOutput;
    AudioObjectPropertyAddress theAddress = { kAudioDevicePropertyVolumeScalar,
        theScope,
        inChannel };
    
    OSStatus theError = AudioObjectGetPropertyData(inDevice,
                                                   &theAddress,
                                                   0,
                                                   NULL,
                                                   &theSize,
                                                   &theAnswer);
    // handle errors
    
    return theAnswer;
}

AudioDeviceID NewGetDefaultInputDevice()
{
    AudioDeviceID theAnswer = 0;
    UInt32 theSize = sizeof(AudioDeviceID);
    AudioObjectPropertyAddress theAddress = { kAudioHardwarePropertyDefaultOutputDevice,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMaster };
    
    OSStatus theError = AudioObjectGetPropertyData(kAudioObjectSystemObject,
                                                   &theAddress,
                                                   0,
                                                   NULL,
                                                   &theSize,
                                                   &theAnswer);
    // handle errors
    
    return theAnswer;
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
