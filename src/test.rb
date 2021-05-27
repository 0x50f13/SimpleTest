$LOAD_PATH<<"."
$LOAD_PATH<<File.dirname(__FILE__)

GREEN = "\033[32m"
BLUE = "\033[34m"
ORANGE = "\033[33m"
RED = "\033[31m"
ENDC = "\033[39m\033[0m"
BOLD = "\033[1m" 

module Tests
  class <<self
    attr_accessor :tests_status
  end
  tests_status = Hash.new()
end

def usage(argv)
    puts("Usage: "+argv[0]+" [DIR]")
end

def main(argv)
    if argv.length() < 1 then
       puts("Not enough arguments")
       return -1
    end

    if argv[0] == "-h" or argv[0] == "--help"
       usage(argv)
       return -1
    end

    dir = argv[0]
    test_files = Dir.glob("#{dir}/test_*.rb")
    test_files.each do |fname|
       require fname
    end
    
    test_functions = []
    tests = Tests.methods - Object.methods
    tests.each do |symbol|
       name = symbol.to_s
       if name.start_with?("test_") then
          test_functions << symbol
       end
    end

    puts("Collected #{test_functions.length} tests.")
    
    n_pass = 0
    n_fail = 0
    n_total = test_functions.length()

    test_functions.each do |fname|
      print("Testing #{BOLD}#{fname}#{ENDC}...") 
      begin
         result = Tests.send(fname)  
         if result then
           n_pass+=1
           puts("#{GREEN}PASS#{ENDC}")
         else
           n_fail+=1
           puts("#{RED}FAIL#{ENDC}")
         end
      rescue StandardError => e
          puts("#{RED}FAIL#{ENDC}")
          puts("Exception has occured")
          puts("-----EXCEPTION TRACE BEGIN-----")
          puts(e.message)
          puts(e.trace.inspect)
          puts("-----EXCEPTION TRACE END-----")
      end             
    end

    puts("Failed tests: #{n_fail} out of #{n_total}")
    puts("Passed tests: #{n_pass} out of #{n_total}")
    if n_fail > 0 then
       return -1
    end
    0
end
exit(main(ARGV))
