! PROJECT EULER
! PROBLEM 1
! if we list all the natural numbers below 10 that are multiples of 3 or 5,
!  we get 3, 5, 6 and 9. The sum of these multiples is 23.
! Find the sum of all the multiples of 3 or 5 below 1000.
!
program PE1
!  implicit none
!  integer :: sum

  write(*,*) ''
  write(*,*) 'PE1'
  write(*,*) 'Find the sum of all the multiples of 3 or 5 below 1000.'

  sum = 0
  do i = 1, 999    ! start, end, [step]
    !
    j = 0    ! already used? [0=F, 1=Y]
    ! multiples of 3
    if (mod(i,3) .eq. 0) then
      sum = sum + i
      j = 1
    end if
    !
    ! multiples of 5
    if ((mod(i,5) .eq. 0) .and. (j.eq.0)) then
      sum = sum + i
    end if
    !
  end do

  write(*,*) 'Ans = ', sum
  write(*,*) ''

end program PE1
