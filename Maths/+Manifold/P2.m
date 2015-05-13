classdef P2 < Manifold.Base
    %P2 Class for the P2 (projective) manifold
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = P2( in1, p, A_n, A_p )
            if nargin == 1 % Input l
                l = in1;
            else
                n = in1;
                if ~all( size(n) == [2 1] & size(p) == [2 1] )
                    error('Wrong inputs');
                end
                l = [ n ; -n*p ];
            end
                        
            obj.X = l;
            obj.x = [];

            obj.dim = 2;
            obj.DIM = 3;
            
            if exist('A_n','var') && exist('A_p','var')
                J = [ eye(2) , zeros(2,2);
                    -p'    , -n'       ];
                A_l = J * blkdiag( A_n, A_p ) * J';
                
                obj.A_X = A_l;
                J_x_X = obj.Dlog;
                obj.A_x = J_x_X * A_l * J_x_X';
            end
        end
        
        function J_X_x = Dexp( obj )
            l = obj.X;
            J_X_x = null( l' ); % Transpose of Dlog
        end
        
        function J_x_X = Dlog( obj )
            l = obj.X;
            J_x_X = null( l' )';
        end
        
        function J_X_X = Dproj( obj )
            J_X_X = obj.Dexp * obj.Dlog;
        end
        
    end
    methods (Static)
        %         function n = exp( alpha )
        %             n = [ cos(alpha) ; sin(alpha) ];
        %         end
        %
        %         function alpha = log( n )
        %             alpha = atan2( n(2), n(1) );
        %         end
        %
        %         function mu_n = mean( X )
        %             mu_n = sum( X, 2 );
        %             mu_n = mu_n / norm( mu_n );
        %         end
        function mu_n = mean( in )
            if isa(in,'Manifold.P2')
                in = [in.X];
            end
            in = snormalize( in );
            mu_n = sum( in, 2 );
            mu_n = mu_n / norm( mu_n );
            mu_n = Manifold.P2( mu_n );
        end
        
        function [l, A_l] = cv2l( c, v, A_c, A_v )
            % l = cv2l( c, v )
            % [l, A_l] = cv2l( c, v, A_c, A_v )
            % [l, A_l] = cv2l( c, v, A_cv )
            %
            % Compute P2 line from image point and direction and propagate covariance is required
            % Input:
            %   c - 2x1 point in the line
            %   v - 2x1 direction for line (up to sign!)
            %   A_c - 2x2 (rank 2) cov matrix of c
            %   A_v - 2x2 (rank 1) cov matrix of v (in S1)
            %   A_cv - 4x4 (rank 3) cov matrix of concatenated c and v
            % Output:
            %   l - 3x1 line homogeneous vector
            %   A_l - 3x3 (rank 2) cov matrix of l

            % Check if covariance propagation should be computed
            hasCovProp = nargout > 1;
            
            %% Homogeneous line
            % Get output values
            n = ort_2D(v); % Normal direction
            l = [ n; -n'*p ]; % Homogeneous line
            if hasCovProp
                if exist('A_c','var') && exist('A_v','var')
                    % If two independent covariances are given, compound
                    A_cv = blkdiag( A_c, A_v );
                else
                    A_cv = A_c; % Complete matrix given in first parameter
                end
                % Uncertainty propagation
                J_l_c = [ zeros(2,2) ; -n' ];
                R90 = [0 -1; 1 0];
                J_l_v = [ eye(2) ; -c' ] * R90;
                J = [ J_l_c, J_l_v ];
                A_l = J * A_cv * J';
            end
        end
        
        function [l, A_l] = pts2l( p1, p2, A_p1, A_p2 )
            % l = pts2l( p1, p2 )
            % [l, A_l] = pts2l( p1, p2, A_p1, A_p2 )
            % [l, A_l] = pts2l( p1, p2, A_p1p2 )
            % Compute P2 line from 2 image points and propagate covariance is required
            % Input:
            %   p1,p2 - 2x1 points in the line
            %   A_p1,A_p2 - 2x2 (rank 2) cov matrix of points
            % Output:
            %   l - 3x1 line homogeneous vector
            %   A_l - 3x3 (rank 2) cov matrix of l

            % Check if covariance propagation should be computed
            hasCovProp = nargout > 1;
            
            %% Homogeneous line
            l = cross( makehomogeneous(p1), makehomogeneous(p2) );
            if hasCovProp
                if exist('A_p1','var') && exist('A_p2','var')
                    % If two independent covariances are given, compound
                    A_pp = blkdiag( A_p1, A_p2 );
                else
                    A_pp = A_c; % Complete matrix given in first parameter
                end
                % Uncertainty propagation
                A_l = NaN(3,3);
                error('TO IMPLEMENT YET');
            end
        end
        
        function [out, A_out] = cross( in1, in2, A_1, A_2 )
            % lh = cross( ph1, ph2 )
            % ph = cross( lh1, lh2 )
            % [out, A_out] = cross( in1, in2, A_1, A_2 )
            % [out, A_out] = cross( in1, in2, A_12 )
            % Compute cross product in P2 and propagate covariance is required
            % Input:
            %   in1,in2 - 3x1 homogeneous vectors
            %   A_1,A_2 - 3x3 (rank 2) cov matrix of vectors
            % Output:
            %   out - 3x1 homogeneous vector
            %   A_out - 3x3 (rank 2) cov matrix of output vector

            % Check if covariance propagation should be computed
            hasCovProp = nargout > 1;
            
            % Output
            out = cross( in1, in2 );
            if hasCovProp
                % Check rank conditions
                if exist('A_1','var') && exist('A_2','var')
                    assert( rank(A_1)==2 );
                    assert( rank(A_2)==2 );
                    % If two independent covariances are given, compound
                    A_12 = blkdiag( A_p1, A_p2 );
                else
                    A_12 = A_1; % Complete matrix given in first parameter
                    assert( rank(A_12)==4 );
                end
                % Uncertainty propagation
                J = [-skew(in2) skew(in1)]; % J_out_in1in2
                A_out = J * A_12 * J';
                error('TO IMPLEMENT YET');
            end            
        end

        % Normalization operations
        function [ps, A_ps] = snormalize( ph, A_ph )
            % ps = snormalize( ph )
            % [ps, A_ps] = snormalize( ph, A_ph )
            % Normalize P2 point into S2 (normalize norm)
            % Input:
            %   ph - 3x1 homogeneous point
            %   A_ph - 3x3 (rank 2) cov matrix of homogeneous point
            % Output:
            %   p - 2x1 inhomogeneous point
            %   A_p - 2x2 (full-rank) cov matrix of output point
            
            % Check if covariance propagation should be computed
            hasCovProp = nargout > 1;
            
            % Output
            ps = ph / norm( ph );
            if hasCovProp
                % Check rank conditions
                assert( rank(A_ph)==2 );
                % Uncertainty propagation
                J = 1/norm(ph) * ( eye(3) - ph*ph'/(ph'*ph) );
                A_ps = J * A_ph * J';
            end            
        end
        function [p, A_p]   = pnormalize( ph, A_ph )
            % p = pnormalize( ph )
            % [p, A_p] = pnormalize( ph, A_ph )
            % Make P2 point inhomogeneous (normalize last coordinate 1)
            % Input:
            %   ph - 3x1 homogeneous point
            %   A_ph - 3x3 (rank 2) cov matrix of homogeneous point
            % Output:
            %   p - 2x1 inhomogeneous point
            %   A_p - 2x2 (full-rank) cov matrix of output point
            
            % Check if covariance propagation should be computed
            hasCovProp = nargout > 1;
            
            % Output
            p = makeinhomogeneous( ph );
            if hasCovProp
                % Check rank conditions
                assert( rank(A_ph)==2 );
                % Uncertainty propagation
                J = DprojectionP2( ph );
                A_p = J * A_ph * J';
            end            
        end
        function [ln, A_ln] = lnormalize( lh, A_lh )
            % ln = lnormalize( lh )
            % [ln, A_ln] = lnormalize( lh, A_lh )
            % Make P2 line normal in the sense that image distances are
            % given by dot product with normal points, norm(lh(1:2))=1
            % Input:
            %   lh - 3x1 homogeneous line
            %   A_lh - 3x3 (rank 2) cov matrix of homogeneous line
            % Output:
            %   ln - 3x1 inhomogeneous point
            %   A_ln - 3x3 (rank 2) cov matrix of output line
            
            % Check if covariance propagation should be computed
            hasCovProp = nargout > 1;
            
            % Output
            ln = lh / norm(lh(1:2));
            if hasCovProp
                % Check rank conditions
                assert( rank(A_lh)==2 );
                % Uncertainty propagation
                error('TO IMPLEMENT YET')
                A_ln = NaN(3,3); %#ok<UNRCH>
%                 J = DprojectionP2( ph );
%                 A_p = J * A_ph * J';
            end            
        end
    end    
end