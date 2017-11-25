clear all ;

im = imread('./images/Broadway_tower_edit.jpg') ;
[M, N, chn] = size(im) ;

%im(720:800,100:147,:) = -1e5;

FM = M / 2 ; FN = N - 100;

OM = M ; ON = N ;

% traverse until we get desired width
while N > FN
    
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
    
    [~, idx] = min(dp(M, :)) ;
    for i = M : -1 : 1
        im(i, idx : N - 1, :) = im(i, idx + 1 : N, :) ;
        idx = from(i, idx) ;
    end
    im = im(:, 1 : N - 1, :) ;
    N = N - 1 ;
end