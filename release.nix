{ nixpkgs ? import ./nixpkgs.nix { }
}:

with nixpkgs;

let
  channel = rustChannelOf { date = "2019-11-25"; channel = "nightly"; };
  targets = [ "wasm32-unknown-unknown" ];
in rec {
  rust = channel.rust.override { inherit targets; };
  substrate-ros-msgs = callPackage ./substrate-ros/msgs/substrate_ros_msgs { };
  robonomics-msgs = callPackage ./robonomics/msgs/robonomics_msgs { };

  turtlesim = callPackage ./examples/turtlesim_liability { msgs = robonomics-msgs; };
  ros_tutorials = callPackage ./examples/ros_tutorials { };
  node = callPackage ./. { inherit rust substrate-ros-msgs robonomics-msgs; };
}
