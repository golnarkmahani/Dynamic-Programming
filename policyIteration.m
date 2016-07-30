function [ policy ] = policyIteration( P,R,p_s_a,gamma,maxiteration )
%% initialization    
valuefunction=zeros(1,6);
policy_stable=0;
while(policy_stable==0)
    %% policy Evaluation
    delta=1;
    counter=1;
    disp('PI: value function');
    while(delta>0.1 && counter<maxiteration)
        delta=0;
        for s=2:5,
            current_v=valuefunction(s);
            temp=0;       
            for action=[1,2],            
                v=0;
                for sprime=[s-1,s,s+1],
                    v=v+(P(s,sprime,action)*(R(s,sprime,action)+(gamma*valuefunction(sprime))));
                end 
                temp=temp+(p_s_a(s,action)*v);
            end
            valuefunction(s)=temp;                

            delta=max(delta,abs(current_v-valuefunction(s)));        
        end
        disp(valuefunction);
        counter=counter+1;
    end
    %% policy improvement
    disp('PI: new policy');
    policy_stable=1;
    for s=2:5,
        prev_policy=p_s_a(s,:);
        left=0; 
        right=0;
        for sprime=[s-1,s,s+1],
            left=left+(P(s,sprime,1)*(R(s,sprime,1)+(gamma*valuefunction(sprime))));
            right=right+(P(s,sprime,2)*(R(s,sprime,2)+(gamma*valuefunction(sprime))));
        end            
        if(left>right)
            p_s_a(s,1)=1;
            p_s_a(s,2)=0;
            if(prev_policy(1,:)~=p_s_a(s,:))
              policy_stable=0;
            end
        elseif(left<right)
            p_s_a(s,1)=0;
            p_s_a(s,2)=1;
            if(prev_policy(1,:)~=p_s_a(s,:))
              policy_stable=0;
            end
        end                
    end
    
    %display the updated policy
    policy=zeros(1,6);
    for i=2:5,
        if(p_s_a(i,1)==1)
            policy(i)=1;
        elseif(p_s_a(i,2)==1)
            policy(i)=2;
        end
    end
    disp(policy);
end   
end

