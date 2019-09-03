function [U_ip]= knifeEdge(U_i, X, Y, horpos_knifeedge)
  M_cutoff = zeros(size(X)); 
  M_cutoff(find(Y<horpos_knifeedge)) = 1;
  U_ip = U_i .* M_cutoff;
end
