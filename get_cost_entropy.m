function E = get_cost_gradient(im)
    
    [row,col,n] = size(im);
    if(n == 3)
        im = rgb2gray(im);
    end
    E =  entropyfilt(im) ;

end
