require "open3"

module Ykxutils
  module_function

  def func_git_log(target_line)
    line_no = 1
    buf = []
    buf_error = []
    prog = "git log --oneline"
    _stdin, stdout, stderr = Open3.popen3(prog)
    stdout.each do |line|
      buf << line
      break if line_no == target_line

      line_no += 1
    end
    stderr.map do |line_e|
      buf_error << line_e
    end

    [buf, buf_error]
  end

  def func_get_commit_id(target)
    commit_id = ""
    buf, buf_error = func_git_log(target)
    puts buf_error
    index = target - 1
    str = buf[index]
    commit_id = str.split.first if str

    commit_id
  end

  def func_git_diff_tree(commit_id)
    buf = []
    return buf if commit_id == ""

    prog = "git diff-tree --name-status -r #{commit_id}"
    _stdin, stdout, _stderr = Open3.popen3(prog)
    stdout.each do |line|
      buf << line
    end

    buf
  end

  def func_get_files_from_commit(target)
    commit_id = func_get_commit_id(target)
    # puts commit_id
    buf = func_git_diff_tree(commit_id)

    lines = buf.grep_v(/^D/)
    lines.map { |x| x.split[1] }
    # files.map{|x| puts x}
  end
end
