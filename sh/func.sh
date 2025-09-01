# organize cloning to ~/gh folder
ghc() {
  repo_url="$1"
  repo_url="${repo_url%.git}"

  # Extract user and repo with sed
  user=$(echo "$repo_url" | sed -E 's#(git@github.com:|https://github.com/)([^/]+)/([^/]+)#\2#')
  repo=$(echo "$repo_url" | sed -E 's#(git@github.com:|https://github.com/)([^/]+)/([^/]+)#\3#')

  if [ -z "$user" ] || [ -z "$repo" ]; then
    echo "❌ Could not parse: $repo_url"
    return 1
  fi

  dest="$HOME/gh/$user/$repo"
  echo "Cloning into: $dest"
  mkdir -p "$(dirname "$dest")"
  git clone "$1" "$dest"
}
