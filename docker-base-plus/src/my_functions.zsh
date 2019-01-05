#Define exit procedure
my_exit() {
    echo "Container killed, saving..."
    cp "$HOME/.z" $HOME/shared_folder/.z
    sleep 1
}
trap my_exit EXIT
