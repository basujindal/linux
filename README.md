# linux

## Clear boot space

### Take a look at /boot. Ubuntu has the tendency to clog this directory with old kernels. If there are some, you can look what can be cleaned up with

``` bash
sudo dpkg -l linux-* | awk '/^ii/{ print $2}' | grep -v -e `uname -r | \cut -f1,2 -d"-"` | grep -e [0-9] | xargs sudo apt-get --dry-run remove
```

If you are satisfied with the result you can delete them with this command:

```bash
sudo dpkg -l linux-* | awk '/^ii/{ print $2}' | grep -v -e `uname -r | \cut -f1,2 -d"-"` | grep -e [0-9] | xargs sudo apt-get -y purge
```

---

### Try to use this command to get top 20 largest files

`du -max / | sort -rn | head -20`

### To remove obsoleted packages (as well as old kernels)

`sudo apt-get autoremove`

---

### Find largest packages

```bash
dpkg-query --show --showformat='${Package;-50}\t${Installed-Size}\n' | sort -k 2 -n | grep -v deinstall | awk '{printf "%.3f MB \t %s\n", $2/(1024), $1}'
```

### Clear journal to 500MB, was 4 GB in my case

`sudo journalctl --vacuum-size=500M`

