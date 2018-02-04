require "curses"
require "./ruby_2048"

include Curses

init_screen

begin
  crmode
  R2048.new.run
ensure
  close_screen
end
