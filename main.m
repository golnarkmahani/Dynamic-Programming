clear all;
clc;
%% P(s,s',a)
for s=1:6,
    for sprime=1:6,
        aindex=1;
        for action=[-1,1],            
            if(s==sprime && (s==1 || s==6))
                P(s,sprime,aindex)=1;
            elseif(sprime==s-action && s~=6 && s~=1) 
                P(s,sprime,aindex)=0.05;
            elseif(sprime==s+action && s~=6 && s~=1) 
                P(s,sprime,aindex)=0.8;
            elseif(sprime==s && s~=6 && s~=1) 
                P(s,sprime,aindex)=0.15;
            elseif(sprime~=s-action && (s==6 || s==1)) 
                P(s,sprime,aindex)=0;
            end
            aindex=aindex+1;
        end
    end
end
%% R(s,s',a)
for s=1:6,
    for sprime=1:6,
        aindex=1;
        for action=[-1,1],            
            if(s==2 && sprime==1)
                R(s,sprime,aindex)=1;
            elseif(sprime==s || (sprime>=2 && sprime<=5)) 
                R(s,sprime,aindex)=0;
            elseif(sprime==6 && s==5) 
                R(s,sprime,aindex)=5;
            end
            aindex=aindex+1;
        end
    end
end
%% 
 %IPE for random walk policy
 rnd_p_s_a=ones(6,2).*(1/2);
  disp('IPE: value function for random walk policy');
 [Rndvaluefunction,rndcounter]=iterativePolicyEval(rnd_p_s_a,P,R,0.5,10); 
 
 %IPE for move right policy
 right_p_s_a=[zeros(6,1) ones(6,1)];
 disp('IPE: value function for move to the right policy');
 [rightvaluefunction,rightcounter]=iterativePolicyEval(right_p_s_a,P,R,0.5,10); 
 
 %PI with a random walk policy as initialization
 disp('random walk policy');
 rndpoliccy=policyIteration( P,R,rnd_p_s_a,0.5,10 );
 
 %PI with a move to the right policy as initialization
 disp('move to the right policy');
 rightpoliccy=policyIteration( P,R,right_p_s_a,0.5,10 );
 
 %GPI with a random walk policy as initialization
 disp('random walk policy');
 rnd_gpoliccy=generalizedPolicyIteration( P,R,rnd_p_s_a,0.5,10 );
 
 %GPI with a move to the right policy as initialization
 disp('move to the right policy');
 right_gpoliccy=generalizedPolicyIteration( P,R,right_p_s_a,0.5,10 );
 
 %VI 
 vipoliccy=valueIteration( P,R,0.5,10 );