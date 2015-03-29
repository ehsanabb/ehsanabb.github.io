function clear_controls(directory)
%directory = "prefs-data/";  % adjust this appropriately

prefs = load([directory "prefs.csv"]); 
users = load([directory "users.csv"]); 

% view the information on the current preferences
% for u = unique(prefs(:,1))', idx=find(prefs(:,1)==u); disp([u,size(prefs(idx,:)),sum(prefs(idx,4))]); end;

d = size(users,2); % last dimension

users_idx_to_remove = users(:,d)<4;  % users with at most 3 mistakes 
users_to_remove = users(users_idx_to_remove,1);

users(users_idx_to_remove,:) = [];       % remove useres with at at most 3 mistakes

prefs(ismember(prefs(:,1), users_to_remove),:) = [];         % and their preferences

prefs(prefs(:,4)==1,:) = [];         % remove all control control quesitons

prefs = prefs(:,1:3);                % we only need the first three dimensions

dlmwrite([directory "prefs_cleared.csv"], prefs); % write the results
dlmwrite([directory "users_cleared.csv"], users); 


return ;