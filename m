Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E153AFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F24810E039;
	Tue, 28 Apr 2026 05:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="h949jguW";
	dkim-atps=neutral
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com
 [209.85.222.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A73910E039
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:55:02 +0000 (UTC)
Received: by mail-qk1-f226.google.com with SMTP id
 af79cd13be357-8e0a768331cso1167251685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355701; x=1777960501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgxAIJLeaCn6GN7lnLqdP3ArB+IausabgRvS47YOEhs=;
 b=Rc8emEEg/eCFs1TF7PlVQWjub96iTV7tPS2fB7pH3iOnX51pVcnfo+CMPaoU6SCebw
 v3UT4Hj9SYukJZCH+O4YYhxNfwVxcmzGElPPWbBZ6hXAUfRESVFZDuRYYilAFNA8hBuh
 TsQNU4nmEWZuC39F4N4l5prgaXW7kDccru9U1QwMCbUtowFqhnEb5ufG9CaBZkZMgDKk
 FF0Hn6Xd8q6fYpPHislevZKSNaGX9AxntjQ182HLwemHZs67IB3E/ym+oRY7LnoEiwP/
 UAEmzPr9dWdzE/Ly/lP3ST31YTg/IUn+a261wlW3s1VRYAOHySShy9g0X+Q+0tNYEh++
 98pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uLeSD7dK55/eKxUX1XyDN5N2qpxzZmderjEiGyUuGzq0aAYbtwIycxXwfx2EWWPpiQ9x6JikCpes=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk5AA4D/6UzQ4e4+cg2ovama0NRlgmUMRkCnjoPBO+1BwL7xkT
 2U/gf/lHE3pE19se0dAzfvKcecEZQT5kCSjavxhNpxZ95rivx04IF4+qijhdRjTtWhgxelIXLDb
 u+IADevyPHpjpXzcFt5IvzWebkM6FyWzGbrLehDp1qqsMqISciKX0MKAc/P299OYELkuJlb2v4z
 TmVbXdgu1vHDyO66y2mZqjUg1KZZNZmH1AlAiEKO8Ar9lFvV6GvUNAE5C2X4R1X873/VEdb7P8A
 4d9h8az/Lh8WgoilkHA
X-Gm-Gg: AeBDieuFE0QmXEHyHhiUKqeTI8PpUHXKejP5RPLvgTD3O2sEc3d+rvZP0Z3BGAIrLKa
 QVX8ITGYQ+APT6aWSVpcSL7bCswCZWJyYm95k3IRKLojmo4zfP1a/4br7NQrdpw0jLca8T6SY2w
 ZJ/arJLCEcGTQm3B5J5WzTmN14FXewKBTMepe+8q4fuzHNdjitfVwEXeMKL5w5m9Cko8fKXC603
 8nL6fXbz28gTmXEMNN+qDOc9PXP70Msx/NOUjG88nIYE8q5mtA7NimQIVeNOLj9MSO4azwvq8b6
 VUXDZ5GAlOzUDyhEkiGNIBQWFb29QOYK9Pm7iJ9C/PNoh4QU3FpUSsl0itRxB4YxFxQVc8ahbZ7
 9YtIZTV7lxjGG44BRkddyxR7UGb98xQQExJonk/odMuzojse+f07Nremw9988Voad+fpMmQgAlB
 DKSJ4wDBMOrprilTf7xlUQiu4AF+J4n4da2Bw5kKFHeHpoQNfDt8KhZA6qT5qMShzm
X-Received: by 2002:a05:6214:27cc:b0:8ae:660a:be75 with SMTP id
 6a1803df08f44-8b3e32c072dmr25261016d6.9.1777355700941; 
 Mon, 27 Apr 2026 22:55:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8b3e287b214sm1069876d6.6.2026.04.27.22.55.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:55:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38eeb467db3so31150341fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777355699; x=1777960499;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rgxAIJLeaCn6GN7lnLqdP3ArB+IausabgRvS47YOEhs=;
 b=h949jguW4+/mfR81xCd3VhraLEfmVKhulzrJVlwDnB0DzC80eQuT9Bz6axt8RORKQ9
 73JbahPssfq1+ajFKkoCxdy1Wt+XFQndDNGINJRow2icbiZ7jsZU7URheupvLgANVZ70
 /OtM/X+7qANmoNeX8L/AgEKh4D3EYbp7idFV4=
X-Forwarded-Encrypted: i=1;
 AFNElJ+uRuk6EnGrnD4Hl0gQAEvc6fC4uddvHVucmWIjnG/IbR65jf8HcjQBpSIHBj7SlDhuB4NiWTilpPs=@lists.freedesktop.org
X-Received: by 2002:a05:6512:b8a:b0:5a4:18cb:884f with SMTP id
 2adb3069b0e04-5a746618e6cmr725217e87.24.1777355699034; 
 Mon, 27 Apr 2026 22:54:59 -0700 (PDT)
X-Received: by 2002:a05:6512:b8a:b0:5a4:18cb:884f with SMTP id
 2adb3069b0e04-5a746618e6cmr725197e87.24.1777355698439; Mon, 27 Apr 2026
 22:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260427150250.699768-1-tzimmermann@suse.de>
In-Reply-To: <20260427150250.699768-1-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 28 Apr 2026 01:54:46 -0400
X-Gm-Features: AVHnY4J7TNmIePflIQblTpw6pCmqWO-FIEvtaL9pVEP01HzdkmyenAfTS_S0lB0
Message-ID: <CABQX2QOqMct4SKiZF1dkUv7fs86qe=SAt8V_3yP52DE43XhevQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/vmwgfx: Use DRM's vblank timer
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000001b1f6606507edf72"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--0000000000001b1f6606507edf72
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 11:02=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Replace vmwgfx's vblank timer with DRM's shared implementation. The
> common code is mostly equivalent, but provides additional protection
> against concurrent changes to the vblank counter.
>
> Patches 1 and 2 align vmwgfx with the shared code, so that it can be
> converted easily.
>
> The conversion is in patch 3. It replaces vmwgfx's custom timer with
> calls to DRM's vblank interfaces. Initialization happens internally.
>
> This series should get some more testing.
>
> v2:
> - patch 3: fix vblank cancalling in CRTC cleanup (Zack)
> - patch 2: mention timer restart in commit message (Zack)
>
> Thomas Zimmermann (3):
>   drm/vmwgfx: Determine lock-waiting timeout from vblank state
>   drm/vmwgfx: Move vblank handling into separate helper
>   drm/vmwgfx: Convert to DRM vblank timers
>
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 70 ++++++++--------------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h |  2 +-
>  6 files changed, 24 insertions(+), 53 deletions(-)
>
> --
> 2.54.0


Looks great! Feel free to push through drm-misc-next or I can do it
for you if you prefer.

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

--0000000000001b1f6606507edf72
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVIgYJKoZIhvcNAQcCoIIVEzCCFQ8CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKPMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWDCCBECg
AwIBAgIMYT8cPnonh1geNIT5MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NTUwOVoXDTI2MTEyOTA2NTUwOVowgaUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKWmFjayBSdXNpbjEmMCQGCSqG
SIb3DQEJARYXemFjay5ydXNpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCwQ8KpnuEwUOX0rOrLRj3vS0VImknKwshcmcfA9VtdEQhJHGDQoNjaBEFQHqLqn4Lf
hqEGUo+nKhz2uqGl2MtQFb8oG+yJPCFPgeSvbiRxmeOwSP0jrNADVKpYpy4UApPqS+UfVQXKbwbM
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINe5
XCDpYCosN3Gd2ypzE21MzHVO7hjKMLOKO7ZnkPr5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQyODA1NTQ1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEQHSipjgp0UA+NJcZWwDEwm/nSDzsIPAXbeYrQo
JGRCMq+ZCEaPj57W27YJjHkZe4wiXKG1qkWik7YZBCXIeb5uRCUVRIay6ovJ64V0XrX45wlvwrt8
6WeWXOEIULEx2/Y0pFSRTSPwaRl5XJsb16SRn+tnC2WyFNxOPWFIajxjPuLYxS0nEBHuLpSli34v
ym932LIdVNt1sJrakApQqi2Ksx9yw6SBRSQxEPA1py/4BNOMtkJ5bV600Z/6gnqMnaSIe65+3Aal
/7VjRBtOKuYHujb42zEZLsPKogoNQBRbRHYozFP/0DnM7rFOYb9Uy7KepXfkTAXMyCcLoMcrKW4=
--0000000000001b1f6606507edf72--
