defmodule BiddingWeb.BidView do
  use BiddingWeb, :view


def button(style) do
	raw("<div class='btn btn-#{style}'>Button</div>")
end
  
end
