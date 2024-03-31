final: prev: { setup-haskell-project =
  prev.setup-haskell-project.defaultPackage.${final.system}; }
