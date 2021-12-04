
export PATH=/home/anant/scripts:$PATH

#count=0
if [ -z "${DIPLAY}"] && [ "${XDG_VTNR}" -eq 1 ] && [ "$count" -eq 0 ];
then
	#count=1
	startx
fi


