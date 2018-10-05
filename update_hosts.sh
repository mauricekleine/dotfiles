if command grep -qc '#=====END SOMEONEWHOCARES=====#' /etc/hosts; then
  cat /etc/hosts | sed -e/=====END\ SOMEONEWHOCARES=====/\{ -e:1 -en\;b1 -e\} -ed  > ./hosts.backup # backup any existing host file
  curl -fsSL "https://someonewhocares.org/hosts/hosts" > ./hosts # download latest
  cat ./hosts.backup >> ./hosts # append the backup host file to the new host file
  cp ./hosts /etc/hosts # make the new hosts file the default
  rm ./hosts # remove, but keep the backup
fi
