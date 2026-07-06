Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C606C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13B210E9E8;
	Mon,  6 Jul 2026 17:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Li9eZ8QG";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E895610E9E8
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:03:01 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2cc84e77e78so13316785ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 10:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783357381; x=1783962181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85bi3L8KPv5t8RjlK9fveHbNMP5FAFhIKYSs8ZBtPEo=;
 b=AC0ysi9ehJW0caSduuZeJcU3wmCD5QlLlH3iG71XkNtYBRbIb266B41+InE4V8aV/f
 Z7k/mQekxdpkdpKPgFEGoGRZoTdIvmX+HGIbdrz3nFeLygPB3no6dbvWtgHA9AyvaHij
 iVEc6KLsKKBeNhoJJ8xw2iOC06JsS4izWm1+6BuDBXfNS6icifbsdJR/6DhLbeHSwEh/
 LERQZbzOt++TnkdEkwtyVMGYwCWTQPkiz0LmBW4VUeT8YYFuNwPnOksLZDiT6x+A1BO+
 G8j9nKzeiw/5RJoxmMo5DxtmbiS8xmSTnokbeLnJQsJE1WpHY0TTIGVtm3h+CiClRAkk
 c4ew==
X-Gm-Message-State: AOJu0Yz2k1vAl4c/n5ku2M6CIgR9T7+pILhm7bvNa2ku30r5f/yeSaRd
 RUukHv1RcKOc2aOWIP2VnMpGT8zMF7vS0wtSwFiKo2ZrfhVF/4Q6IdkRq/wGCh++FWcWC5L+6rD
 kaPUb4KRi44skbJtbHxpBwA/OJhvbQPKUu+YRlVWchE8xkVn60TLeURJgDzVgI1fEc8MQUPv159
 /zw5bxXr0IraHzs30R6KQ46WFrmxV2mmJ/0zfGQ9Wul9qEB1BR173ybpe/Ckgv6D1z3WO7JOBL3
 2FaNNMa2W/6b9wZudyb
X-Gm-Gg: AfdE7cmdbrlqwuu9abY6xPwtG1R3o+zCAg2YbsVgwIhGK8HbrJxVlCWU6fdoLNJ8SCq
 M9Pw12SiACgNk9hPzcttV32aQPP9XVKdAyiJ7RmrsgmPgvktMQQuOZkc+3cdVj1or0uX/lZGqBZ
 hkc61WerUzOwO+4nJQcujnZxbEGeJRJXK1VCMw5sMyWyGv8421OL/GOlHBxqLT+sBI937oFgMd6
 s5e6q5hKGURjRTTebK86kdpSM8uTQESuiJjZ1Fg1nWC0NKEtJ83+qTVHvwRXDIbH30zsS70sQGp
 8zdEgVvwOy9dqz0YBQ/fULWf9gLVYWkKfiVgoCdwf0sg47sdKSC1CcmgEheG37zr3sCadXxcvtf
 FUmexlV+qbUwkQDvX630H5FHODHvd1whpy6KuWTiZHYQ20A5XpC4EFSsU9WruJjE0isN0+6hp5J
 IJ7+jIuJwUWtGoblitG7cAIZcyh31m3GxjjtwyDBot+Js6CQ==
X-Received: by 2002:a17:902:e5c2:b0:2c9:97a8:8c19 with SMTP id
 d9443c01a7336-2ccbf0868f1mr16005265ad.44.1783357381153; 
 Mon, 06 Jul 2026 10:03:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2cc768b39aasm5828965ad.13.2026.07.06.10.03.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 10:03:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47416fc1674so2605971f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1783357379; x=1783962179;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=85bi3L8KPv5t8RjlK9fveHbNMP5FAFhIKYSs8ZBtPEo=;
 b=Li9eZ8QGV/ZwnUX0B5Lmejkw7UHSuYndJZQ9DzMiXG0N6W8PExpLGistBnpgtWmVkz
 RnG19uRwWljfU1wAzhzE9syfeclusJ5ur1WhkhWH8YNFsdFTUcZOvE6OylS9kNJfAWWr
 Y1Mv5fuj2zlsiYh88XKYNGYUl/N9i5HnBe42g=
X-Received: by 2002:a5d:6a51:0:b0:473:cf28:a23e with SMTP id
 ffacd0b85a97d-47de669927emr1022288f8f.19.1783357378854; 
 Mon, 06 Jul 2026 10:02:58 -0700 (PDT)
X-Received: by 2002:a5d:6a51:0:b0:473:cf28:a23e with SMTP id
 ffacd0b85a97d-47de669927emr1022248f8f.19.1783357378328; Mon, 06 Jul 2026
 10:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Mon, 6 Jul 2026 12:02:45 -0500
X-Gm-Features: AVVi8Cfhn8q6Fe-ABloP0-Jc1GqME53MnTZfRE7xatF1986_6YUcUXZccW0QY-c
Message-ID: <CAO6MGth+iLpyZ3n=FUrDJnf5PmTOofQdUJye+Q0uNtRgTZ3A4g@mail.gmail.com>
Subject: Re: [PATCH 00/12] Fix issues found by claude-opus-4.7
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000019d1140655f43fec"
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

--00000000000019d1140655f43fec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:27=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> This is new for me but it seemed to work ok because it detected
> issues that have been present in the driver for years. The fixes
> were written by me but the bugs were found using claude-opus-4.7.
>
> The following prompt was used:
> "Carefully review the vmwgfx driver at drivers/gpu/drm/vmwgfx
> for clear and obvious logic errors. Limit your investigation
> to vmwgfx. Do not suggest patches or reason about possible fixes.
>
> Provide clear explanation for why the code is buggy. Make sure
> to include exact file names and line numbers not only for the
> bug but for the exact execution paths that trigger it. Try to
> follow the process described in "Describe your changes" at
> Documentation/process/submitting-patches.rst to describe the
> bugs.".
>
> For the commit messages I've reused parts of the explanations
> that were provided by claude-opus-4.7.
>
> Zack Rusin (12):
>   drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
>   drm/vmwgfx: reject DX_BIND_QUERY without a DX context
>   drm/vmwgfx: clamp dirty-page range with min, not max
>   drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
>   drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
>   drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
>   drm/vmwgfx: bound DMA command body size against suffix pointer
>   drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
>   drm/vmwgfx: enforce cursor size limits for MOB cursors
>   drm/vmwgfx: skip hash_del_rcu when validation context has no hash
>     table
>   drm/vmwgfx: use check_add_overflow for shader size+offset bound
>   drm/vmwgfx: validate external BO copy bounds for both stride paths
>
>  drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 ++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c         | 39 ++++++++++++----
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 49 ++++++++++++++++++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      | 20 +++++++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c        | 13 +++++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c   |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_resource.c     |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       | 13 ++++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_validation.c   |  3 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         | 17 +++----
>  10 files changed, 134 insertions(+), 35 deletions(-)
>
> --
> 2.51.0
>

For the series

Reviewed-By: Ian Forbes <ian.forbes@broadcom.com>

--00000000000019d1140655f43fec
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
V0fYJUiKJMCwvDmndOil8EtMA8j2T6taUZoQINiKQ0oDWgY6eYVv7AdPVIeOOs3noCyUL8AyA7Bl
yoOPBB2/gk8VGcolEKgAAj+3hPbBF/d19x1bZzU3wABizBomVwykx5ms1nVXDbQajz8jqYECKWh9
3OMo7BuC3TAClu5mLr2zs0Ccpp6NRRkjTF8WtCJ+jSnjFJGLAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2lhbi5mb3JiZXNAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSvJWzgGK7aSByS+CQVBVfM
Xgm5azANBgkqhkiG9w0BAQsFAAOCAgEAfrWiLF3zrYq7D+KPNRaAP70FbxHeaiUfn27Hbu37Eefz
xeJTcFZH04IEtXqpM3NWYZm4A/dFn/VQPbLCRaeXzpT2TESVH6EFY7BEF0rnSSlUbFyi000MnSH3
h5m+MoyE+PzLqfzLBZS+EU/haCpPy6Nqhs3fPKG3w5VTnUPsAxXK7rSmkIDVNsvwRttuMq9KHJzH
Bx51dP/z3mel4OuMjgrwHk5uNY1Sn1MZAUQztVUsWguyfoKcmhxXbBccR5DdEfBgDEbq8bicPQ3J
kqEy1QZXJfHlJuAJIiEw7odGctwqLeGCU6cBLhnsg54ngjO3uYC6tIySul55MRxFKE8HIwIrx+D5
2SwhDeVLZ8sTK40uPzW5xg5laOWVCvmy2b+cHCGzarUeIlYdtw0ejdH9Hbkm0G7IrDvjkhPa64gR
6Q+m5CGRDk+8iWhieH6WFE4HL++BpZhoi+YsOkGU3DK0dA+pxQnXNcNw1s0eNbSUVwQzmlC4LqiK
Gj5JV81HTPLhoAya57a9i28Fp5qHZiFnCq4HMvwiwY7IWe+UwUuueU199aTK80xNiS553vHc6FpI
/vxGy+LveJqEtodfKqQKwDOVu//c1Lz3uergJHqFYTMykk5U95J3FG5q/7Mqe4RF6E9OgtuAJidS
6Ca5anjLQ/qzIfTjoXX7TJSjPztehRQxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAzl
GjF9eJf8K5JqYFdbSYKmdTxaH0WO2PPuF2lyKvR/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDcwNjE3MDI1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADM23TZbY3gCdRjvQq0LPoSV5TBHSQe8pZxj7N0+
C5/+YJGY1DFbb5T8YB23wtsjwXPA1yoGGkDtegO4WRR1cYuqxmplX2l8u7Xh7K4b2PTwr0GulnN+
7VEANxSko2uVWmZboZ3k+kclpx0Y1+S4smNn1JaWLRIWTsAVP+KDFcvIPGr6rWav2QoJ1ASBBuRd
Zmgm+zadmbOXXtRJoOYsugopjBYHuKOaBUTQ9UHE+7hBXZmTpSsYqIXWxsCgPfmr47mTQnyN0qNB
ZfDAL84Wcv+KQNtU6anGxdQeCeZJDMCNrVubFSyh7juhvG8Eyqcs5JT82Hw/cLotSabXEZ6dLGI=
--00000000000019d1140655f43fec--
