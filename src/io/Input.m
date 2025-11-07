classdef Input < handle
    properties
    end

    methods
        function bin_stream = create(path)
            arguments
                path string
            end
            
            fid = fopen(path);

            if (fid ~= -1)
                bin_stream = fread(fid, "bit1")';
            else 
                bin_stream = [];
            end
        end

        % modulation vs source coding?
        function bin_stream = modulate(mode)
            bin_stream = [];
        end
    end
end