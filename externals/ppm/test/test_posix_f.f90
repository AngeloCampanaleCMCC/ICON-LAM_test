!>
!! @file test_posix_f.f90
!! @brief test wrappers for POSIX C interface
!!
!! @copyright Copyright  (C)  2012  Thomas Jahns <jahns@dkrz.de>
!!
!! @version 1.0
!! @author Thomas Jahns <jahns@dkrz.de>
!
! Maintainer: Thomas Jahns <jahns@dkrz.de>
! URL: https://www.dkrz.de/redmine/projects/scales-ppm
!
! Redistribution and use in source and binary forms, with or without
! modification, are  permitted provided that the following conditions are
! met:
!
! Redistributions of source code must retain the above copyright notice,
! this list of conditions and the following disclaimer.
!
! Redistributions in binary form must reproduce the above copyright
! notice, this list of conditions and the following disclaimer in the
! documentation and/or other materials provided with the distribution.
!
! Neither the name of the DKRZ GmbH nor the names of its contributors
! may be used to endorse or promote products derived from this software
! without specific prior written permission.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
! IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
! TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
! PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
! OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
! EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
! PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
! PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
! LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
! NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
! SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
!
!> test whether the exposed POSIX.1 routines work for Fortran programs
#include "fc_feature_defs.inc"
PROGRAM test_posix_f
  USE ppm_std_type_kinds, ONLY: i4
  USE ppm_posix, ONLY: dir_sep, mkdir, ppm_stat, ppm_posix_success, rmdir, &
       stat, &
       strerror
  USE ppm_base, ONLY: abort => abort_ppm
  IMPLICIT NONE
  INTEGER :: i
  INTEGER(i4) :: ierr
  INTEGER, PARAMETER :: max_tries = 200
  ! set to name plus number
  CHARACTER(len=3+3) :: dir_foo
  ! later contains concatenation of dir_foo, dir_sep and "bar"
  CHARACTER(len=3+3+1+3) :: dir_foo_bar
  CHARACTER(len=132) :: msg
  CHARACTER(len=12), PARAMETER :: filename = 'test_posix_f'
  TYPE(ppm_stat) :: dstat
  dir_foo = 'foo'
  DO i = -1, max_tries
    CALL mkdir(dir_foo, ierr)
    IF (ierr == ppm_posix_success) EXIT
    WRITE(dir_foo, '(a,i0)') 'foo', i
  END DO
  IF (ierr /= ppm_posix_success) THEN
    WRITE (msg, '(4a)') 'Cannot create "', TRIM(dir_foo), '": ', &
         TRIM(strerror(ierr))
    CALL abort(msg, filename, __LINE__)
  END IF
  dir_foo_bar = TRIM(dir_foo) // dir_sep // "bar"
  CALL mkdir(dir_foo_bar, ierr)
  IF (ierr /= ppm_posix_success) THEN
    WRITE (msg, '(4a)') 'Cannot create "', TRIM(dir_foo_bar), '": ', &
         TRIM(strerror(ierr))
    CALL abort(msg, filename, __LINE__)
  END IF
  CALL stat(dir_foo, dstat, ierr)
  IF (ierr /= ppm_posix_success) THEN
    WRITE (msg, '(4(a,i0))') 'Cannot stat "', TRIM(dir_foo), '": ', &
         TRIM(strerror(ierr))
    CALL abort(msg, filename, __LINE__)
  END IF
  CALL rmdir(dir_foo_bar, ierr)
  IF (ierr /= ppm_posix_success) THEN
    WRITE (msg, '(4(a,i0))') 'Cannot rmdir "', TRIM(dir_foo_bar), '": ', &
         TRIM(strerror(ierr))
    CALL abort(msg, filename, __LINE__)
  END IF
  CALL rmdir(dir_foo, ierr)
  IF (ierr /= ppm_posix_success) THEN
    WRITE (msg, '(4(a,i0))') 'Cannot rmdir "', TRIM(dir_foo), '": ', &
         TRIM(strerror(ierr))
    CALL abort(msg, filename, __LINE__)
  END IF
END PROGRAM test_posix_f
!
! Local Variables:
! license-project-url: "https://www.dkrz.de/redmine/projects/scales-ppm"
! license-markup: "doxygen"
! license-default: "bsd"
! End:
!