
#cmd unarchive ${{
  #case "$f" in
      #*.zip) unzip "$f" ;;
      #*.rar) unar "$f" ;;
      #*.tar.gz) tar -xzvf "$f" ;;
      #*.tar.bz2) tar -xjvf "$f" ;;
      #*.tar) tar -xvf "$f" ;;
      #*) echo "Unsupported format" ;;
  #esac
#}}
