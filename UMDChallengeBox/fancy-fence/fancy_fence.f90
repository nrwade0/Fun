! paste into command line: "gfortran -o fancy_fence fancy_fence.f90"
! link: https://challengebox.cs.umd.edu/2019/Fence/index.html
!
! fancy_fence program calculates the convex hull of a list of points
!  (xy coordinates) inputted in data files
!
!
program fancy_fence
!   implicit none
   integer :: n, H
   logical :: exist_file
   integer, dimension(2,11) :: S ! (cols, rows)
   integer, dimension(2,1) :: p
   integer :: a(3,3) = reshape((/1,2,3,4,5,6,7,8,9/), (/3,3/))

!  Print header
   write(*,*) ''
   write(*,*) 'Fancy Fence'
   write(*,*) 'UMD Challenge Box, Oct. 14-16 2019'

!  Open the file and save to 'n' and 'S'
   call open_file(n, S)

!  Print data to check if correct
   write(*,*) 'n =', n
   write(*,*) 'S ='
   do 2 i = 1, n
      write(*,*) "(", S(1,i), ", ", S(2,i), ")"
2  end do

!  Determine leftmost point
   call left_index(p, S, n)
   write(*,*) 'p =', p

!  Determine orientation of three points

   !H = 0
   !call orientation(a, b, c, H)



end program fancy_fence



! ---------------------------------------------------
! subroutine open_file inputs data into n and S
! ---------------------------------------------------
subroutine open_file(n, S)
!   implicit none
   character(*), parameter :: file_path = '/Users/nick/Documents/GitHub/fun/UMDChallengeBox/fancy-fence/data/'
   integer :: n
   integer, dimension(2,11) :: S

!  Open the input file
   open(10, file=file_path//'fence-test1.in.txt', status='OLD', iostat=ios)

!  Notify user on the condition of data file input
   if(ios .ne. 0) then
     write(*,*) 'An error while opening the data file.'
   else
     write(*,*) "The file was opened correctly."
   endif

!  Read the number of points and coordinates and place in 'n' and 2D array 'S'
   read(10, *) n
   do 11 i = 1, n
     read(10, 15) S(1,i), S(2,i)
11 end do
15 format(I2,I2)

!  Close the input file, not needed anymore
   close(10)

end subroutine open_file



! -----------------------------------------------------------------
! subroutine left_index determines the leftmost point p in a set S
! -----------------------------------------------------------------
subroutine left_index(p, S, n)
!   implicit none
   integer :: n
   integer, dimension(2,11) :: S
   integer, dimension(2,1) :: p

   ! initialize p
   p(1,1) = S(1,1)
   p(2,1) = S(2,1)
   do 20 i = 1, n
     if(p(1,1) .gt. S(1,i)) then
       p(1,1) =  S(1,i) ! p_x
       p(2,1) =  S(2,i) ! p_y
     endif
20 enddo

end subroutine left_index



! -----------------------------------------------------------------
! subroutine orientation computes orientation of three points
! -----------------------------------------------------------------
subroutine orientation(a, b, c, H)
!   implicit none
   integer :: H
   real :: val
   integer, dimension(2,1) :: a, b, c

   ! val = (y2 - y1)*(x3 - x2) - (y3 - y2)*(x2 - x1)
   val = (b(2,1) - a(2,1))*(c(1,1) - b(1,1)) - (c(2,1) - b(2,1))*(b(1,1) - a(1,1))

   ! determine the orientation of the three points
   if(val .gt. 0) then
     H = 1  ! clockwise
   elseif (val .eq. 0) then
     H = 0  ! colinear
   elseif (val .lt. 0) then
     H = -1 ! counterclockwise
   end if

   write(*,*) 'H = ', H


end subroutine orientation
