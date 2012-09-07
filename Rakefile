require 'date'

current_dir = `pwd`.chomp
home_dir = ENV['HOME']

def rename_with_currenttime(f)
  t = DateTime.now.strftime('%Y%m%d%H%M%S')
  File.rename(f, f + ".#{t}")
end

def create_symlink(src, dst)
  rename_with_currenttime(dst) if File.exists?(dst)
  File.symlink(src, dst)
end

task :zsh do
  zsh_dir = "#{home_dir}/.zsh.d"
  rename_with_currenttime(zsh_dir) if File.exists?(zsh_dir)
  Dir.mkdir(zsh_dir)
  create_symlink("#{current_dir}/zsh/.zshrc",                     "#{home_dir}/.zshrc")
  create_symlink("#{current_dir}/zsh/.zsh.d/init",                "#{zsh_dir}/rc-S00-init")
  create_symlink("#{current_dir}/zsh/.zsh.d/history",             "#{zsh_dir}/rc-S10-history")
  create_symlink("#{current_dir}/zsh/.zsh.d/prompt",              "#{zsh_dir}/rc-S50-prompt")
  create_symlink("#{current_dir}/zsh/.zsh.d/random-color-prompt", "#{zsh_dir}/rc-S51-random-color-prompt")
  create_symlink("#{current_dir}/zsh/.zsh.d/screen",              "#{zsh_dir}/rc-S60-screen")
end
