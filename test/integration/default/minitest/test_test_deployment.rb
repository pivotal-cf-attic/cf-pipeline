require 'minitest/autorun'
require 'tmpdir'

describe "test_deployment script" do
  it "calls script/run_system_tests" do
    Dir.mktmpdir do |dir|
      Dir.chdir dir do
        FileUtils.mkdir 'script'
        write_fake_system_test_script('script/run_system_tests')

        system('test_deployment > out')

        assert_equal "Hello from system tests", File.read('out').strip
      end
    end
  end

  def write_fake_system_test_script(path)
    File.open(path, 'w') do |file|
      file << <<-'EOF'
#!/usr/bin/env ruby

puts 'Hello from system tests'
      EOF
    end

    FileUtils.chmod 0755, path
  end
end