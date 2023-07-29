dir=webm_videos
#rm -r $dir
mkdir $dir
for VARIABLE in $(ls *.mp4)
do
	#-crf 50 
    #ffmpeg -i ${VARIABLE%%.*}.mp4 ./$dir/${VARIABLE%%.*}.webm
	#ffmpeg -i ${VARIABLE%%.*}.mp4 -codec:v libx265 -codec:a libmp3lame -crf 20 ./$dir/${VARIABLE%%.*}.mp4
	#ffmpeg -i ${VARIABLE%%.*}.mp4 -codec:v vp9 -codec:a libvorbis -crf 20 ./$dir/${VARIABLE%%.*}.webm

	ffmpeg  -i ${VARIABLE%%.*}.mp4 -b:v 0  -crf 40  -pass 1  -an -f webm -y /dev/null
	ffmpeg  -i ${VARIABLE%%.*}.mp4 -b:v 0  -crf 40  -pass 2  ./$dir/${VARIABLE%%.*}.webm

	#ffmpeg -i ${VARIABLE%%.*}.mp4 \
    #    -c:v libvpx-vp9 -b:v 0 -crf 30 -pass 1 -an \
    #    -deadline best -row-mt 1 \
    #    -f null /dev/null && \
	#ffmpeg -i ${VARIABLE%%.*}.mp4 \
    #    -c:v libvpx-vp9 -b:v 0 -crf 30 -pass 2 \
    #    -deadline best -row-mt 1 \
    #    -c:a libopus -b:a 96k -ac 2 \
    #    ./$dir/${VARIABLE%%.*}.webm

done


