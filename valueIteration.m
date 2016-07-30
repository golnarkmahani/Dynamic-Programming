function [ policy ] = valueIteration( P,R,gamma,maxiteration )
%% initialization    
valuefunction=zeros(1,6);
policy=zeros(1,6);
%% 
delta=1;
counter=1;
while(delta>0.1 && counter<maxiteration)
    delta=0;
    for s=2:5,
        current_v=valuefunction(s);       
        left=0; 
        right=0;
        for sprime=[s-1,s,s+1],
            left=left+(P(s,sprime,1)*(R(s,sprime,1)+(gamma*valuefunction(sprime))));
            right=right+(P(s,sprime,2)*(R(s,sprime,2)+(gamma*valuefunction(sprime))));
        end            
        if(left>right)
            policy(s)=1;
            valuefunction(s)=left;
        elseif(left<right)
            policy(s)=2;
            valuefunction(s)=right;
        end          
        delta=max(delta,abs(current_v-valuefunction(s)));        
    end
    disp(['VI: value function k=',num2str(counter)]);
    disp(valuefunction);
    disp(['VI: policy k=',num2str(counter)]);
    disp(policy);
    counter=counter+1;
end 
end

