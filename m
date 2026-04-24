Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD36FED3C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1119710F58D;
	Fri, 24 Apr 2026 13:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="bss6v6+m";
	dkim-atps=neutral
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com
 [74.125.82.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9969610F58D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:08:39 +0000 (UTC)
Received: by mail-dl1-f100.google.com with SMTP id
 a92af1059eb24-12c726f46baso9732850c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777036119; x=1777640919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04PoJGYYbIVeybVOTimRunrvJNsyFgk10x++FEl8Po8=;
 b=szb/5aVyjNKZwR09CiB9lAc5gXaDhF9bqJZh33bmUm2V9xJxIO70ZfCjroIL+JlsYY
 dDJ5ivIs7TXKGgaxTqadiaTsNIfw1YKH57C8Oh6Wquxh9FD1CNPQ9dHtRzSp0PtU3kSz
 XjlSNIYJCjJwkCkZSWPP8VDk/UpFXS+O1A+NVCkr18Xyn0L+mGuwvglSnYBWxP4/0TdS
 LOFlNpEovAzmBAF21XsKsDmG/LYJZo8HWSf9XnIVVCimoLN/tgITvmxq6kLBd+kzgyoo
 oLIIHu0bcn77Nqe2wkYC7ABze0uMRvjz5zpsCo4zXkryrUrUtyiO1wvWXKcJIJwPyAjb
 h1SQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AG7hVtJr1SrwNzZ4rRpEwW4MCNKuvKOwHMhEvp7eUZlkV26j4ktL4KBhBk20bAEBeUp3cxfVxXTQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvUJFbnxUHVIyoUvR/J7KQymtAJc6RCX9nC8ogxw9Q+FhnkC2U
 xCSx8bSol0WxOeKAM0yOQ/o5ZlB+ffKrQlMZvSqkyIq3EqIkfRESHx5fhhxMhzg/KUy6ZmWLz1R
 i6+CbRFRR/djQvPJ1LRQD3hO+1Q/Y2iYGWqUjKGNVrW6QMuipbIyHMOdsGPQrBhLFHuQi0Pp1RI
 0yjJRUG/1vYjKMACJ1jyUuGbn9BMBOt5JeYqFZDeUXwTh50aqR/IkIQxL9sgjCJZXftno9uhyCf
 9BHgk1z07GOF9ZfKGjN
X-Gm-Gg: AeBDieuE7F+yBSxmVZhoeyT21n8FoiAQo4xPUGjioVlOB6Ondz1mz9b+hfu/iOv3oBG
 9clJo/6CxBw0+hbEixw9rtDQSSlIIwaf5Fn+QUQCVZdAhm2w/jVSWjYqRTRlJUdMCxjUzWJi7uY
 683nKlec2K7Z/7h305Q8AQa67+0UxdsEEByVCgm4UEgLHPv/QckykrTDMItbpaZ9aHJDv37LKrT
 cGjXw/3R8jDGhazboXkLPao9qeTFhTPcfVyvCL7oVpCFabvpbBUn8alnnENwIpLgE+Jki583w1s
 MbMyzvpmBN1GOTsjjFN5EcpXR3GcZSOKTQ5LFLH1OPi9xe1NFPUw1NgAfh9eAzGNW7a7+jjvCAa
 1HaPeJWzMmc+dAgN6BrsHxWRx3PvRNmFNKvhqi3IL99Ywbh7bQz0km9+PZCOJ9ZmDn4o7+mhB6A
 FuSz2UnLNT6UaFRnmWpmHbG4rPUVZpT8uTfte0LPzrPmVBCS63tCYjqc/8WuhU0FdA
X-Received: by 2002:a05:7022:ec13:b0:12a:6a64:81ee with SMTP id
 a92af1059eb24-12c73f64465mr15776785c88.3.1777036118412; 
 Fri, 24 Apr 2026 06:08:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-12db53641a4sm949310c88.4.2026.04.24.06.08.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:08:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7757463eso5115783f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777036116; x=1777640916;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=04PoJGYYbIVeybVOTimRunrvJNsyFgk10x++FEl8Po8=;
 b=bss6v6+m2CXfm5O33oDC+eQ8E8UfcLobnhZfba+ENQbdqohOhQrhSAhfUhg49PkKwP
 Wk5+EZ5VHCqlsC6w1SevFHUwykDmEbhAcd/tKBxAdXycUdOcaRZFVo0m/oJ8eCR0izJR
 jvcsnWdlnX/GKS9XJhN3ob+K6Q07fqFvwkYvk=
X-Forwarded-Encrypted: i=1;
 AFNElJ++OUzg7f69ycA90fhjmRIMFP+SGMC6I5qDLoaDoe2wbk1WxDK0jNliL79lNXS0zcUDxA4PP57Ng68=@lists.freedesktop.org
X-Received: by 2002:a05:6000:44e8:b0:441:1cfb:2024 with SMTP id
 ffacd0b85a97d-4411cfb20admr17830463f8f.26.1777036116132; 
 Fri, 24 Apr 2026 06:08:36 -0700 (PDT)
X-Received: by 2002:a05:6000:44e8:b0:441:1cfb:2024 with SMTP id
 ffacd0b85a97d-4411cfb20admr17830417f8f.26.1777036115611; Fri, 24 Apr 2026
 06:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGp+u1Y42cwE0RHhtoMEneCRTuM4k9aqKtzvXOVc9-_px49N0A@mail.gmail.com>
In-Reply-To: <CAGp+u1Y42cwE0RHhtoMEneCRTuM4k9aqKtzvXOVc9-_px49N0A@mail.gmail.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Fri, 24 Apr 2026 08:08:22 -0500
X-Gm-Features: AQROBzAw9ODul4JEGouNRJRaK4WaqXPIckIT4bL36zzOpw2upJZSTmbY4yIxr9o
Message-ID: <CAO6MGtgE+MxeOv5xDhRoKh75tJgfvfaxoevMHJ_-AJZUc5vQyQ@mail.gmail.com>
Subject: Re: [bug report] Potential deadlock bug in
 'drivers/gpu/drm/vmwgfx/vmwgfx_irq.c', 
 between 'vmw_thread_fn()' and 'vmw_cmdbuf_header_free()'
To: Ginger <ginger.jzllee@gmail.com>
Cc: zack.rusin@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000007b373d0650347629"
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

--0000000000007b373d0650347629
Content-Type: multipart/alternative; boundary="0000000000006cc6a80650347608"

--0000000000006cc6a80650347608
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

T0 is a threaded IRQ handler so it should not run in an IRQ context.

On Fri, Apr 24, 2026 at 2:45=E2=80=AFAM Ginger <ginger.jzllee@gmail.com> wr=
ote:

> Dear Linux kernel maintainers,
>
> My research-based static analyzer found a potential deadlock bug
> within the 'drivers/gpu/drm/vmwgfxl' subsystem, more specifically, in
> 'drivers/gpu/drm/vmwgfx/vmwgfx_irq.c'.
> This deadlock potentially occurs with the involvement of hard irq.
>
> Kernel version: long-term kernel v6.18.9
>
> Potential concurrent triggering executions:
> T0:
> vmw_thread_fn[t1]
>        --> vmw_cmdbuf_irqthread
>               --> spin_lock(&man->lock); [t2]
>
> T1:
> vmw_cmdbuf_header_free
>     --> spin_lock(&man->lock) [t0]
>
> T1 does not disable hardware irqs in acquiring the spin lock. If T0
> (i.e., the hard irq context) occurs after T1 acquires the lock and
> both happen within the same CPU, then T0 will not proceed because it
> cannot hold the spin lock that has already been possessed by T1, yet
> T1 cannot proceed because the hard irq runs disables preempts.
>
> Thank you for your time and consideration.
>
> Sincerely,
> Ginger
>

--0000000000006cc6a80650347608
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,sa=
ns-serif">T0 is a threaded IRQ handler so it should not run in an IRQ conte=
xt.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Fri, Apr 24, 2026 at 2:45=E2=80=AFAM Ging=
er &lt;<a href=3D"mailto:ginger.jzllee@gmail.com">ginger.jzllee@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">De=
ar Linux kernel maintainers,<br>
<br>
My research-based static analyzer found a potential deadlock bug<br>
within the &#39;drivers/gpu/drm/vmwgfxl&#39; subsystem, more specifically, =
in<br>
&#39;drivers/gpu/drm/vmwgfx/vmwgfx_irq.c&#39;.<br>
This deadlock potentially occurs with the involvement of hard irq.<br>
<br>
Kernel version: long-term kernel v6.18.9<br>
<br>
Potential concurrent triggering executions:<br>
T0:<br>
vmw_thread_fn[t1]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0--&gt; vmw_cmdbuf_irqthread<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --&gt; spin_lock(&amp;man-=
&gt;lock); [t2]<br>
<br>
T1:<br>
vmw_cmdbuf_header_free<br>
=C2=A0 =C2=A0 --&gt; spin_lock(&amp;man-&gt;lock) [t0]<br>
<br>
T1 does not disable hardware irqs in acquiring the spin lock. If T0<br>
(i.e., the hard irq context) occurs after T1 acquires the lock and<br>
both happen within the same CPU, then T0 will not proceed because it<br>
cannot hold the spin lock that has already been possessed by T1, yet<br>
T1 cannot proceed because the hard irq runs disables preempts.<br>
<br>
Thank you for your time and consideration.<br>
<br>
Sincerely,<br>
Ginger<br>
</blockquote></div>

--0000000000006cc6a80650347608--

--0000000000007b373d0650347629
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
QSAyMDIzAgx2/5+PPF/QoW30N7swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKyo
fY/1quWrvt4291B6r5upyscuit2Fzw3SO/TZDdDcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQyNDEzMDgzNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFc3h2HplTd4r6+OaWtaYcXXDL0YPHmcGjmebd9T
xB0LYC0UN3TqVkV/tPLWn4k8J/wZ53p6OyGP3+uYRYqQnCLBXNqQML8LbVeXjZ/JjCty7i+QwYAG
MpFwaQDeW5Ou3yLA1ROohhGxIgSlBMcaI6IbWpnNyXtupBm7Hy92A1wGZItbJIxS8kcBMp2cx/P0
mwpLpWZi2v0Uwm+Ex/8IsVhBFlSW4cRORRwha8UL/gOVKV8wjSHsVkmhCiL+pa6tvvQWI7UOUMNV
XKwyRtXui1dkdie3+E1Pmqrj9ckkxmU2aMctRmNj0eHGDs2v7KPs1ytZ9mkjsqkanWqnUM5gr+E=
--0000000000007b373d0650347629--
