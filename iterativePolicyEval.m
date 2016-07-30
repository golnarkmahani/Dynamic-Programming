function [ valuefunction,counter ] = iterativePolicyEval( p_s_a,P,R,gamma,maxiteration)
valuefunction=zeros(1,6); 
delta=1;
counter=1;
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
end

