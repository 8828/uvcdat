C
C	$Id$
C
      SUBROUTINE CSGETD (CNP,DVP)
C
      SAVE
C
      CHARACTER*(*) CNP
      DOUBLE PRECISION DVP
C
C  This subroutine is called to retrieve the real value of a specified
C  parameter.
C
C  CNP is the name of the parameter whose value is to be retrieved.
C
C  DVP is a real variable in which the desired value is to be returned
C  by CSGETR.
C
C  Declare a local character variable in which to form an error message.
C
      CHARACTER*80 CTM
C
      include 'cscomn.h'
C
C Declare the block data routine external to force its loading.
C
      EXTERNAL CSBLDA
C
C  Check for an uncleared prior error.
C
C      IF (ICFELL('CSGETR - Uncleared prior error',1) .NE. 0) RETURN
C
C Check for a parameter name that is too short.
C
      IF (LEN(CNP) .LT. 2) THEN
        CTM(1:36)='CSGETD - Parameter name too short - '
        CTM(37:36+LEN(CNP)) = CNP
C        CALL SETER (CTM(1:36+LEN(CNP)), 1, 1)
        WRITE(6,*) CTM
        GO TO 110
      ENDIF
C
C Get the appropriate parameter value.
C
      IF (CNP(1:3).EQ.'TOL' .OR. CNP(1:3).EQ.'tol' .OR.
     +    CNP(1:3).EQ.'Tol' .OR. CNP(1:3).EQ.'DTL' .OR.
     +    CNP(1:3).EQ.'dtl' .OR. CNP(1:3).EQ.'Dtl') THEN
        DVP = TOLIC
        GO TO 110
      ELSE IF (CNP(1:3).EQ.'TTF' .OR. CNP(1:3).EQ.'ttf' .OR.
     +         CNP(1:3).EQ.'Ttf' .OR. CNP(1:3).EQ.'TTD' .OR.
     +         CNP(1:3).EQ.'ttd' .OR. CNP(1:3).EQ.'Ttd') THEN
        DVP = TOLSG
        GO TO 110
      ELSE IF (CNP(1:3).EQ.'SIG' .OR. CNP(1:3).EQ.'sig' .OR.
     +         CNP(1:3).EQ.'Sig' .OR. CNP(1:3).EQ.'DSG' .OR.
     +         CNP(1:3).EQ.'dsg' .OR. CNP(1:3).EQ.'Dsg') THEN
        DVP = USSIG
        GO TO 110
      ELSE IF (CNP(1:3).EQ.'MVL' .OR. CNP(1:3).EQ.'mvl' .OR. 
     +         CNP(1:3).EQ.'Mvl' .OR. CNP(1:3).EQ.'DMV' .OR.
     +         CNP(1:3).EQ.'dmv' .OR. CNP(1:3).EQ.'Dmv') THEN
        RVP = RMVAL
        GO TO 110
      ELSE
        CTM(1:36) = 'CSGETD - Parameter name not known - '
        CTM(37:39) = CNP(1:3)
C        CALL SETER (CTM(1:39), 2, 1)
        WRITE(6,*) CTM
        GO TO 110
      ENDIF
C
  110 CONTINUE
      RETURN
      END
