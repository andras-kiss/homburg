program diffusion

! input file, mask, D, h, time, output lower left, output top right, output height, output file

implicit none

integer :: x_size, y_size, z_size
integer :: res, height
integer :: time_res

! 0.000703 mm^2/s = 703um^2/s for resolution of 1umx1um and 1s
! = 0.00000703 cm^2/s for resolution of 1umx1um and 1s
! CRC Handbook of chemistry and physics 87th 2006-2007.pdf page 848 (acrobat reader p#)
! 1/2 Zn2+ -ra vonatkozik.
real :: const=0.017575 !for resolution of 20umx20um and 0.1s
! real :: const=0.02812 !for resolution of 50umx50um and 0.1s

integer :: h,i,j,k,x,y,m,switch,cells
real, dimension(0:101,0:101,0:101) :: a, b
real, dimension(1:100,1:100,1:100) :: flux
integer, dimension(1:100,1:100,1:100) :: mask
real :: pi=3.1415926535897932384626433832795
real maximum
real e0, x_real, y_real
real, dimension(0:100,0:100) :: sim
integer direction, divisions
real alpha, circumference, r_real
integer r, n
direction=-1
maximum=0.00000000000000
height=50


a=0.
b=0.
mask=1

! Tömb feltöltése. Ha azt akarod, hogy egy cella ne változzon (Dirichlet), akkor azon a cellán mask=0.
! Fluxus tömb: minden körben hozzáadódik a fluxusban tárolt érték a c-tömbhöz.
! Térbeli felbontást a D (const) határozza meg.
do i=1, 100
	do j=1, 100
		if ( ((i-50)**2+(j-50)**2) < 20**2 ) then !20 itt a source sugara = 400um
			flux(i,j,1)=0.1
		endif
	end do
end do

open(1,file='flux at 1um.txt')
do i=0, 100
	do j=0, 100
		write(1, *) i*20, j*20, flux(i,j,1)  
	end do
end do
close(1)

open(1,file='flux at 1um_final res.txt')
do i=0, 100, 5
	do j=0, 100, 5
		write(1, *) i*20, j*20, flux(i,j,1)  
	end do
end do
close(1)

! Dirichlet feltétel
! front és hátsó lap
do k=1, 100
	do i=1, 100
		mask(i, 1, k)=0
		mask(i, 100, k)=0
	end do
end do
! jobb és bal lap
do k=1, 100
	do j=1, 100
		mask(1, j, k)=0
		mask(100, j, k)=0
	end do
end do
! fedőlap
do j=1, 100
	do i=1, 100
		mask(i, j, 100)=0
	end do
end do

! Számolás. Az időbeli felbontást D (const) határozza meg.
! b és a tömbök váltakoznak, így nem kell az egész tömböt másolgatni.
b=a
switch=0
! x=i, y=j, z=k, h=time
do h=1, 500 ! M A I N  L O O P

	! All real cells computed. Not cycled: borders, which are all zeros.
	do k=1, 100
		do j=1, 100
			do i=1, 100
				if (mask(i,j,k)==1) then
					cells=6
					if ((k==1) .or. (k==100)) then 
						cells=cells-1
					endif
					if ((j==1) .or. (j==100)) then 
						cells=cells-1
					endif
					if ((i==1) .or. (i==100)) then 
						cells=cells-1
					endif
					b(i,j,k)=a(i,j,k)+const*(a(i,j+1,k)+a(i-1,j,k)+a(i+1,j,k) &
					+a(i,j-1,k)+a(i,j,k-1)+a(i,j,k+1)-cells*a(i,j,k))
				endif
			end do
		end do
	end do
	
	! Fluxusok hozzáadása.

	do j=1, 100
		do i=1, 100
			b(i,j,1)=b(i,j,1)+flux(i,j,1)  
		end do
	end do	
	
	! a és b tömbök cseréje
	a=b
	
	print *,h
end do
	
do i=0, 100
	do j=0, 100
		if (a(i,j,height)>maximum) then
			maximum=a(i,j,height)
		endif
	end do
end do	
print *,maximum
do i=0, 100
	do j=0, 100
		a(i,j,height)=a(i,j,height)/maximum
	end do
end do	
					
	
! O U T P U T	
open(1,file='real_100um_fullres.txt')
do i=0, 100
	do j=0, 100
		write(1, *) i*20, j*20, a(i,j,height)
	end do
end do		
close(1)

open(1,file='real_100um_finalres.txt')
do i=0, 100, 5
	do j=0, 100, 5
		write(1, *) i*20, j*20, a(i,j,height)
	end do
end do		
close(1)


! SECM scanning simulation

! MEANDER
sim=0
e0=a(0,0,height)
open(1,file='meander_1s.txt')
do y=0, 100, 5
	direction=direction*(-1)
	if (direction==1) then
		do x=0, 100, 5
			sim(x,y) = a(x,y,height) + (e0-a(x,y,height))*0.8
			e0=sim(x,y)
			write(1, *) x*20, y*20, sim(x,y)
		end do
	else
		do x=100, 0, -5
			sim(x,y) = a(x,y,height) + (e0-a(x,y,height))*0.8
			e0=sim(x,y)
			write(1, *) x*20, y*20, sim(x,y)
		end do
	endif
end do
close(1)

! MEANDER
sim=0
e0=a(0,0,height)
open(1,file='meander_5s.txt')
do y=0, 100, 5
	direction=direction*(-1)
	if (direction==1) then
		do x=0, 100, 5
			sim(x,y) = a(x,y,height) + (e0-a(x,y,height))*0.4
			e0=sim(x,y)
			write(1, *) x*20, y*20, sim(x,y)
		end do
	else
		do x=100, 0, -5
			sim(x,y) = a(x,y,height) + (e0-a(x,y,height))*0.4
			e0=sim(x,y)
			write(1, *) x*20, y*20, sim(x,y)

		end do
	endif
end do
close(1)

! COMB
sim=0
e0=a(0,0,height)
open(1,file='comb.txt')
open(2,file='comb_pattern.txt')
do y=0, 100, 5
	do x=0, 100, 5
		sim(x,y) = a(x,y,height) + (e0-a(x,y,height))*0.8
		e0=sim(x,y)
		!write(1, *) x*20, y*20, sim(x,y)
		write(2, *) x*20, y*20, sim(x,y)
	end do
	do x=100, 0, -5
		sim(x,y) = (sim(x,y) + a(x,y,height) + (e0-a(x,y,height))*0.8)/2
		e0=a(x,y,height) + (e0-a(x,y,height))*0.8
		write(1, *) x*20, y*20, sim(x,y)
		write(2, *) x*20, y*20, sim(x,y)
	end do
end do
close(1)
close(2)

end program diffusion
