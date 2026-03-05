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

  thales_interop_2023_iaca = trimspace(<<-PEM
 -----BEGIN CERTIFICATE-----
MIIC2jCCAoCgAwIBAgIUbwYRRTaFwEbfFVrYLdVvK4SHo8EwCgYIKoZIzj0EAwIw
XDELMAkGA1UEBhMCQ1oxCzAJBgNVBAgMAkNaMQ8wDQYDVQQKDAZUaGFsZXMxDDAK
BgNVBAsMA0RJUzEhMB8GA1UEAwwYVGhhbGVzIEludGVyb3AgMjAyMyBJQUNBMB4X
DTIzMDgxNzEwMzYzNVoXDTMzMDgxNDEwMzYzNVowXDELMAkGA1UEBhMCQ1oxCzAJ
BgNVBAgMAkNaMQ8wDQYDVQQKDAZUaGFsZXMxDDAKBgNVBAsMA0RJUzEhMB8GA1UE
AwwYVGhhbGVzIEludGVyb3AgMjAyMyBJQUNBMFkwEwYHKoZIzj0CAQYIKoZIzj0D
AQcDQgAExqAZg984per+IzzDGEoZllLknp9hhosfoOM77fwa7FPQjXAAJ0wyNzNc
QfGY+bJ5+ZYZJTORSeJVoYlhsRGTXqOCAR4wggEaMB0GA1UdDgQWBBRLUT7uSXOF
M/kxBy89nHsV24KNbDAfBgNVHSMEGDAWgBRLUT7uSXOFM/kxBy89nHsV24KNbDAP
BgNVHRMBAf8EBTADAQH/MAsGA1UdDwQEAwIBBjBZBgNVHRIEUjBQgRZtZGxAYWNs
b3VkLmdlbWFsdG8uY29thjZodHRwczovL2Rpdy5kd2cuZ3dhZmV1LmV3MS5ncC1k
ZXYwMi5hY2xvdWQuZ2VtYWx0by5jb20wXwYDVR0fBFgwVjBUoFKgUIZOaHR0cHM6
Ly9kaXcuZHdnLmd3YWZldS5ldzEuZ3AtZGV2MDIuYWNsb3VkLmdlbWFsdG8uY29t
L2NybC9pbnRlcm9wMjAyM0lBQ0EuY3JsMAoGCCqGSM49BAMCA0gAMEUCIQCMky6+
FCBuv2vc7gdefiFBf5f5+rQ4ke7z9aLrNIQVOQIgY5W7vMdFICxSCBjl2WcQH0Uj
s9yflsKGDH5YB2FSOaQ=
-----END CERTIFICATE----- 
  PEM)

  france_identite = trimspace(<<-PEM
-----BEGIN CERTIFICATE-----
MIIDUzCCAvmgAwIBAgISESHtNjf+2KAQ0ttWtR9EhAAPMAoGCCqGSM49BAMCMIHF
MQswCQYDVQQGEwJGUjEwMC4GA1UECgwnQWdlbmNlIE5hdGlvbmFsZSBkZXMgVGl0
cmVzIFPDqWN1cmlzw6lzMRcwFQYDVQQLDA4wMDAyIDEzMDAwMzI2MjEmMCQGA1UE
CwwdUE9VUiBRVUFMSUZJQ0FUSU9OIFVOSVFVRU1FTlQxNzA1BgNVBAMMLkF1dG9y
aXTDqSBkZSBDZXJ0aWZpY2F0aW9uIEZyYW5jZSBBdHRlc3RhdGlvbnMxCjAIBgNV
BAUTATEwHhcNMjUwMTI5MDAwMDAwWhcNMzAwMTI5MDAwMDAwWjCBxTELMAkGA1UE
BhMCRlIxMDAuBgNVBAoMJ0FnZW5jZSBOYXRpb25hbGUgZGVzIFRpdHJlcyBTw6lj
dXJpc8OpczEXMBUGA1UECwwOMDAwMiAxMzAwMDMyNjIxJjAkBgNVBAsMHVBPVVIg
UVVBTElGSUNBVElPTiBVTklRVUVNRU5UMTcwNQYDVQQDDC5BdXRvcml0w6kgZGUg
Q2VydGlmaWNhdGlvbiBGcmFuY2UgQXR0ZXN0YXRpb25zMQowCAYDVQQFEwExMFkw
EwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEoCYCM9LYS8zUk8I1xL2B2G9voa4yFsko
qohrsEQkpNEeKb59J3VDHausTqFWCOfwEGUzi6yocLIbE+gfz59pnaOBxjCBwzAO
BgNVHQ8BAf8EBAMCAQYwMAYDVR0SBCkwJ4ElZnJhbmNlLWF0dGVzdGF0aW9uc0Bp
bnRlcmlldXIuZ291di5mcjASBgNVHRMBAf8ECDAGAQH/AgEAMEwGA1UdHwRFMEMw
QaA/oD2GO2h0dHA6Ly9jcmwucXVhbGlmLmFudHMuZ291di5mci9hY19mcmFuY2Vf
YXR0ZXN0YXRpb25zXzEuY3JsMB0GA1UdDgQWBBR3bIy6PB3fPAlYHOvqk7nftps4
sDAKBggqhkjOPQQDAgNIADBFAiBrI2HGG1SZNRfEoaIwk3bjAjLBcE9tcKPi1gu0
oah58AIhAL+KWRF8FwT4JBblyZdmuoVVXJ36LMmAUcs5YwJpMiQW
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
          { type = "pem", pem = local.valera_test_certificate },
          { type = "pem", pem = local.igrant_sd_jwt },
          { type = "pem", pem = local.igrant_mdoc_iaca },
          { type = "pem", pem = local.eudi_test_issuer },
          { type = "pem", pem = local.idakto },
          { type = "pem", pem = local.france_identite },
          { type = "pem", pem = local.thales_interop_2023_iaca },
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
