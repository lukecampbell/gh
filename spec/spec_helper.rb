#!/usr/bin/env ruby
#

def stub_out
    # Stub the file
    File.stub(:directory? => true)
    
    branch = double('Git::Branch')
    branch.stub(:name => 'branch')
    
    remote = double('Git::Remote')
    remote.stub(:url => 'git@github.com:gituser/repo.git')
    
    g = double('Git')
    Git.stub(:open => g)
    g.stub(:branch => branch)
    g.stub(:remote => remote)
    g.stub(:branches => [branch])
    g.stub(:current_branch => 'branch')
end

def stub_no_remote
    # Stub the file
    File.stub(:directory? => true)
    
    branch = double('Git::Branch')
    branch.stub(:name => 'branch')
    
    remote = double('Git::Remote')
    remote.stub(:url => 'https://firefly.com/remote/')
    
    g = double('Git')
    Git.stub(:open => g)
    g.stub(:branch => branch)
    g.stub(:remote => remote)
    g.stub(:branches => [branch])
    g.stub(:current_branch => 'branch')

end



