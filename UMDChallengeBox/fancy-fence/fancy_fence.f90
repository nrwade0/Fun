! paste into command line: "gfortran -o fancy_fence fancy_fence.f90"
! link: https://challengebox.cs.umd.edu/2019/Fence/index.html
!
!
!
program PE1
!  implicit none
  integer :: n, p0_x, p0_y, temp_x, temp_y, p0_index
  logical :: exist_file
  character(*), parameter :: file_path = '/Users/nick/Documents/GitHub/fun/UMDChallengeBox/fancy-fence/'
  real, dimension(3,3) :: coords, array ! (cols, rows)
  real, dimension(1,3) :: polar

!  write(*,*) ''
!  write(*,*) 'Fancy Fence'
!  write(*,*) 'UMD Challenge Box, Oct. 14-16 2019'

! Open the input file
  open(10, file=file_path//'fence-test0.txt', status='OLD')
  write(*,*) "opened file"

! Read the coordinates and place in 'n' and 2D array 'coords'
  read(10, *) n
  read(10, *) coords

! Close the input file, not needed anymore
  close(10)

! Print data to check if correct
  write(*,*) 'n = ', n
  write(*,*) 'coords = '
  do 2 i = 1, n
    write(*,*) "(", coords(1,i), ", ", coords(2,i), ")"
2 end do

! Graham Scan for Convex Hull
! https://en.wikipedia.org/wiki/Graham_scan

! Find 'p0' w/ lowest x-coord and y-coord
  ! Set temporary values for finding p0 to first xy pair in coords
  temp_x = coords(1, 1)
  temp_y = coords(1, 2)
  do 3 i = 2, n
    ! if there is a new smaller y-coordinate, replace our p0 values
    if(coords(i, 2) .lt. temp_y) then
      temp_x = coords(i, 1)
      temp_y = coords(i, 2)
      p0_index = i
    end if
    ! if the y-coords are the same, then choose the lower x-coordinate
    if(coords(i,1) .lt. temp_x .and. coords(i, 2) .eq. temp_y) then
      temp_x = coords(i, 1)
      temp_y = coords(i, 2)
    end if
3 end do
  ! set our temp values to official p0 coordinates and print to screen
  p0_x = coords(1, p0_index)
  p0_y = coords(2, p0_index)
  write(*,*) 'p0_x = ', p0_x, 'p0_y = ', p0_y


! sort array 'coords' based on the polar angle with p0, atan2(y,x) should
!  work. Keep it on the 'stack'. If several points have the same polar angle
!  then keep the farthest.
  ! Determine polar angles for each coordinate relative to p0, saved in 'polar'
  do 4 i = 1, n
    coords(3,i) = atan2(real(coords(1,i)), real(coords(2,i)))*180/3.14159
4 end do
  write(*,*) coords
  ! sort the polar array

  ! cycle thru the points and snatch ones that follow these rules:
  !  1. There is at least one point on the stack still.
  !  2. and ccw(next_to_top(stack), top(stack), point) < 0
  !  # pop the last point from the stack if we turn clockwise to reach this point








end program PE1
