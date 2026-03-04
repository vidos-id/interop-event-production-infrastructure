terraform {
  required_version = ">= 1.6.0"

  required_providers {
    vidos = {
      source  = "registry.terraform.io/vidos-id/vidos"
      version = "~> 0.1"
    }
  }
}

provider "vidos" {
  region = var.vidos_region

  # required (or set VIDOS_API_KEY)
  api_key = var.vidos_api_key
}

locals {
  # Example PEM-encoded root certificates for validator trust anchors.
  valera_test_certificate = trimspace(<<-PEM
-----BEGIN CERTIFICATE-----
MIICGzCCAcCgAwIBAgIUb9GJdqQMdwXaoO61uxoBlg+jhbYwCgYIKoZIzj0EAwIw
LDELMAkGA1UEBhMCQVQxDjAMBgNVBAoMBUEtU0lUMQ0wCwYDVQQDDARJQUNBMB4X
DTI1MDQwNzA5NDQ1N1oXDTI2MDQwNzA5NDQ1N1owLDELMAkGA1UEBhMCQVQxDjAM
BgNVBAoMBUEtU0lUMQ0wCwYDVQQDDARJQUNBMFkwEwYHKoZIzj0CAQYIKoZIzj0D
AQcDQgAElIXOzb+iF+zGutygdIVOBnC4R6OvhYo5TGWhrH0idmqs56IVwJWYzQYz
K4CbYePcxpMQY3lKBa5O0MAZe+EogKOBvzCBvDASBgNVHRMBAf8ECDAGAQH/AgEA
MA4GA1UdDwEB/wQEAwIBBjAiBgNVHRIEGzAZhhdodHRwczovL3dhbGxldC5hLXNp
dC5hdDAyBgNVHR8EKzApMCegJaAjhiFodHRwczovL3dhbGxldC5hLXNpdC5hdC9j
cmwvMS5jcmwwHwYDVR0jBBgwFoAUDQF5K46YVgzLpfV5stoutBezK6QwHQYDVR0O
BBYEFA0BeSuOmFYMy6X1ebLaLrQXsyukMAoGCCqGSM49BAMCA0kAMEYCIQCz0i9G
A24ZOf3Wk+w8+09J6ARAHKLuBuepszBxVZdaZAIhAJlgzKBhHw8+Bwr+wLGQVjMC
5e9BWWaUga8ZP9dRYhHJ
-----END CERTIFICATE-----
  PEM
  )

  igrant_sd_jwt = trimspace(<<-PEM
-----BEGIN CERTIFICATE-----
MIIB6zCCAZKgAwIBAgIUMUue15RHkRkqRygdNSNsUv2PJQwwCgYIKoZIzj0EAwIw
QjELMAkGA1UEBhMCU0UxCzAJBgNVBAgMAlNFMRIwEAYDVQQKDAlpR3JhbnQuaW8x
EjAQBgNVBAMMCVNELUpXVCBDQTAeFw0yNjAzMDIwMTMyNTBaFw0zNjAyMjgwMTMy
NTBaMEIxCzAJBgNVBAYTAlNFMQswCQYDVQQIDAJTRTESMBAGA1UECgwJaUdyYW50
LmlvMRIwEAYDVQQDDAlTRC1KV1QgQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNC
AATDCLxTbOv8KmS18+4RL3xeeut9eVqn+76M2G0rvUaElT/1uOwoqxNOh1pZ9g6b
ClHnUziWWLOt/Vq6HGqD6YuSo2YwZDAdBgNVHQ4EFgQU0AxeLNcDd1SS3dV/OEWM
XKx+rX8wHwYDVR0jBBgwFoAU0AxeLNcDd1SS3dV/OEWMXKx+rX8wEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAQYwCgYIKoZIzj0EAwIDRwAwRAIgQVz/
u5HRvY23b5PRI7Vu9qXREjEcqTy+MObkvKtADCMCIBydUc9rRhRd58ajfRmfwBJv
GTi6Mr2SZXToF2FBWAe4
-----END CERTIFICATE-----
  PEM
  )

  igrant_mdoc_iaca = trimspace(<<-PEM
-----BEGIN CERTIFICATE-----
MIIB7DCCAZKgAwIBAgIUcJPNWQ3pXu3t+TOrwY5NONw6aIIwCgYIKoZIzj0EAwIw
QjELMAkGA1UEBhMCU0UxCzAJBgNVBAgMAlNFMRIwEAYDVQQKDAlpR3JhbnQuaW8x
EjAQBgNVBAMMCW1kb2MgSUFDQTAeFw0yNjAzMDIwMTMyNTFaFw0zNjAyMjgwMTMy
NTFaMEIxCzAJBgNVBAYTAlNFMQswCQYDVQQIDAJTRTESMBAGA1UECgwJaUdyYW50
LmlvMRIwEAYDVQQDDAltZG9jIElBQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNC
AAQa4mYRKJMF1RvdiP+IE4PexqrzCTDQouEKR4ZBhSdEn5GG4CmgooKe7jmCvHGu
QYmOsq4AjKIe3hKZWtF3vUjYo2YwZDAdBgNVHQ4EFgQUzMXYYcysH4qWtYShEoOX
JNRHdZkwHwYDVR0jBBgwFoAUzMXYYcysH4qWtYShEoOXJNRHdZkwEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAQYwCgYIKoZIzj0EAwIDSAAwRQIhAKe+
2U+WKw5onyhiajffOFwgHdSJ5UeJ1+dJl7Bnd/PXAiAiU3llUrcVOysFcjvYHAWh
j/C8CPRpR5CzvSXEiUz5WA==
-----END CERTIFICATE-----
  PEM
  )

  idakto  = trimspace(<<-PEM
  -----BEGIN CERTIFICATE-----
MIIB2TCCAX+gAwIBAgIJAI5LEB+QbO+3MAoGCCqGSM49BAMCMCUxCzAJBgNVBAYT
AkZSMRYwFAYDVQQDDA1JREFLVE8gSUFDQSA0MB4XDTI0MDkyNjEyMzQ1M1oXDTI5
MDkyNTEyMzQ1M1owJTELMAkGA1UEBhMCRlIxFjAUBgNVBAMMDUlEQUtUTyBJQUNB
IDQwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAARMophaPOvIcnsKuxs3iGxJA3ky
Qx3pHeC0LWj8RNPLtYWAcPJq8bB5PSyOkGtB6XcGUTJukaBxU//5cAe2I18po4GX
MIGUMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQW
BBS2EQayXDKCQSR99d/ve3ZXwxWPpzAaBgNVHRIEEzARgQ9pYWNhQGlkYWt0by5j
b20wMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5jaG9wcGVyLmlkbGFiLmxp
dmU6NTU1NTAKBggqhkjOPQQDAgNIADBFAiAX1wM1La0uufb2yA4jZ+11FfF6hcx3
ER8/kcC52teviQIhALNwfW4Zusu4QD8QFxRKrLyi8UVWpDXI5G7rHRnIbNPf
-----END CERTIFICATE-----
  PEM
  )

  eudi_test_issuer = trimspace(<<-PEM
-----BEGIN CERTIFICATE-----
MIIC3TCCAoOgAwIBAgIUEwybFc9Jw+az3r188OiHDaxCfHEwCgYIKoZIzj0EAwMw
XDEeMBwGA1UEAwwVUElEIElzc3VlciBDQSAtIFVUIDAyMS0wKwYDVQQKDCRFVURJ
IFdhbGxldCBSZWZlcmVuY2UgSW1wbGVtZW50YXRpb24xCzAJBgNVBAYTAlVUMB4X
DTI1MDMyNDIwMjYxNFoXDTM0MDYyMDIwMjYxM1owXDEeMBwGA1UEAwwVUElEIElz
c3VlciBDQSAtIFVUIDAyMS0wKwYDVQQKDCRFVURJIFdhbGxldCBSZWZlcmVuY2Ug
SW1wbGVtZW50YXRpb24xCzAJBgNVBAYTAlVUMFkwEwYHKoZIzj0CAQYIKoZIzj0D
AQcDQgAEesDKj9rCIcrGj0wbSXYvCV953bOPSYLZH5TNmhTz2xa7VdlvQgQeGZRg
1PrF5AFwt070wvL9qr1DUDdvLp6a1qOCASEwggEdMBIGA1UdEwEB/wQIMAYBAf8C
AQAwHwYDVR0jBBgwFoAUYseURyi9D6IWIKeawkmURPEB08cwEwYDVR0lBAwwCgYI
K4ECAgAAAQcwQwYDVR0fBDwwOjA4oDagNIYyaHR0cHM6Ly9wcmVwcm9kLnBraS5l
dWRpdy5kZXYvY3JsL3BpZF9DQV9VVF8wMi5jcmwwHQYDVR0OBBYEFGLHlEcovQ+i
FiCnmsJJlETxAdPHMA4GA1UdDwEB/wQEAwIBBjBdBgNVHRIEVjBUhlJodHRwczov
L2dpdGh1Yi5jb20vZXUtZGlnaXRhbC1pZGVudGl0eS13YWxsZXQvYXJjaGl0ZWN0
dXJlLWFuZC1yZWZlcmVuY2UtZnJhbWV3b3JrMAoGCCqGSM49BAMDA0gAMEUCIQCe
4R9rO4JhFp821kO8Gkb8rXm4qGG/e5/Oi2XmnTQqOQIgfFs+LDbnP2/j1MB4rwZ1
FgGdpr4oyrFB9daZyRIcP90=
-----END CERTIFICATE-----
  PEM
  )
}

resource "vidos_validator_instance" "authorizer" {
  name = "terraform-example-validator-instance"

  inline_configuration = jsonencode({
    policies = {
      # Enforce that issuers chain to one of these roots.
      trustedIssuer = {
        skip = false
        trustedIssuerRootCertificates = [
          { type = "predefined", tag = "vidos" },
          { type = "predefined", tag = "french-iaca-sandbox" },
          { type = "pem", pem = local.valera_test_certificate },
          { type = "pem", pem = local.igrant_sd_jwt },
          { type = "pem", pem = local.igrant_mdoc_iaca },
          { type = "pem", pem = local.eudi_test_issuer },
          { type = "pem", pem = local.idakto },
          { type = "vical-url", url = "https://unfold.mdoc.online/trustedlists/Vical.vical", vicalTrustedCertificates = [] },
        ]
      }
    }
  })
}

resource "vidos_verifier_instance" "authorizer" {
  name = "terraform-example-verifier-instance"
}

resource "vidos_authorizer_instance" "eudiw_unfold" {
  name = "terraform-example-authorizer-instance"

  inline_configuration = jsonencode({
    policies = {
      validate = {
        validator = {
          type       = "instance"
          resourceId = vidos_validator_instance.authorizer.resource_id
          serviceRole = {
            owner      = "managed"
            resourceId = "validator_all_actions"
          }
        }
      }

      verify = {
        verifier = {
          type       = "instance"
          resourceId = vidos_verifier_instance.authorizer.resource_id
          serviceRole = {
            owner      = "managed"
            resourceId = "verifier_all_actions"
          }
        }
      }
    }
  })
}

resource "vidos_gateway_instance" "eudiw_unfold" {
  name        = "terraform-gateway-instance-eudiw-unfold"
  resource_id = "eudiw-unfold"


  inline_configuration = jsonencode({
    cors = {
      enabled      = true
      allowHeaders = ["*"]
      origin       = ["*"]
    }

    paths = {
      # Requests to /auth/* are forwarded to the authorizer instance.
      auth = {
        type       = "instance"
        service    = "authorizer"
        resourceId = vidos_authorizer_instance.eudiw_unfold.resource_id
        serviceRole = {
          owner      = "managed"
          resourceId = "authorizer_all_actions"
        }
      }
    }
  })
}
