# dotfiles

# Setup

```bash
  curl https://raw.githubusercontent.com/alfred-institute/dotfiles/main/setup | /bin/bash
```

# Scripts

## WSL Management

### Get WSL Port
```powershell
  ./scripts/get_wsl_ip.ps1 -distro <distro>
```

### Forward Port to WSL Port

```powershell
  ./scripts/forward_port_to_wsl -distro <distro> -port <port>
 ```

### SSH Into WSL

```powershell
   ./scripts/ssh_into_wsl.ps1 -distro <distro> -port <port> -user <user>
 ```


