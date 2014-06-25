# chcp 65001
chcp 1251
Set-Location "D:\vm\debian-7.4"

function to-vagrant() {
  Invoke-Expression 'ssh vany@localhost -p 2222 -i D:\Documents\SSL.SSH\.ssh\id_rsa'
}
