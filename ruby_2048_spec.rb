require './ruby_2048'

describe R2048 do
  before(:each) do
  	@r2048 = R2048.new
  end
  it "should jump to [2, 0, 0, 0] when input [0, 0, 0, 2]" do  
    @r2048.set_jump_step([0, 0, 0, 2]).should == [2, 0, 0, 0]
  end
 
  it "should jump to [2, 4, 0, 0] when input [2, 0, 4, 0]" do
  	@r2048.set_jump_step([2, 0, 4, 0]).should == [2, 4, 0, 0]
  end
 
  it "should jump to [4, 0, 0, 0] when input [2, 0, 2, 0]" do
  	@r2048.set_jump_step([2, 0, 2, 0]).should == [4, 0, 0, 0]
  end
 
  it "should jump to [2, 4, 4, 0] when input [2, 4, 2, 2]" do
  	@r2048.set_jump_step([2, 4, 2, 2]).should == [2, 4, 4, 0]
  end
 
  it "should jump to [4, 4, 0, 0] when input [2, 2, 2, 2]" do
  	@r2048.set_jump_step([2, 2, 2, 2]).should == [4, 4, 0, 0]
  end
 
 
 
  it "should + 1 chess if generate_init_num" do
  	expect { @r2048.generate_init_num }.to change{@r2048.chessboard.flatten.count{|chess| chess!= 0} }.by(1)  
  end
 
  it "should have already have two chess when inited" do
  	expect{@r2048.count} == 2
  end
end
