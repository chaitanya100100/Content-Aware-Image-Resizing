clear all ;

im = imread('./images/lake_seamcut.jpg') ;
[M, N, chn] = size(im) ;
FM = M ; FN = N + 200 ;
OM = M ; ON = N ;

cost = get_cost_gradient(im) ;
dp = zeros(M, N) ;
from = zeros(M, N) ;
dp(1, :) = cost(1, :) ;
from(1, :) = 1 : N ;

for i = 2 : M
    for j = 1 : N
        dp(i, j) = dp(i - 1, j) ;
        from(i, j) = j ;
        if j > 1 && dp(i - 1, j - 1) < dp(i, j)
            dp(i, j) = dp(i - 1, j - 1) ;
            from(i, j) = j - 1 ;
        end
        if j < N && dp(i - 1, j + 1) < dp(i, j)
            dp(i, j) = dp(i - 1, j + 1) ;
            from(i, j) = j + 1 ;
        end
        dp(i, j) = dp(i, j) + cost(i, j) ;
    end
end

to_increase = FN - N ;
[~, idxs] = sort(dp(M, :)) ;
idxs = idxs(1 : to_increase) ;

repeat = zeros(M, N) ;

for i = M : -1 : 1
    for j = 1 : to_increase
        repeat(i, idxs(j)) = repeat(i, idxs(j)) + 1 ;
    end
    idxs = from(i, idxs) ;
end

im_out = zeros(FM, FN, chn) ;
for i = 1 : FM
    k = 1 ;
    for j = 1 : N
        for kk = 1 : repeat(i, j) + 1
            im_out(i, k, :) = im(i, j, :) ;
            k = k + 1 ;
        end
    end
end