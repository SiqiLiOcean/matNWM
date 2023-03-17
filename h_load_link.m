%==========================================================================
% matFVCOM package
% 
%
% input  :
% 
% output :
%
% Siqi Li, SMAST
% 2023-03-17
%
% Updates:
%
%==========================================================================
function rt = h_load_link(frt)


lon = ncread(frt, 'lon');
lat = ncread(frt, 'lat');
% from = ncread(frt, 'from');
to = ncread(frt, 'to');
order = ncread(frt, 'order');
link = ncread(frt, 'link');


% Find the head and mouth
head = find(~ismember(link, to));
mouth = find(to==0);

% Dimensions
n = length(to);
nhead = length(head);
nmouth = length(mouth);


% Convert Link to id in 'to'
to_id = knnsearch(double(link(:)), double(to(:)));
to_id(to==0) = 0;
% % % Add a fake element pointing to itself after the last id
% % to_id(n+1) = n + 1;
% % to_id(to==0) = n + 1;

% % % Calculate the joint points
% % [~, ia] = unique(to_id);
% % ib = setdiff(1:n, ia);
% % joint = unique(to_id(ib));
% % joint(joint==0) = [];



% Starting from head
tic
rt(nhead).link = [];
rt(nhead).x = [];
rt(nhead).y = [];
rt(nhead).order = [];
rt(nhead).head = [];
rt(nhead).mouth = [];
% delete(gcp('nocreate'));
% distcomp.feature('LocalUseMpiexec', false);
% parpool(4);
% parfor i = 1 : length(head)
maxLen = 3200; % The maximum length for NWM is 3174
for i = 1 : length(head)
    iline = nan(1, maxLen);
%     % Method 2
%     iline(1) = head(i);
%     for j = 2 : maxLen
%         iline(j) = to_id(iline(j-1));
%     end
%     iline(iline==n+1) = [];
    % Method 1
    j = 1;
    iline(j) = head(i);
    down = to_id(iline(j));
    while down>0
        j = j + 1;
        iline(j) = down;
        down = to_id(iline(j));
    end
    iline(j+1:end) = [];
    rt(i).link = iline;
    rt(i).x = [lon(iline)' nan];
    rt(i).y = [lat(iline)' nan];
    rt(i).order = [order(iline)' nan];
    rt(i).head = iline(1);
    rt(i).mouth = iline(end);
end
% delete(gcp('nocreate'));
tt = toc; disp(['h_load_link: Cost ' num2str(tt/60) ' min.'])

