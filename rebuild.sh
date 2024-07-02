sudo docker compose down
start_dir=$(pwd)

find . -type d | while read dir; do
    if [ -d "$dir/.git" ]; then
        echo "Updating $dir"
        (cd "$dir" && git pull)
        cd "$start_dir"
    fi
done

sudo docker compose up --build -d
