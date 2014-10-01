Set-Location "D:\vm\debian"

function to-vagrant {
  Invoke-Expression 'ssh vany@127.0.0.1 -p 2222 -i D:\.ssh\id_rsa'
}

function to-vagrant-as-root {
  Invoke-Expression 'ssh root@127.0.0.1 -p 2222 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-origin-vod01-01-77 {
  Invoke-Expression 'ssh egorov@10.223.246.215 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-origin-vod02-01-77 {
  Invoke-Expression 'ssh egorov@10.223.246.216 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-midorigin01-01-78 {
  Invoke-Expression 'ssh egorov@10.223.11.204 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-midorigin03-01-78 {
  Invoke-Expression 'ssh egorov@10.223.11.206 -p 22 -i D:\.ssh\id_rsa'
}

function to-docs-bradburylab-tv {
  Invoke-Expression 'ssh root@docs.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-rm-bradburylab-tv {
  Invoke-Expression 'ssh egorov@rm.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-monitoring-hls-bradburylab-tv {
  Invoke-Expression 'ssh egorov@monitoring-hls.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-gnc-app02-gnc-bradburylab-tv {
  Invoke-Expression 'ssh egorov@gnc-app02.gnc.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-gnc-testing-trans00 {
  Invoke-Expression 'ssh egorov@gnc-mon01.gnc.bradburylab.tv -p20160 -i D:\.ssh\id_rsa'
}

function to-bl-trans01 {
  Invoke-Expression 'ssh egorov@172.16.0.228 -p 2222 -i D:\.ssh\id_rsa'
}

function to-bl-trans02 {
  Invoke-Expression 'ssh egorov@172.16.0.229 -p 2222 -i D:\.ssh\id_rsa'
}

function to-qa-trans00-bradburylab-tv {
  Invoke-Expression 'ssh egorov@qa-trans00.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function run-plantuml {
  Invoke-Expression 'java -jar D:\Downloads\plantuml.jar'
}
