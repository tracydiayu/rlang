context("encoding")

test_that("can roundtrip symbols in non-UTF8 locale", {
  with_non_utf8_locale({
    expect_identical(
      as_string(sym(get_alien_lang_string())),
      get_alien_lang_string()
    )
  })
})

test_that("Unicode escapes are always converted to UTF8 characters on roundtrip", {
  expect_identical(
    as_string(sym("<U+5E78><U+798F>")),
    "\u5E78\u798F"
  )
})

test_that("Unicode escapes are always converted to UTF8 characters in as_list()", {
  with_non_utf8_locale({
    env <- child_env(empty_env())
    env_bind(env, !! get_alien_lang_string() := NULL)
    list <- as_list(env)
    expect_identical(names(list), get_alien_lang_string())
  })
})

test_that("Unicode escapes are always converted to UTF8 characters with env_names()", {
  with_non_utf8_locale({
    env <- child_env(empty_env())
    env_bind(env, !! get_alien_lang_string() := NULL)
    expect_identical(env_names(env), get_alien_lang_string())
  })
})

test_that("Unicode escapes are always converted to UTF8 in quos()", {
  q <- quos(`<U+5E78><U+798F>` = 1)
  expect_identical(names(q), "\u5e78\u798f")
})
