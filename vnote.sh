#!/bin/bash
#按日期创建txt文档并使用vim打开。

mkdir -p ~/.mynotes
dir=~/.mynotes

file=$dir/$(ls $dir -t|head -n 1)

if [ "$1" = "-a" ] ;then
    if [ "$2" ];then
        file=$dir/$2
    else
        file=$dir/$(date "+%m_%d-%H:%M").txt
    fi
    touch $file
    echo "title:" >> $file
elif [ "$1" = "-l" ] ;then
    let i=0
    filelist=(0)
    
    for f in $(ls $dir -t);do
        let i=i+1
        filelist[i]="$f"
        file=$dir/$f
        title=$(cat $file| grep title)
        title=${title##*:}
        echo "$i ${filelist[i]}    $title"
    done
    
    echo "输入序号选择打开文件"
    read -a select
    if [ "$select" = "" ] ;then
        exit
    elif [[ ("$select" > $i || "$select" < 1 ) ]] ;then
        echo "文件不存在"
        exit
    fi
    file=$dir/${filelist[$select]}
elif [ "$1" = "-d" ] ;then
    let i=0
    filelist=(0)
    
    for f in $(ls $dir -t);do
        let i=i+1
        filelist[i]="$f"
        file=$dir/$f
        title=$(cat $file| grep title)
        title=${title##*:}
        echo "$i ${filelist[i]}    $title"
    done

    echo "输入序号删除文件"
    read -a select
    if [ "$select" = "" ] ;then
        exit
    else
        file=$dir/${filelist[$select]}
        rm $file
        exit
    fi
elif [ "$1" ] ;then
    echo "usage: nt [-l] [-a [filename]] [-d]"
    echo "默认打开最近修改的笔记" 
    echo "-a [filename]:新建笔记，默认以时间命名"
    echo "-l:列出所有笔记，并选择打开" 
    echo "-d:列出所有笔记，并选择删除"
    exit
fi

vim $file

size=`echo $(wc $file -m) | head -n 1 | awk -F ' ' '{print $1}'`
if [[ $size == 7 ]] ;then
    echo "remove"
    rm $file
fi


