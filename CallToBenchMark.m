

mysystem.segmenter = 'im2segment';
mysystem.features = 'segment2features';
mysystem.classifier = 'features2class';
load classification_data;
mysystem.classdata = T;

t = cputime;
datadir = '/Users/asturkmani/Documents/MATLAB/Image Analysis/OCR/inl_ocr/datasets/short1';
[hitrate, confmat, allres, alljs, alljfg] = benchmark3(mysystem,datadir);
display('Hitrate on short1')
hitrate
t = cputime -t
t = cputime;
datadir = '/Users/asturkmani/Documents/MATLAB/Image Analysis/OCR/inl_ocr/datasets/short2';
[hitrate, confmat, allres, alljs, alljfg] = benchmark3(mysystem,datadir);
display('Hitrate on short2')
hitrate
t = cputime -t
t = cputime;
datadir = '/Users/asturkmani/Documents/MATLAB/Image Analysis/OCR/inl_ocr/datasets/home1';
[hitrate, confmat, allres, alljs, alljfg] = benchmark3(mysystem,datadir);
display('Hitrate on home1')
hitrate
t = cputime -t
t = cputime;
datadir = '/Users/asturkmani/Documents/MATLAB/Image Analysis/OCR/inl_ocr/datasets/home2';
[hitrate, confmat, allres, alljs, alljfg] = benchmark3(mysystem,datadir);
display('Hitrate on home2')
hitrate
t = cputime -t
t = cputime;
datadir = '/Users/asturkmani/Documents/MATLAB/Image Analysis/OCR/inl_ocr/datasets/home3';
[hitrate, confmat, allres, alljs, alljfg] = benchmark3(mysystem,datadir);
display('Hitrate on home3')
hitrate
t=cputime -t