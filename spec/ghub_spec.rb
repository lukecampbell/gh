require 'g-hub'
require 'spec_helper'

describe GHub::GitHub do

    it "should set the base url to github.com" do
        stub_out
        gh = GHub::GitHub.new()
        gh.url.should eq 'https://github.com/'
    end
    
    it "should have the correct base url" do
        stub_out
        gh = GHub::GitHub.new
        gh._remote.should eq 'https://github.com/gituser/repo/'
    end

    it "should have the correct url to the branch" do
        stub_out
        gh = GHub::GitHub.new
        gh.branch.should eq 'https://github.com/gituser/repo/tree/branch'
    end

    it "should raise an error when the remote is not supported" do 
        stub_no_remote
        gh = GHub::GitHub.new
        expect { gh._remote }.to raise_error(StandardError)
    end

end


