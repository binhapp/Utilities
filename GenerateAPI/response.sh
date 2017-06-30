destination_path="../../../Example/Utilities/API"
generate="../swiftyjsonaccelerator generate -p "

cd zResponse
for file in *.json; do
    prefix=${file:0:${#file}-5}
    mkdir $prefix
    cp $file $prefix/.json
    echo '
    {
        "prefix": "'$prefix'",
        "destination_path": "'$destination_path'/'$prefix'",
        "author_name": "blcsntb",
        "company_name": "BLCS",
        "construct_type": "class",
        "model_mapping_library": "SwiftyJSON",
        "support_nscoding": false,
        "is_final_required": true,
        "is_header_included": false
    }
    ' > "$prefix/.config.json"
    $generate $prefix
    rm -rf $prefix
done
cd ..
