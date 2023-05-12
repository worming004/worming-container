plugin=$1
version=$2

echo $PATH
asdf plugin add $plugin
asdf install $plugin $version
asdf global $plugin $version
