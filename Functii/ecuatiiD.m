function F = ecuatiiD(z, M, phi, k)
F=phi-atan(sqrt((M/k)^2*(4*z^2*(1-z^2))-1))+atan(sqrt(1-2*z^2)/z);
end