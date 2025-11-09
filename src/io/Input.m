classdef Input < handle
    properties
    end

    methods(Static)
        function bin_stream = create(path)
            arguments
                path string
            end
            
            fid = fopen(path, 'rb');

            if (fid ~= -1)
                bin_stream = fread(fid, "ubit1", 'b')';
                len = length(bin_stream);
                fprintf(1, "Read %s\nSize:\n   %d bits\n   %d bytes\n", path, len, len/8);
                fclose(fid);
            else 
                bin_stream = [];
                fprintf(2, "Error: the input file does not exist or could not be opened\n");
            end
        end

        % modulation vs source coding?
        function bin_stream = modulate(mode)
            bin_stream = [];
        end
    end
end