function [C,k] = str2cell(str, delimiters, options)

% Option tells weather to keep leading whitespaces. 
% (Trailing whitespaces are always removed)
if ~exist('options','var')
    options = '';
end

if ~strcmpi(options, 'keepblanks')
    str = strtrim(str);
end
str = deblank(str);

if ~exist('delimiters','var') || isempty(delimiters)
    delimiters{1} = newline();
elseif ~iscell(delimiters)
    foo{1} = delimiters;
    delimiters = foo;
end

% Get indices of all the delimiters
k=[];
for kk=1:length(delimiters)
    k = [k, find(str==delimiters{kk})];
end
j = find(~ismember(1:length(str),k));

% Preallocate and trim (afterwards) to speed things up
C = repmat({blanks(max(diff([k,length(str)])))}, length(k)+1, 1);
ii=1; kk=1; 
while ii<=length(j)
    C{kk} = str(j(ii));
    ii=ii+1;
    jj=2;
    while (ii<=length(j)) && ((j(ii)-j(ii-1))==1)
        C{kk}(jj) = str(j(ii));
        jj=jj+1;
        ii=ii+1;        
    end
    C{kk}(jj:end)='';
    kk=kk+1;
end
C(kk:end) = [];

