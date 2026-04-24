Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA48FED3C5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4DD10F56A;
	Fri, 24 Apr 2026 12:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="DxibHRaK";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB08910F59B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:55:28 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2b7d3ecc10dso624435ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777035328; x=1777640128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUBGDolqxGw1GZkvkH+iSnIyt6GXZroWy0qNt0wlGTk=;
 b=miU+0toW9NXlz6CKYOr8ldFObN9KP5EG+TYAo6CYKNMLp+mcxKBCVnhwGKFJ16hNC+
 Lq/s8KOIDRIeg+RqyIpRemxygk1A2RYeawhoZXxIskWh4LlAogj/gYExX72d7Zaa0IC4
 vGFX5CcLW7obzbw4Xa2L9Vk6wIUxoSvkDyNZEO0aVriWF7U2ZCDjjsMIxdPC2jWjAa05
 soSOAPG4weEqC7C3BSnl9n5F5z0ixwSaCCjwYOLUlo4lDVcsLe9oO9jk8vaiD7o3FFK1
 MzFwZLAkkIPYgDudhGhJ1q0ASxcCuDxDRUjREhXlDzP5zCjTNEJdEnXrvnAh/ILvpa7J
 OA1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MRoRb9jzbdqPpk5V7HnTm49D65oTMGnWnIQ56zRDDUBHq5F5ReqjD0sgaGDeM3moYO/XqwJsHlww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGHzI7hj5hQWP5lZDhCwyOM3Ouwd5SzzbkpUDOM8SxEnamrG/F
 HqHxST7WFU/HzxFeor/m1fws2BdKWt7uN4/wIJX5bDPC+HVbZpFf5qVoJ+Eabuh+44s9ttLjl9x
 rva9r2tEwRwIl/xDdnyIICf3TfeDgt8qha6VwDZ1Fq4lDP7AB/dlBch87iSOFgFmPz9U7BXhpOZ
 F2W11bH0vNBX5qT4q/OWu6yvyKbn/d5ErWRtz+KXp4CegRth/xOG9O/aYZKlMsiwuhmRxo60FEG
 INRVxjXAAzFKlmJ4alL
X-Gm-Gg: AeBDievaBfJ0MfBCOIsYEknsOsh/B6eC7q5/CcE65B6N4HkRC/ZYNJrTU/vwvrebk+P
 uQe8Z7ZePpp1M+9hnfWR5fnyjqeqhRUHyQOlevuNEi8PWIRs5qN4f+nCkvwRVAP139T6hTqJV+B
 xu3Ir+AFT8fw6PIDYvaN7dlL/T+DUm56uWIlGX07viTz3UTPxyRYSr8LgIVplPzfobGY95u13iE
 PjB2CtVwrrPvdGhwtBEvZWPJ/rVvqrTPHg+Cys3uQYQfcxnN6HqZeERhUMj81HhLuPtWJu7RTFt
 myWdHyUPC15RCrrixcTqBdLo0Yy66R8BrfhcOcER/UdlqTmvmCGy8nKoYLq98kwodtbQcqj4JMX
 aPdD8uTzRxM1YUJGwPFtW1k/kflqRTrPiaw/tAqJzCH7eWSXPv9Cl81UcvGOIJ4xQEVoy3B8gXu
 EiKWALhJhA/SAOYin1LWFRZT1WNzaFcmWVvFK2c4MeXLaMXAPiv9m8DDIMD0nl13pQcJM=
X-Received: by 2002:a17:903:1b07:b0:2b4:5cea:f61c with SMTP id
 d9443c01a7336-2b5f9e78672mr354275075ad.4.1777035328245; 
 Fri, 24 Apr 2026 05:55:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2b5faae2744sm16034065ad.30.2026.04.24.05.55.27
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 05:55:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43ff0eb2b2aso4991727f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777035326; x=1777640126;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUBGDolqxGw1GZkvkH+iSnIyt6GXZroWy0qNt0wlGTk=;
 b=DxibHRaKtdNy92qUJsvvXqMNdKhVVgbb70OhN0EtfKugV2DqD9X9GANAogPOO4xur6
 vS3m0/BvhvMuY4L3eRe81oYpPP0x/HxXUYE6qpzbgIhXmhmqMrsc5rnPJBjOTaWZQSyU
 xY1eVA2Rx17bYuj0YDkK7LPn+J4M06pj9sDk0=
X-Forwarded-Encrypted: i=1;
 AFNElJ9YrniR7o4ZSwFOdAT8Cjp+DgiJ5uHxihujZcJArf5eW+kF8flo3d6j3dL0kP68t0g3fRn7dGVToxo=@lists.freedesktop.org
X-Received: by 2002:a5d:5f93:0:b0:43d:7854:32e7 with SMTP id
 ffacd0b85a97d-43fe3dd3ac1mr49712946f8f.15.1777035326124; 
 Fri, 24 Apr 2026 05:55:26 -0700 (PDT)
X-Received: by 2002:a5d:5f93:0:b0:43d:7854:32e7 with SMTP id
 ffacd0b85a97d-43fe3dd3ac1mr49712906f8f.15.1777035325640; Fri, 24 Apr 2026
 05:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260424092012.5694-1-christian.koenig@amd.com>
In-Reply-To: <20260424092012.5694-1-christian.koenig@amd.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Fri, 24 Apr 2026 07:55:13 -0500
X-Gm-Features: AQROBzCLVWXa521rWgconPPOprBbUju5MXrjasnDABLrP25ttyaTimFcA0qAajM
Message-ID: <CAO6MGth7OXG64pBxdtHU67M+yQ7QM7rSFQTmT57_1sC6TQMK4w@mail.gmail.com>
Subject: Re: Finishing drm_exec cleanup
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
 dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000633e2206503447c0"
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

--000000000000633e2206503447c0
Content-Type: multipart/alternative; boundary="00000000000056b294065034474e"

--00000000000056b294065034474e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I tested this last time the first patch was fine but applying
subsequent patches broke vmwgfx. I did get it to work but it required some
hacks and at the time there was a major conflict with the ttm -> gem
reference counting series. I will try again now that the reference counting
changes are done but some changes will be needed in vmw_cotable_resize.

On Fri, Apr 24, 2026 at 4:20=E2=80=AFAM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Hi Zack,
>
> VMWGFX is the only DRM driver who is still using the old ttm_execbuf
> framework and while going over my TODO branches I've found that I never
> upstreamed the patches to clean that up and fully move over to drm_exec.
>
> It should be a trivial 1 to 1 replacement now, but I can only compile
> test it.
>
> There can be more cleanup on top of this, for example as far as I can
> see vmw_resource_check_buffer() actually doesn't need a ticket. But this
> isn't the topic of this patch set.
>
> Please let me know what you think since that would allow remove quite a
> bunch of otherwise unmaintained code.
>
> Thanks,
> Christian.
>
>

--00000000000056b294065034474e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,sa=
ns-serif">When I tested this last time the first patch was fine but applyin=
g subsequent patches broke vmwgfx. I did get it to work but it required som=
e hacks and at the time there was a major conflict with the ttm -&gt; gem r=
eference counting series. I will try again now that the reference counting =
changes are done but some changes will be needed in vmw_cotable_resize.</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Apr 24, 2026 at 4:20=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=
=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leic=
htzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hi Zack,<br>
<br>
VMWGFX is the only DRM driver who is still using the old ttm_execbuf<br>
framework and while going over my TODO branches I&#39;ve found that I never=
<br>
upstreamed the patches to clean that up and fully move over to drm_exec.<br=
>
<br>
It should be a trivial 1 to 1 replacement now, but I can only compile<br>
test it.<br>
<br>
There can be more cleanup on top of this, for example as far as I can<br>
see vmw_resource_check_buffer() actually doesn&#39;t need a ticket. But thi=
s<br>
isn&#39;t the topic of this patch set.<br>
<br>
Please let me know what you think since that would allow remove quite a<br>
bunch of otherwise unmaintained code.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
</blockquote></div>

--00000000000056b294065034474e--

--000000000000633e2206503447c0
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
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINix
IteDV8EkvoMvZfY6240exoYRBSxGrvmnMZnBHRkNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQyNDEyNTUyNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJxrUNXHCpQfquweah86bfuoONkpiTRqb7lRZohO
BvdOlI8tb/Yv1k+wWPK+Jonx8DgaYWC27cn/kYawWCjNVPICx3m/XsQpDnnL0BD6dKU4YJUrAyEO
fVdnrTJj/d//HiA1qKKMmdiqJ9DhJ26FD55szIItaam4CksvG+5ONKdbKE0hL9rHiTCbg54/sSSz
VRYSKqabU1tremGvoMUke287Q2BoOEPIyxVtj/jLg09ROaKnta3XNmZ3yUqgl/WDZVoog+f5+jYf
DPILOayUjEwmrPeV1KmgzpjlM6V48a0W2SUHrYwaWHwOsFcLQ8qL+VDZKqjbdI2gIgw9DNul2RY=
--000000000000633e2206503447c0--
