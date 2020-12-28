%Flag for selection vs. no selection
has_selection = true;


%Assertions on parameters
assert(delta >= 0 && rho >= 0 && gamma ~= 1 && chi > 0 && chi < 1 && eta >= 0 && eta <= 1 && kappa >= 0 && d >= 1 && sigma >= 1 && Theta >= 0 && gamma >= 0);
if(upsilon == 0)
    upsilon = 0.00001; %There is a singularity exactly at 0, but no discontinuity in the solution.  Check the "simple" version for verification which solve exactly.
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = @(g,z_hat,Omega) ((-1).*g+g.*gamma+delta+rho+(-1).*((-1)+sigma).*((-1).*g+mu+(1/2).*((-1)+sigma).*upsilon.^2)).^(-1);
b = @(g,z_hat,Omega) d.^(1+(-1).*sigma).*z_hat.^((-1)+sigma+((g+(-1).*mu).^2.*upsilon.^(-4)+2.*((-1).*g+g.*gamma+delta+rho).*upsilon.^(-2)).^(1/2)+((-1).*g+mu).*upsilon.^(-2)).*(1+(-1).*((-1).*g+g.*gamma+delta+rho).*((-1).*g+g.*gamma+delta+rho+(-1).*((-1)+sigma).*((-1).*g+mu+(1/2).*((-1)+sigma).*upsilon.^2)).^(-1));
c = @(g,z_hat,Omega) (-1).*zeta.*eta.*Theta.*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1)).*Omega+(d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1)).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega);
free_entry_root = @(g,z_hat,Omega) (-2).*((-2).*delta+(-2).*mu+(-2).*rho+2.*mu.*sigma+(-2).*g.*((-2)+gamma+sigma)+upsilon.^2+(-2).*sigma.*upsilon.^2+sigma.^2.*upsilon.^2).^(-1).*((-1).*g+mu+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).^(-1).*((-1).*g+mu+(-1).*upsilon.^2+sigma.*upsilon.^2+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).*((-1)+chi).^(-1).*chi+zeta.*((-1)+sigma).*((d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1))).^((-1)+sigma).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega).^(-1).*(1+(-1).*eta+eta.*Theta.*((-1)+sigma).^(-1).*sigma.*(d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^((1+(-1).*sigma).^(-1)));
L_tilde = @(g,z_hat,Omega) (((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega;
r = @(g,z_hat,Omega) g.*gamma+delta+rho;
%S = @(g,z_hat,Omega) theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2); #Wrong?  Adjustment for the mu?
U_bar = @(g,z_hat,Omega) (1+(-1).*gamma).^(-1).*(g.*((-1)+gamma)+rho).^(-1).*((-1).*zeta.*eta.*Theta.*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1)).*Omega+(d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1)).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega)).^(1+(-1).*gamma);
vm_root = @(g,z_hat,Omega) 1+((-1)+sigma).*upsilon.^2.*((-1).*g+mu+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).^(-1)+(-1).*(1+theta+(-1).*sigma).^(-1).*upsilon.^4.*((-1).*g+mu+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).^(-1).*((-1).*g+mu+theta.*upsilon.^2+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).^(-1).*(theta.*upsilon.^(-4).*(d.^(1+(-1).*sigma).*((-1)+n).*z_hat.^((-1)+(-1).*theta+sigma).*((-1).*g+mu+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).*((-1).*g+mu+theta.*upsilon.^2+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2))+((-1).*g+mu+upsilon.^2+theta.*upsilon.^2+(-1).*sigma.*upsilon.^2+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).*((-1).*g+mu+(-1).*upsilon.^2+sigma.*upsilon.^2+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)))+(-1).*d.^(1+(-1).*sigma).*((-1)+n).*z_hat.^((-1)+(-1).*theta+sigma).*(g.*((-1)+gamma)+delta+rho).^(-1).*(1+theta+(-1).*sigma).*upsilon.^(-2).*((-1).*g+mu+((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)).*((-1).*g+g.*gamma+delta+rho+(-1).*((-1)+sigma).*((-1).*g+mu+(1/2).*((-1)+sigma).*upsilon.^2)).*(theta+((-1).*g+mu).*upsilon.^(-2)+upsilon.^(-2).*((g+(-1).*mu).^2+2.*(g.*((-1)+gamma)+delta+rho).*upsilon.^2).^(1/2)+(-1).*theta.*(1+(-1).*(g.*((-1)+gamma)+delta+rho).*((-1).*g+g.*gamma+delta+rho+(-1).*((-1)+sigma).*((-1).*g+mu+(1/2).*((-1)+sigma).*upsilon.^2)).^(-1))))+zeta.*((-1)+sigma).*((-1).*g+g.*gamma+delta+rho+(-1).*((-1)+sigma).*((-1).*g+mu+(1/2).*((-1)+sigma).*upsilon.^2)).*((d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1))).^((-1)+sigma).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega).^(-1).*(1+(-1).*eta+eta.*Theta.*((-1)+sigma).^(-1).*sigma.*(d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^((1+(-1).*sigma).^(-1)));
x = @(g,z_hat,Omega) zeta.*(1+(-1).*eta+eta.*Theta.*((-1)+sigma).^(-1).*sigma.*(d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^((-1).*((-1)+sigma).^(-1)));
y = @(g,z_hat,Omega) (d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1)).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega);
z_bar = @(g,z_hat,Omega) (d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1));
z_hat_root = @(g,z_hat,Omega) (-1).*z_hat+d.*(kappa.*((-1)+sigma).*((d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1))).^((-1)+sigma).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega).^(-1)).^(((-1)+sigma).^(-1));
lambda_ii = @(g,z_hat,Omega) (1+d.^(1+(-1).*sigma).*((-1)+n).*z_hat.^((-1)+(-1).*theta+sigma)).^(-1);
nu = @(g,z_hat,Omega) ((g+(-1).*mu).^2.*upsilon.^(-4)+2.*((-1).*g+g.*gamma+delta+rho).*upsilon.^(-2)).^(1/2)+((-1).*g+mu).*upsilon.^(-2);
pi_bar_agg = @(g,z_hat,Omega) (-1).*((-1)+n).*z_hat.^((-1).*theta).*kappa.*Omega+((-1)+sigma).^(-1).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega);
pi_min = @(g,z_hat,Omega) ((-1)+sigma).^(-1).*((d.^((-1).*sigma).*z_hat.^((-1)+(-1).*theta).*(d.^sigma.*z_hat.^(1+theta)+d.*((-1)+n).*z_hat.^sigma).*theta.*(1+theta+(-1).*sigma).^(-1).*Omega).^(((-1)+sigma).^(-1))).^(1+(-1).*sigma).*(1+(-1).*(((-1)+n).*z_hat.^((-1).*theta).*kappa+zeta.*(1+(-1).*eta).*(theta.*(g+(-1).*mu+(-1/2).*theta.*upsilon.^2)+delta.*chi.^(-1))).*Omega);
