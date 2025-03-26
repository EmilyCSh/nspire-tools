{
	description = "nspire tools";

	inputs = {
		flake-parts.url = "github:hercules-ci/flake-parts";
		libnspire.url = "github:BrianNormant/libnspire";
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	};

	outputs = inputs @ {nixpkgs, flake-parts, libnspire, ...}:
	flake-parts.lib.mkFlake {inherit inputs;} {
		systems = ["x86_64-linux"];
		perSystem = {pkgs, system, inputs', ... }: {
			packages.default = pkgs.buildDubPackage {
				pname = "nspire-tools";
				version = "v0.0.3";
				src = ./.;
				buildInputs = [inputs'.libnspire.packages.default];
				dubLock = ./dub-lock.json;
				installPhase = ''
				install -Dm755 nspire-tools -t $out/bin
				'';
			};
		};
	};
}
