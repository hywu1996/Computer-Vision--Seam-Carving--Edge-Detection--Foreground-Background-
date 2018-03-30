im = [];
im(:,:,1) =   [101   244   231   126   249;
                151   249   219     9    64;
                88    93    21   112   155;
                114    55    55   120   205;
                84   154    24   252    63];


im(:,:,2) =   [115   228   195    68   102;
                92    74   216    64   221;
                218   134   123    35   213;
                229    23   192   111   147;
                164   218    78   231   146];


im(:,:,3) =  [  91   201   137    85   182;
                225   102    91   122    60;
                85    46   139   162   241;
                101   252    31   100    69;
                158   198   196    26   239];


W = [-3 1 -3];
mask = [ -1 1 0 -1 0;...
         1 1 0 -1 1;...
         0 1 0 -1 -1;...
         1 1 0 -1 1;...
         -1 -1 0 1 0];
maskW = 10;

F = [1 3 0 -3 -1];
im4 = cat(3,im,mask);
eng = computeEng(im4,F,W,maskW)
% 
% eng =
% 
%   577.2127 -474.0578 -211.6035 -183.2227 -471.2210
%  -382.3976 -653.9937 -384.5538   12.8625  287.8903
%    66.4436 -143.5701   -3.5477 -480.0582 -578.8598
%    39.5649 -722.9933   94.4719 -420.0252 -159.3623
%   309.9671 -422.5076 -206.7120 -157.1606  111.4617

seam = [1 ;2 ;3; 4; 1];
imOut = removeSeamV(im4,seam)
% 
% 
% imOut(:,:,1) =
% 
%    244   231   126   249
%    151   219     9    64
%     88    93   112   155
%    114    55    55   205
%    154    24   252    63
% 
% 
% imOut(:,:,2) =
% 
%    228   195    68   102
%     92   216    64   221
%    218   134    35   213
%    229    23   192   147
%    218    78   231   146
% 
% 
% imOut(:,:,3) =
% 
%    201   137    85   182
%    225    91   122    60
%     85    46   162   241
%    101   252    31    69
%    198   196    26   239
% 
% 
% imOut(:,:,4) =
% 
%      1     0    -1     0
%      1     0    -1     1
%      0     1    -1    -1
%      1     1     0     1
%     -1     0     1     0

imOut = addSeamV(im4,seam)
% 
% 
% imOut(:,:,1) =
% 
%    101   101   244   231   126   249
%    151   249   249   219     9    64
%     88    93    21    21   112   155
%    114    55    55   120   120   205
%     84    84   154    24   252    63
% 
% 
% imOut(:,:,2) =
% 
%    115   115   228   195    68   102
%     92    74    74   216    64   221
%    218   134   123   123    35   213
%    229    23   192   111   111   147
%    164   164   218    78   231   146
% 
% 
% imOut(:,:,3) =
% 
%     91    91   201   137    85   182
%    225   102   102    91   122    60
%     85    46   139   139   162   241
%    101   252    31   100   100    69
%    158   158   198   196    26   239
% 
% 
% imOut(:,:,4) =
% 
%     -1    -1     1     0    -1     0
%      1     1     1     0    -1     1
%      0     1     0     0    -1    -1
%      1     1     0    -1    -1     1
%     -1    -1    -1     0     1     0

[M,P] = seamV_DP(eng)
% 
% 
% M =
% 
%    1.0e+03 *
% 
%     0.5772   -0.4741   -0.2116   -0.1832   -0.4712
%    -0.8565   -1.1281   -0.8586   -0.4584   -0.1833
%    -1.0616   -1.2716   -1.1316   -1.3387   -1.0372
%    -1.2321   -1.9946   -1.2442   -1.7587   -1.4980
%    -1.6846   -2.4171   -2.2013   -1.9159   -1.6472
% 
% 
% P =
% 
%     -1    -1    -1    -1    -1
%      2     2     2     5     5
%      2     2     2     3     4
%      2     2     4     4     4
%      2     2     2     4     4

[seam,c] = bestSeamV(M,P)

% 
% seam =
% 
%      2
%      2
%      2
%      2
%      2
% 
% 
% c =
% 
%   -2.4171e+03


[seam,im4Out,c] = reduceWidth(im4,eng)
% 
% 
% seam =
% 
%      2
%      2
%      2
%      2
%      2
% 
% 
% im4Out(:,:,1) =
% 
%    101   231   126   249
%    151   219     9    64
%     88    21   112   155
%    114    55   120   205
%     84    24   252    63
% 
% 
% im4Out(:,:,2) =
% 
%    115   195    68   102
%     92   216    64   221
%    218   123    35   213
%    229   192   111   147
%    164    78   231   146
% 
% 
% im4Out(:,:,3) =
% 
%     91   137    85   182
%    225    91   122    60
%     85   139   162   241
%    101    31   100    69
%    158   196    26   239
% 
% 
% im4Out(:,:,4) =
% 
%     -1     0    -1     0
%      1     0    -1     1
%      0     0    -1    -1
%      1     0    -1     1
%     -1     0     1     0
% 
% 
% c =
% 
%   -2.4171e+03


[seam,im4Out,c] = reduceHeight(im4,eng)
% 
% 
% seam =
% 
%      2
%      2
%      2
%      3
%      3
% 
% 
% im4Out(:,:,1) =
% 
%    101   244   231   126   249
%     88    93    21     9    64
%    114    55    55   120   205
%     84   154    24   252    63
% 
% 
% im4Out(:,:,2) =
% 
%    115   228   195    68   102
%    218   134   123    64   221
%    229    23   192   111   147
%    164   218    78   231   146
% 
% 
% im4Out(:,:,3) =
% 
%     91   201   137    85   182
%     85    46   139   122    60
%    101   252    31   100    69
%    158   198   196    26   239
% 
% 
% im4Out(:,:,4) =
% 
%     -1     1     0    -1     0
%      0     1     0    -1     1
%      1     1     0    -1     1
%     -1    -1     0     1     0
% 
% 
% c =
% 
%   -2.4799e+03

[seam,im4Out,c] = increaseWidth(im4,eng)
% 
% 
% seam =
% 
%      2
%      2
%      2
%      2
%      2
% 
% 
% im4Out(:,:,1) =
% 
%    101   244   244   231   126   249
%    151   249   249   219     9    64
%     88    93    93    21   112   155
%    114    55    55    55   120   205
%     84   154   154    24   252    63
% 
% 
% im4Out(:,:,2) =
% 
%    115   228   228   195    68   102
%     92    74    74   216    64   221
%    218   134   134   123    35   213
%    229    23    23   192   111   147
%    164   218   218    78   231   146
% 
% 
% im4Out(:,:,3) =
% 
%     91   201   201   137    85   182
%    225   102   102    91   122    60
%     85    46    46   139   162   241
%    101   252   252    31   100    69
%    158   198   198   196    26   239
% 
% 
% im4Out(:,:,4) =
% 
%     -1     1     1     0    -1     0
%      1     1     1     0    -1     1
%      0     1     1     0    -1    -1
%      1     1     1     0    -1     1
%     -1    -1    -1     0     1     0
% 
% 
% c =
% 
%   -2.4171e+03


[seam,im4Out,c] = increaseHeight(im4,eng)

% 
% 
% seam =
% 
%      2
%      2
%      2
%      3
%      3
% 
% 
% im4Out(:,:,1) =
% 
%    101   244   231   126   249
%    151   249   219     9    64
%    151   249   219   112   155
%     88    93    21   112   155
%    114    55    55   120   205
%     84   154    24   252    63
% 
% 
% im4Out(:,:,2) =
% 
%    115   228   195    68   102
%     92    74   216    64   221
%     92    74   216    35   213
%    218   134   123    35   213
%    229    23   192   111   147
%    164   218    78   231   146
% 
% 
% im4Out(:,:,3) =
% 
%     91   201   137    85   182
%    225   102    91   122    60
%    225   102    91   162   241
%     85    46   139   162   241
%    101   252    31   100    69
%    158   198   196    26   239
% 
% 
% im4Out(:,:,4) =
% 
%     -1     1     0    -1     0
%      1     1     0    -1     1
%      1     1     0    -1    -1
%      0     1     0    -1    -1
%      1     1     0    -1     1
%     -1    -1     0     1     0
% 
% 
% c =
% 
%   -2.4799e+03

[totalCost,imOut ] = intelligentResize(im,1,0,W,mask,maskW)


% 
% totalCost =
% 
%   -3.5462e+03
% 
% 
% imOut(:,:,1) =
% 
%    101   244   244   231   126   249
%    151   249   249   219     9    64
%     88    93    21    21   112   155
%    114    55    55    55   120   205
%     84   154   154    24   252    63
% 
% 
% imOut(:,:,2) =
% 
%    115   228   228   195    68   102
%     92    74    74   216    64   221
%    218   134   123   123    35   213
%    229    23    23   192   111   147
%    164   218   218    78   231   146
% 
% 
% imOut(:,:,3) =
% 
%     91   201   201   137    85   182
%    225   102   102    91   122    60
%     85    46   139   139   162   241
%    101   252   252    31   100    69
%    158   198   198   196    26   239

 [totalCost,imOut ] = intelligentResize(im,-1,0,W,mask,maskW)
%      
% 
% 
% totalCost =
% 
%   -3.5462e+03
% 
% 
% imOut(:,:,1) =
% 
%    101   231   126   249
%    151   219     9    64
%     88    93   112   155
%    114    55   120   205
%     84    24   252    63
% 
% 
% imOut(:,:,2) =
% 
%    115   195    68   102
%     92   216    64   221
%    218   134    35   213
%    229   192   111   147
%    164    78   231   146
% 
% 
% imOut(:,:,3) =
% 
%     91   137    85   182
%    225    91   122    60
%     85    46   162   241
%    101    31   100    69
%    158   196    26   239

[totalCost,imOut ] = intelligentResize(im,0,-1,W,mask,maskW)
%      
% 
% 
% totalCost =
% 
%   -4.0555e+03
% 
% 
% imOut(:,:,1) =
% 
%    101   249   219     9    64
%     88    93    21   112   155
%    114    55    55   120   205
%     84   154    24   252    63
% 
% 
% imOut(:,:,2) =
% 
%    115    74   216    64   221
%    218   134   123    35   213
%    229    23   192   111   147
%    164   218    78   231   146
% 
% 
% imOut(:,:,3) =
% 
%     91   102    91   122    60
%     85    46   139   162   241
%    101   252    31   100    69
%    158   198   196    26   239


[totalCost,imOut ] = intelligentResize(im,2,-2,W,mask,maskW)
%      1
% 
%      2
% 
%      3
% 
%      4
% 
% 
% totalCost =
% 
%   -1.2632e+04
% 
% 
% imOut(:,:,1) =
% 
%     88    93    21    21    21     9    64
%    114    55    55    55    55   120   205
%     84   154   154   154    24   252    63
% 
% 
% imOut(:,:,2) =
% 
%    218   134   123   123   123    64   221
%    229    23    23    23   192   111   147
%    164   218   218   218    78   231   146
% 
% 
% imOut(:,:,3) =
% 
%     85    46   139   139   139   122    60
%    101   252   252   252    31   100    69
%    158   198   198   198   196    26   239