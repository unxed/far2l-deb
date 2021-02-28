#!/bin/bash
rm -rf ./lib
mkdir lib
shopt -s globstar
for file in ./**/* ; do
    if file $file | grep ELF > /dev/null; then
        sl="${file//[^\/]}"
        c="${#sl}"
        c=$(expr $c - 1)
        str="\$ORIGIN"
        if [ "$c" -gt "0" ]; then
            for ((i=1; i<=$c; i++)); do
                str="${str}/.."
            done
        fi
        str="${str}/lib"
        #echo $str
        echo $file
        patchelf --remove-rpath $file
        #ldd $file |awk '{if(substr($3,0,1)=="/") print $1,$3}' | cut -d\  -f2 | \
        ldd $file | grep "=> /" | awk '{print $1, $3}' | cut -d\  -f2 | \
        xargs -d '\n' -I{} cp --copy-contents {} ./lib
        patchelf --set-rpath $str $file
    fi
done
for file in ./lib/* ; do
    if file $file | grep ELF > /dev/null; then
        echo $file
        patchelf --remove-rpath $file
        patchelf --set-rpath "\$ORIGIN" $file
    fi
done
