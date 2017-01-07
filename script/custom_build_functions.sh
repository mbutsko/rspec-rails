function travis_retry_on_187 {
  if is_mri_192_plus; then
    "$@"
  else
    travis_retry "$@"
  fi
  return $?
}

function run_cukes {
  travis_retry_on_187 bin/rake acceptance --trace
}

# rspec-rails depends on all of the other rspec repos. Conversely, none of the
# other repos have any dependencies with rspec-rails directly. If the other
# repos have issues, the rspec-rails suite and cukes would fail exposing them.
# Since we are already implicitly testing them we do not need to run their spec
# suites explicitly.
function run_all_spec_suites {
  fold "one-by-one specs" run_specs_one_by_one
}
