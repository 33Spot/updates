dir=compress_video
mkdir $dir
for i in *.mov; do
  ffmpeg -y -i $i ./$dir/${i%%.*}.mp4
done
for i in *.MOV; do
  ffmpeg -y -i $i ./$dir/${i%%.*}.mp4
done
