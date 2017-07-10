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

task :default => [:bash, :vim, :screen, :zsh, :emacs, :global] do
end

task :bash do
  create_symlink("#{current_dir}/bash/.bash_profile", "#{home_dir}/.bash_profile")
end

task :emacs do
  emacs_dir = "#{home_dir}/.emacs.d"
  Dir.mkdir(emacs_dir) unless File.exists?(emacs_dir)
  create_symlink("#{current_dir}/emacs/.emacs.d/init.el", "#{emacs_dir}/init.el")
end

task :global do
  create_symlink("#{current_dir}/global/.globalrc", "#{home_dir}/.globalrc")
end

task :screen do
  logdir = "#{home_dir}/var/log/screen"
  `mkdir -p #{logdir}`
  create_symlink("#{current_dir}/screen/.screenrc", "#{home_dir}/.screenrc")
end

task :vim do
  create_symlink("#{current_dir}/vim/.vimrc", "#{home_dir}/.vimrc")
end

task :zsh do
  create_symlink("#{current_dir}/zsh/.zshrc", "#{home_dir}/.zshrc")
end
