function groupdata = groupanalysis

% Function that analyzes the individual participant files for the data
% reported in Kool, Wang, McGuire & Botvinick (2013). The individual data
% can be found in the data directory.
% 
% USAGE: groupdata = groupanalysis.
% 
% FIELDS:
%   .dstChoiceRateTotal: [50x1] array with participants' average low-demand
%       choice rate in the Demand Selection Task (DST)
%   .dstChoiceRateBlock: [50x8] matrix with participants average low-demand
%       choice rate for each block of the DST
%   .choiceWithinBlock: [50x75] matrix with participants average low-demand
%       choice rate across trials within the blocks of the DST
%   .itcImmediateProp: [50x1] array with the participants' proportion of
%       smaller/sooner choices in the Intertemporal Choice Task
%   .selfControlScale: [50x1] array with ecah participants' score on the
%       Self-Control Scale (Tangney et al., 2004)
%
% NOTES:
%
%   1. The main results of Kool et al. (2013) can be replicated using the
%   following commands:
%
%    a. [r,p] = corr(groupdata.dstChoiceRateTotal,groupdata.itcImmediateProp)
%    b. [r,p] = corr(groupdata.dstChoiceRateTotal,groupdata.selfControlScale)
%    c. [r,p] = corr(groupdata.itcImmediateProp,groupdata.selfControlScale)
%
% Wouter Kool, Aug 2016 (originally analyzed in 2012/2013)

DSTnames = { 'data/decksHome_data_s01_GW111511_a_1.mat'
'data/decksHome_data_s02_GW111811_a_1.mat'
'data/decksHome_data_s03_GW111811_b_1.mat'
'data/decksHome_data_s04_GW111811_c_1.mat'
'data/decksHome_data_s05_GW111811_d_1.mat'
'data/decksHome_data_s06_GW111811_e_1.mat'
'data/decksHome_data_s07_GW112911_a_1.mat'
'data/decksHome_data_s08_GW112911_b_1.mat'
'data/decksHome_data_s09_GW112911_c_1.mat'
'data/decksHome_data_s10_GW120811_a_1.mat'
'data/decksHome_data_s11_GW120811_b_1.mat'
'data/decksHome_data_s12_GW120811_c_1.mat'
'data/decksHome_data_s13_GW120911_a_1.mat'
'data/decksHome_data_s14_GW120911_c_1.mat'
'data/decksHome_data_s15_GW120911_d_1.mat'
'data/decksHome_data_s16_gw121111_a_1.mat'
'data/decksHome_data_s17_GW121111_b_1.mat'
'data/decksHome_data_s18_GW121611_a_1.mat'
'data/decksHome_data_s19_GW121611_b_1.mat'
'data/decksHome_data_s20_GW02032012_a_1.mat'
'data/decksHome_data_s21_GW02032012_b_1.mat'
'data/decksHome_data_s22_GW02032012_c_1.mat'
'data/decksHome_data_s23_GW02032012_d_1.mat'
'data/decksHome_data_s24_GW02032012_e_1.mat'
'data/decksHome_data_s25_Gw02032012_f_1.mat'
'data/decksHome_data_s26_GW02072012_a_1.mat'
'data/decksHome_data_s27_GW02072012_b_1.mat'
'data/decksHome_data_s28_GW02092012_a_1.mat'
'data/decksHome_data_s29_GW02092012_b_1.mat'
'data/decksHome_data_s30_GW02092012_c_1.mat'
'data/decksHome_data_s31_GW02102012_a_1.mat'
'data/decksHome_data_s32_GW02102012_b_1.mat'
'data/decksHome_data_s33_GW02272012_a_1.mat'
'data/decksHome_data_s34_GW02272012_b_1.mat'
'data/decksHome_data_s35_GW02282012_a_1.mat'
'data/decksHome_data_s36_GW03012012_a_1.mat'
'data/decksHome_data_s37_GW03012012_b_1.mat'
'data/decksHome_data_s38_GW03022012_a_1.mat'
'data/decksHome_data_s39_GW03022012_b_1.mat'
'data/decksHome_data_s40_GW03022012_c_1.mat'
'data/decksHome_data_s41_GW03022012_d_1.mat'
'data/decksHome_data_s42_GW03022012_e_1.mat'
'data/decksHome_data_s43_GW03062012_a_1.mat'
'data/decksHome_data_s44_GW03062012_b_1.mat'
'data/decksHome_data_s45_GW03062012_c_1.mat'
'data/decksHome_data_s46_GW03062012_d_1.mat'
'data/decksHome_data_s47_GW03082012_a_1.mat'
'data/decksHome_data_s48_GW03082012_b_1.mat'
'data/decksHome_data_s49_GW03092012_a_1.mat'
'data/decksHome_data_s50_GW03092012_b_1.mat'};


 ITCnames = { 'data/DemandITC_1_GW111511_a.mat'
'data/DemandITC_2_GW111811_a.mat'
'data/DemandITC_3_GW111811_b.mat'
'data/DemandITC_4_GW111811_c.mat'
'data/DemandITC_5_GW111811_d.mat'
'data/DemandITC_6_GW111811_e.mat'
'data/DemandITC_7_GW112911_a.mat'
'data/DemandITC_8_GW112911_b.mat'
'data/DemandITC_9_GW112911_c.mat'
'data/DemandITC_10_GW120811_a.mat'
'data/DemandITC_11_GW120811_b.mat'
'data/DemandITC_12_GW120811_c.mat'
'data/DemandITC_13_GW120911_a.mat'
'data/DemandITC_14_GW120911_c.mat'
'data/DemandITC_15_GW120911_d.mat'
'data/DemandITC_16_GW121111_a.mat'
'data/DemandITC_17_GW121111_b.mat'
'data/DemandITC_18_GW121611_a.mat'
'data/DemandITC_19_GW121611_b.mat'
'data/DemandITC_20_GW02032012_a.mat'
'data/DemandITC_21_GW02032012_b.mat'
'data/DemandITC_22_GW02032012_c.mat'
'data/DemandITC_23_GW02032012_d.mat'
'data/DemandITC_24_GW02032012_e.mat'
'data/DemandITC_25_GW02032012_f.mat'
'data/DemandITC_26_GW02072012_a.mat'
'data/DemandITC_27_GW02072012_b.mat'
'data/DemandITC_28_GW02092012_a.mat'
'data/DemandITC_29_GW02092012_b.mat'
'data/DemandITC_30_GW02092012_c.mat'
'data/DemandITC_31_GW02102012_a.mat'
'data/DemandITC_32_GW02102012_b.mat'
'data/DemandITC_33_GW02272012_a.mat'
'data/DemandITC_34_GW03012012_b.mat'
'data/DemandITC_35_GW02282012_a.mat'
'data/DemandITC_36_GW02272012_b.mat'
'data/DemandITC_37_GW03012012_a.mat'
'data/DemandITC_38_GW03022012_a.mat'
'data/DemandITC_39_GW03022012_b.mat'
'data/DemandITC_40_GW03022012_c.mat'
'data/DemandITC_41_GW03022012_d.mat'
'data/DemandITC_42_GW03022012_e.mat'
'data/DemandITC_43_GW03062012_a.mat'
'data/DemandITC_44_GW03062012_b.mat'
'data/DemandITC_45_GW03062012_c.mat'
'data/DemandITC_46_GW03062012_d.mat'
'data/DemandITC_47_GW03082012_a.mat'
'data/DemandITC_48_GW03082012_b.mat'
'data/DemandITC_49_GW03092012_a.mat'
'data/DemandITC_50_GW03092012_b.mat'};

nrsubs = length(ITCnames);

nrBlocks = 8;
nrTrials = 600;

for s = 1:nrsubs
    
    %% demand selection task
    
    load(DSTnames{s});
    
    groupdata.dstChoiceRateTotal(s,1) = mean(data.choice==1);
    
    withinBlock = zeros(nrBlocks,nrTrials/nrBlocks);
    
    for b = 1:nrBlocks
        blockChoice = data.choice(data.runNumber==b);
        groupdata.dstChoiceRateBlock(s,b) = mean(blockChoice==1);
        withinBlock(b,:) = blockChoice;
    end
    
    groupdata.choiceWithinBlock(s,:) = mean(withinBlock==1);
    
    %% intertemporal choice task
    
    load(ITCnames{s});
    
    groupdata.itcImmediateProp(s,1) = mean(data.immediateOptionChosen);    
    
end

%% self control scale

groupdata.selfControlScale = csvread('data/selfcontrolscale.csv');

end
