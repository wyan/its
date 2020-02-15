	title cono pi hack hack test

;Expected:
;1. output X to TTY
;2. get done interrupt on pia2
;3. execute blko, output Y to TTY
;4. blko overflows, execute cono pi to raise interrupt on pia1
;5. execute jsr win because still in overflow cycle


apr==0
pi==4
tty==120

pia1==4
pia2==6

;io reset
a%ini=200000
;clear pi, enable pi, enable channels
p%ini=12200+200_<-pia1>+200_<-pia2>

loc 40+2*pia1
	jsr lose
	jsr win

loc 40+2*pia2
	blko tty,blkop
	cono pi,4000+200_<-pia1>

loc 100
go:	cono apr,a%ini
	cono pi,p%ini
	cono tty,pia2		;assign pi channel
	datao tty,["X]		;output X
	jrst .			;wait for interrupt

lose:	halt .

win:	datao tty,["Z]
	halt .

blkop:	-1,,["Y]-1

end go
