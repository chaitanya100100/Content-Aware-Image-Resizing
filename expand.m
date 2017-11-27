clear all ;

im = imread('./images/wave/wave.jpg') ;
[M, N, chn] = size(im) ;
FM = M ; FN = N + N/2 ;

OM = M ; ON = N ;
O_im = im ;
N_rem = N - (FN - N) ;
[Y, X] = meshgrid(1:N, 1:M) ;
removed = zeros(M, N) ;

% traverse until we get desired width
while N > N_rem
    disp(N) ;
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
        removed(i, Y(i, idx)) = 1 ;
        im(i, idx : N - 1, :) = im(i, idx + 1 : N, :) ;
        Y(i, idx : N - 1) = Y(i, idx + 1 : N) ;
        idx = from(i, idx) ;
    end
    im = im(:, 1 : N - 1, :) ;
    Y = Y(:, 1 : N - 1) ;
    N = N - 1 ;
    
end

im = double(O_im) ;
new_im = zeros(FM, FN, chn) ;

for i = 1 : OM
    k = 1 ;
    
    for j = 1 : ON
        new_im(i, k, :) = im(i, j, :) ;
        k = k + 1 ;
        if removed(i, j) == 1
            
            if (j > 1) && (j < N)
                new_im(i, k, :) = (im(i, j - 1, :) + im(i, j, :) + im(i, j + 1, :)) / 3 ;
            else
                new_im(i, k, :) = im(i, j, :) ;
            end
            k = k + 1 ;
        end
    end
    
end

imshow(uint8(new_im)) ;
