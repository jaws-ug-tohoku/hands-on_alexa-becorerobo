#!/bin/bash
bcoreMac=$1
motion=$2

function light (){
gatttool -b $bcoreMac --char-write -a 0x001f -n 80800380808080
}

function wink (){
num=`expr $RANDOM % 2 + 1`
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800380808080 ;sleepenh 2
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800${num}80808080 ;sleepenh 1
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800380808080
}

function walk (){
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800080808080 ;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800080868C80;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000808C9980;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008092A580;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008099B280;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000809FBE80;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800080A5CB80;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800080ABD780;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800079ACD279;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800073ADCE73;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080006DAEC96D;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800067AEC467;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800060AFC060;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080005AB0BB5A;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800054B1B654;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800053ABAF53;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800052A4A952;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000519EA251;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800051989B51;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800050929450;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F8C8D4F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E86864E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E787F4E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E6B784E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E5E714E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E516A4E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E43634E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E365C4E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004E29554E;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080005B2D545B;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800067325367;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800073375273;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000803B5180;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008C40508C;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800099444F99;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A5494EA5;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A75055A7;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A8575BA8;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AA5D61AA;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AB6467AB;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AD6B6DAD;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AE7273AE;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B07979B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B07979B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B08087B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B08794B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B08EA1B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B095AEB0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B09CBCB0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B0A3C9B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B0AAD6B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A4ABD2A4;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800097ACCD97;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008BADC88B;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080007FAEC47F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800072AFBF72;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800066B0BB66;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080005AB1B65A;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800058AAAF58;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800057A4A857;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000559EA255;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800054989B54;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800052929452;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000518C8D51;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F86864F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F86864F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F787F4F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F6B784F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F5E714F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F516A4F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F43634F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F365C4F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F29554F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080005B2D545B;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800068325368;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800074375274;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000803B5180;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008D40508D;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800099444F99;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A5494EA5;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A75055A7;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A8575BA8;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AA5D61AA;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AB6467AB;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AD6B6DAD;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000AE7273AE;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B07979B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B07979B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B08087B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B08794B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B08EA1B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B095AEB0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B09CBCB0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B0A3C9B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000B0AAD6B0;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000A4ABD2A4;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800097ACCD97;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008BADC88B;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080007FAEC47F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800072AFBF72;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800066B0BB66;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080005AB1B65A;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800058AAAF58;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800057A4A857;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000559EA255;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800054989B54;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800052929452;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000518C8D51;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080004F86864F;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000809FBE80;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008099B280;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 8080008092A580;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 808000808C9980;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800080868C80;sleepenh 0.05
gatttool -b $bcoreMac  --char-write -a 0x001f -n 80800080808080 ;sleepenh 0.05
}

$motion
