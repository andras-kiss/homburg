program diffusion
implicit none

integer :: stat
real t, tau1, rc, e0, conv

tau1=3.76

open(1,file='original_1sec.txt')
open(2,file='deconvoluted.txt')
read(1, *) t, e0
write(2, *) t, e0
do
   read(1, *, iostat=stat) t, conv
   if (stat /= 0) exit
   write(2, *) t, ((conv - e0*exp(-0.5/tau1))/(1-exp(-0.5/tau1)))
   e0=conv
end do
close(1) 
close(2)
end program diffusion
