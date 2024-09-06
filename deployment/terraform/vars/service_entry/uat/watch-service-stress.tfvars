service_entry = {
  svc01 = {
    hosts         = "auth.gonoise.com"
    resolution    = "NONE"
    name          = "https"
    number        = "443"
    protocol      = "TCP"
  },
  svc02 = {
    hosts         = "api.facebook.com"
    resolution    = "NONE"
    name          = "https"
    number        = "443"
    protocol      = "TCP"
  },
  svc03 = {
    hosts         = "master.gonoise.com"
    resolution    = "NONE"
    name          = "https"
    number        = "443"
    protocol      = "HTTPS"
  }
}