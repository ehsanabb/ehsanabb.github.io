function clear_controls(preference_file, user_file, limit)
%% preference_file: path to the preference file (with no headers)
%% user_file: path to the users file (with no headers)
%% limit: maximum number of mistakes allowed 

prefs = load(preference_file); 
users = load(user_file); 

% view the information on the current preferences
% for u = unique(prefs(:,1))', idx=find(prefs(:,1)==u); disp([u,size(prefs(idx,:)),sum(prefs(idx,4))]); end;

d = size(users,2); % last dimension

% users with at most "limit" mistakes 
users_idx_to_remove = users(:,d)<limit;  
users_to_remove = users(users_idx_to_remove,1);

% remove useres with at at most "limit" mistakes
users(users_idx_to_remove,:) = [];      

% and their preferences
prefs(ismember(prefs(:,1), users_to_remove),:) = [];        

% remove all control control quesitons
prefs(prefs(:,4)==1,:) = [];         

% we only need the first three dimensions
prefs = prefs(:,1:3); 

% write the results
dlmwrite([preference_file "_cleaned"], prefs);
dlmwrite([user_file "_cleaned"], users); 


return ;
