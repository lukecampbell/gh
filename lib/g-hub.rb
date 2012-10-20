#!/usr/bin/env ruby

require 'git'

module GHub
    class GitHub
        attr_reader :url
        def initialize(remote=nil, branch=nil, url='https://github.com/')
            if File.directory? '.git'
                @g = Git.open('./')
            else
                git_dir = `cat .git`.split('gitdir: ')[1].chomp()
                @g = Git.open('./', :repository => git_dir, :index => git_dir + '/index')
            end
            @remote = @g.remote(remote || 'origin')
            if @g.branches.to_a.any? {|b| b.name == branch}
                @branch = @g.branch(branch)
            else
                @branch = @g.branch(@g.current_branch)
            end
            @url    = url
        end

        def compare(end_branch=nil, begin_branch=nil)
            if not end_branch
                end_branch = @branch.name
            end

            if not begin_branch
                url = self._remote + 'compare/' + end_branch
            else
                c_end = @g.branch(end_branch).gcommit.sha
                c_begin = @g.branch(begin_branch).gcommit.sha

                url = self._remote + 'compare/' + c_begin + '...' + c_end
            end
            return url
            
        end

        def file(file, line1=nil, line2=nil)
            url = self._remote + 'blob/' + @branch.name + '/' + file
            if line1
                url += '#L' + line1.to_s
            end
            if line2
                url += '-' + line2.to_s
            end
            return url
        end

        def pulls(num=nil)
            return self.pull(num)
        end

        def pull(num=nil)
            url = self._remote + 'pulls/'
            if num
                url = self._remote + 'pull/' + num.to_s
            end
            return url
        end

        def show(commit)
            if commit.include? 'HEAD'
                commit = `git rev-parse #{commit}`
            end

            commit = commit || @branch.gcommit.sha
            url = self._remote + 'commit/' + commit
            return url
        end

        def remote()
            url = self._remote
            return url
        end

        def _remote()
            remote_url = @g.remote(@remote).url
            if remote_url.include? '@'
                remote_url = @url + remote_url.split(':')[1]
            elsif remote_url.include? 'github.com/'
                remote_url = @url + remote_url.split('github.com/')[1]
            else
                raise StandardError, 'Failed to determine _remote'
            end
            remote_url = remote_url.sub('.git','/')
            return remote_url
        end
        def _branch()
            @branch
        end
        def branch()
            url = self._remote + 'tree/' + @branch.name
            return url
        end

    end
end


