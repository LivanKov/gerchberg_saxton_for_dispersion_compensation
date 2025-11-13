% "..." vs '...' difference:
% - '...' char vector, use strcmp
% - "..." string

function y = StrToBin(input)
   if (~isa(input, 'string') & ~isa(input, 'char'))
        fprintf(2, "Error: StrToBin only accepts char and string types as input\n");
   end 

   if (isa(input, 'string'))
       disp("Check");
       input = char(input);
   end 
   
   codes = uint8(input);
   codes = dec2bin(codes, 8);
   bits = codes' - '0';
   y = bits(:)';
end