%==========================================================================
% matNWM package
%   Load Route Link 
%
% input  :
%   frt    --- Route Link input file
%   Np     --- number of processors. If >0, then use
%   MaxLen 
%   Single_removed
% 
% output :
%
% Siqi Li, SMAST
% 2023-03-17
%
% Updates:
%
%==========================================================================
function rt = h_load_link(frt, varargin)

varargin = read_varargin(varargin, {'Np'}, {0});
varargin = read_varargin(varargin, {'MaxLen'}, {3200}); % The maximum length for NWM is 3174
varargin = read_varargin2(varargin, {'Single_removed'});

lon = ncread(frt, 'lon');
lat = ncread(frt, 'lat');
% from = ncread(frt, 'from');
to = ncread(frt, 'to');
order = ncread(frt, 'order');
link = ncread(frt, 'link');


% Find the head and mouth
head = find(~ismember(link, to));
mouth = find(to==0);

% Remove the single points
if Single_removed
    k = ismember(head, mouth);
    head(k) = [];
end

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
if Np > 0
    delete(gcp('nocreate'));
    distcomp.feature('LocalUseMpiexec', false);
    parpool(Np);
    parfor i = 1 : nhead
        iline = nan(1, MaxLen);
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
        x = lon(iline)';
        y = lat(iline)';
        rt(i).x = [x nan];
        rt(i).y = [y nan];
        rt(i).order = [order(iline)' nan];
        rt(i).head = iline(1);
        rt(i).mouth = iline(end);
        rt(i).bound_l = min(x);
        rt(i).bound_r = max(x);
        rt(i).bound_b = min(y);
        rt(i).bound_t = max(y);
        rt(i).n = length(x);
    end
    delete(gcp('nocreate'));
else
    for i = 1 : nhead
        if (mod(i,50000)==0)
            disp(['   --- ' num2str(i,'%7.7d') ' of ' num2str(nhead, '%7.7d') ' done.'])
        end
        iline = nan(1, MaxLen);
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
        x = lon(iline)';
        y = lat(iline)';
        rt(i).x = [x nan];
        rt(i).y = [y nan];
        rt(i).order = [order(iline)' nan];
        rt(i).head = iline(1);
        rt(i).mouth = iline(end);
        rt(i).bound_l = min(x);
        rt(i).bound_r = max(x);
        rt(i).bound_b = min(y);
        rt(i).bound_t = max(y);
        rt(i).n = length(x);
    end
end
tt = toc; disp(['h_load_link: Cost ' num2str(tt/60) ' min.'])

% if Single_removed
%     k = ([rt.n] > 1);
%     rt = rt(k);
% end