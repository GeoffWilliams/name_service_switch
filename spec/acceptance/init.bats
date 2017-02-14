@test "testcase removed" {
  ! grep 'munted' /etc/nsswitch.conf
}

@test "nsswitch fixed" {
  ! grep -E '^hosts:[[:space]]*files dns' /etc/nsswitch.conf
}
