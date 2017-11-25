im = imread('./images/Broadway_tower_edit.jpg');
[row,col,n] = size(im);
im(720:800,100:147,:) = -1e5;

im = double(im)/255;

[grad_x,grad_y] = gradient(im);
G_im = grad_x + grad_y;
G_im = abs(G_im);

figure,imshow(im);
%[100 720; 147 720;100 800; 147 800]

%figure,imshow(grad_y);
%figure,imshow(G_im);