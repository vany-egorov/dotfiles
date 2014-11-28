Set-Location "D:\vm\debian"

function to-vagrant {
  Invoke-Expression 'ssh egorov@127.0.0.1 -p 2222 -i D:\.ssh\id_rsa'
}

function to-vagrant-as-root {
  Invoke-Expression 'ssh root@127.0.0.1 -p 2222 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-origin-vod01-01-77 {
  # Invoke-Expression 'ssh egorov@10.223.246.215 -p 22 -i D:\.ssh\id_rsa'
  Invoke-Expression 'ssh egorov@10.223.229.215 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-origin-vod02-01-77 {
  # Invoke-Expression 'ssh egorov@10.223.246.216 -p 22 -i D:\.ssh\id_rsa'
  Invoke-Expression 'ssh egorov@10.223.229.216 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-midorigin01-01-78 {
  Invoke-Expression 'ssh egorov@10.223.11.204 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-midorigin03-01-78 {
  Invoke-Expression 'ssh egorov@10.223.11.206 -p 22 -i D:\.ssh\id_rsa'
}

function to-bbl-cdn-fe01-01-77 {
  Invoke-Expression 'ssh egorov@cdn.mts.bradburylab.tv -p 22 -i D:\.ssh\id_rsa'
}

function to-docs-bradburylab-tv {
  Invoke-Expression 'ssh root@docs.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-rm-bradburylab-tv {
  Invoke-Expression 'ssh egorov@rm.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-monitoring-hls-int-bradburylab-tv {
  Invoke-Expression 'ssh egorov@172.16.0.118 -p 2222 -i D:\.ssh\id_rsa'
}

function to-gnc-app02-gnc-bradburylab-tv {
  Invoke-Expression 'ssh egorov@gnc-app02.gnc.bradburylab.tv -p 2222 -i D:\.ssh\id_rsa'
}

function to-gnc-testing-trans00 {
  Invoke-Expression 'ssh egorov@gnc-mon01.gnc.bradburylab.tv -p20160 -i D:\.ssh\id_rsa'
}

function to-bbl-ott-node01-01-77-htv-mts-ru {
  Invoke-Expression 'ssh egorov@10.223.229.233 -i D:\.ssh\id_rsa' 
}

function to-bbl-ott-node02-01-77-htv-mts-ru {
  Invoke-Expression 'ssh egorov@10.223.228.234 -i D:\.ssh\id_rsa'
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

function to-gnc-mon01-gnc-bradburylab-tv-forward-port-prod {
  Invoke-Expression 'ssh -N -f -L 8881:10.253.99.103:80 egorov@gnc-mon01.gnc.bradburylab.tv -p 2222'
}

function to-gnc-mon01-gnc-bradburylab-tv-forward-port-test {
  Invoke-Expression 'ssh -N -f -L 8882:10.253.99.160:80 egorov@gnc-mon01.gnc.bradburylab.tv -p 2222'
}


function to-gnc-mon01-gnc-bradburylab-tv {
  Invoke-Expression 'ssh egorov@gnc-mon01.gnc.bradburylab.tv -p 2222'
}

function run-plantuml {
  Invoke-Expression 'java -jar D:\Downloads\plantuml.jar -v -charset UTF-8 -gui'
}
