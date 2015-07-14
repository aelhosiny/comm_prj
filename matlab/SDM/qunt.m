function y = qunt(u,w)
	if u <= (2^(w-1)-1)
		y = u ;
	else
		y = u-2^(w-1)-1 ;
end
