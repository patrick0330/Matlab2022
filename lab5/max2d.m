function [v, varargout] = max2d(A, varargin)
    varargout = cell(1, nargout - 1);
    validateattributes(A,{'numeric'},{'nonempty'});
    if nargin == 2
        attributes = {'>',0,'<=',numel(A),'scalar'};        
        validateattributes(varargin{1},{'numeric'},attributes);        
        if nargout == 2
            [v, varargout{1}] = sort(A(:),'descend');
            v = v(1:varargin{1});
            varargout{1} = varargout{1}(1:varargin{1});
        elseif nargout == 3
            [v, n] = sort(A(:),'descend');
            
            [varargout{1}, varargout{2}] = ind2sub(size(A), n);
            v = v(1:varargin{1});
            varargout{1} = varargout{1}(1:varargin{1});            
            varargout{2} = varargout{2}(1:varargin{1});
           
        else        
            v = sort(A(:), 'descend');
            v = v(1:varargin{1});
        end
    elseif nargout == 2
        v = max(A(:));
        varargout{1} = find(A == v);
    elseif nargout == 3
        v = max(A(:));
        [varargout{1}, varargout{2}] = ind2sub(size(A),find(A == v));
    elseif nargin > 2
        fprintf("Too many input variable\n");
        return    
    else        
        v = max(A(:));
    end       
   
end