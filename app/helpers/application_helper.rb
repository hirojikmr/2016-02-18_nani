module ApplicationHelper
  
  def pick_eff

    %w(
      hvr-grow
      hvr-shrink
      hvr-pulse
      hvr-pulse-grow
      hvr-pulse-shrink
      hvr-push
      hvr-pop
      hvr-bounce-in
      hvr-bounce-out
      hvr-rotate
      hvr-grow-rotate
      hvr-float
      hvr-sink
      hvr-bob
      hvr-hang
      hvr-skew
      hvr-skew-forward
      hvr-skew-backward
      hvr-wobble-horizontal
      hvr-wobble-vertical
      hvr-wobble-to-bottom-right
      hvr-wobble-to-top-right
      hvr-wobble-top
      hvr-wobble-bottom
      hvr-wobble-skew
      hvr-buzz
      hvr-buzz-out
    ).sample

  end
end
