self: super:

{
  aseprite = super.aseprite.overrideAttrs (
    old: rec {
      src = super.fetchFromGitHub {
        owner = "aseprite";
        repo = "aseprite";
        rev = "v1.2.16.3";
        sha256 = "sha256-oIxpwaHHvnztLKlZRyuRKXJc6oTspLpi7ha8f4xJaVk=";
      };

      patches = [
        # (super.fetchpatch {
        #   url = "https://github.com/orivej/aseprite/commit/ea87e65b357ad0bd65467af5529183b5a48a8c17.patch";
        #   sha256 = "1vwn8ivap1pzdh444sdvvkndp55iz146nhmd80xbm8cyzn3qmg91";
        # })
        (./aseprite.patch)
      ];
    }
  );
}
