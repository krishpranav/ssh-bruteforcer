#!/usr/bin/env/ruby
require 'net-ssh'
require 'slop'
$banner=" SSH BRUTE FORCER"

def parse()
    $options = Slop.parse suppress_errors: true do |argument|
     argument.string 'host', 'IP of server(default-localhost)',required:true
     argument.integer '-p','--port', 'Custom port', default: 22
     argument.string '-u', '--user', 'Username(default-root)',default: 'root', required:true
     argument.string '-w','--wordlist','Path to wordlist(default-john dictionary)',default: "dic/john.txt"
     argument.bool '-v', '--verbose', 'Enable verbose', default: false
     argument.on '--help' do 
      print (argument)
      exit()
     end
    end
   end