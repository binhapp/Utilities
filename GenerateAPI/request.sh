cd zRequest
for file in *.sh; do
    file_name=${file:0:${#file}-3}
    sh $file > "../zResponse/$file_name.json"
done
cd ..
