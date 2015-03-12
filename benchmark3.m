function [hitrate,confmat,allres,alljs,alljfg]=benchmark3(mysystem,datadir);
%Benchmarking software obtained from Kalle Astrom.
%keyboard;
thispath = pwd;
nbr_correct = 0;
nbr_char = 0;
alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
alen = length(alfabet);
confmat = zeros(alen,alen);
% figure(1);
clf;
alljs = [];
alljfg = [];
allres = [];

a = dir(datadir);
for ii=1:length(a);
    [path,name,ext] = fileparts([datadir filesep a(ii).name]);
    if strcmp(ext,'.jpg'),
        % Found an image
        fname = name;
        
        % Read ground truth
        fid = fopen([datadir filesep fname '.txt'],'r');
        facit = fgetl(fid);
        fclose(fid);
        % Read ground truth segmentation
        gtdata = load([datadir filesep fname '.mat']);
        % Read image
        im = double((imread([datadir filesep fname ext])));
        
        %keyboard;
        % segment image
        S = feval(mysystem.segmenter,im);
        nrofsegments = length(S);
        
        % Calculate total foreground
        FG_system = zeros(size(im));
        for kk = 1:nrofsegments
            FG_system = FG_system | S{kk};
        end

        % Calculate total foreground
        FG_gt = zeros(size(im));
        for kk = 1:length(gtdata.S)
            FG_gt = FG_gt | gtdata.S{kk};
        end
        
        % calculate features
        clear f;
        for kk = 1:nrofsegments;
            f(:,kk)=feval(mysystem.features,S{kk});
        end
        
        % classify
        for kk = 1:nrofsegments;
            y(1,kk) = feval(mysystem.classifier,f(:,kk)',mysystem.classdata);
            guess(1,kk)=alfabet(y(1,kk));
        end
        
        if length(guess)<length(facit);
            guess = [guess 'A'*ones(1,length(facit)-length(guess))];
        end;
        
        %NN = min(length(gtdata.S),length(S));
        NN = min(length(facit),length(S));
%         figure(1); clf
        %subplot(2,NN,1);
        %colormap(gray);
        %imagesc(im);
        for kk = 1:NN,
%             subplot(2,NN,kk);
            tmp = S{kk};
            ii = find(sum(tmp));
            xmin = min(ii)-4;
            xmax = max(ii)+4;
%             imagesc(tmp(1:31,xmin:xmax))
%             title(['System: ' guess(kk)]);
        end
        for kk = 1:NN,
%             subplot(2,NN,NN+kk);
            tmp = gtdata.S{kk};
            ii = find(sum(tmp));
            xmin = min(ii)-4;
            xmax = max(ii)+4;
%             imagesc(tmp(1:31,xmin:xmax))
            %keyboard
%             title(['GT: ' facit(kk)]);
        end
        
        % Total segmentation error
        % Use Jaccard index
        jfg = sum(sum(FG_gt & FG_system)) / sum(sum(FG_gt | FG_system));
        
        % Individual segmentation error
        % Use Jaccard index
        js = zeros(1,length(facit));
        %for k = 1:min(length(S),length(gtdata.S)),
        for k = 1:min(length(S),length(facit)),
            js(k)= sum(sum(S{k} & gtdata.S{k} )) / sum(sum(S{k} | gtdata.S{k}));
        end
               
        %Individual interpretation error
        thisres = guess(1:length(facit))==facit;
        
        % Build up the confusion matrix
        for kkk = 1:length(facit);
            fi = find(alfabet==facit(kkk));
            gi = find(alfabet==guess(kkk));
            confmat(fi,gi)=confmat(fi,gi)+1;
        end;
        nbr_correct = nbr_correct+sum(thisres);
        nbr_char = nbr_char + length(facit);
        %keyboard
        alljs = [alljs;js];
        alljfg = [alljfg;jfg];
        allres = [allres;thisres];
%         pause(0.2);
    end,
end,

hitrate = nbr_correct/nbr_char;

cd(thispath);
