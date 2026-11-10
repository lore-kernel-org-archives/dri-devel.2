Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF9606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRxeEiRe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4021410EB07;
	Tue, 10 Nov 2026 08:33:34 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FE010E2B5
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 01:04:48 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2e985106c0cso11586905ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 17:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794272688; cv=none;
 d=google.com; s=arc-20260327;
 b=Bl/HI0KoFT9oUJydZEs0MVyDzyYASQ7+Fkw4MgYCPMV1zA1vwJ/MErnwr/pTh0Enlf
 HuTh5WFN0M9kAX2K6o+PozI69xWhzHCOETpDXTJHqX9NZUXaqRyLdqAPpERpZvwwWH2w
 NbxRpTyJl4/NWteEvRXgud3KekEcIMtrxomn+fiGKUbum9WRavBheaxT0IZRI6cg1RPo
 aMUk59wNQvkuqXH1zofbHKsPcYNdl3d/DQ/ajbc9oglwzzuPSlqGtc+Nx1Do/aUSZSc6
 3HxON0TjRISQ9U1qugeO8Hg/AknQoUKTXm7tK2BirIFAK1+A6ofckfb9XUz2+v0gxY6W
 H76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ryk9ktTAYXBQ47FGJu+WGjFeXcDUCiNF7xVkpaBwbU8=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=bzVsaZqD53Mx4+sBY9I0BJ3V3FcEowRYfqu8xGNhCPnysCWcuNR8rT0nTf5R3EqV2A
 EXmSryONZl+7lvD1H7JuD5cMR28UIuV4e6S/Ro5SSCALjEaNnq6Eha0oivozgxxNZysI
 erDQbkt21CLUJnGgcz0JPBGRMSnTPi4G01xX+MgVok06g7A2Jm613r5863Qw6a8jzsSg
 8zgWL+L7xigIOTNAyl23h6cuDuupoHVWXVlzOxb9A4t66M8037Sls2ZdZ4nIv2jc19Be
 pPCPJH2IfjFDKXnKqnEBwV0EhuhVj9py1Wn9UEDN06W0vczEfadbJKr30r+xUjq1SegQ
 JQGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794272688; x=1794877488; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ryk9ktTAYXBQ47FGJu+WGjFeXcDUCiNF7xVkpaBwbU8=;
 b=XRxeEiRejGKtFLvrb0XJxFu7I09vvrOJxVk5hgKcxcMC7KwoiioFJ/xa5pSYCKF/25
 dhrJaUgTkSFOCM9hrABYEUNrRA5VwQPKIuk3U5Brn5FhWgceOa0ekdDtCcgqN/cZSnhq
 AvX6u6BsBTWZJ19LPdwLk0ExCYAeE3t80n8bT81HbBYXVVqin9Gf3jO9I5twRH6stul1
 FFSWh23GVcx8b39LR6T7ZuVapQA0XhT+RuwO8toumoQxCg0cQl9WVLQzh1E6bHM3xt1o
 zPx7s5u6+qN2NKnZi/c2OGT8/Rx0WjaEWszA4/MKmaPFbsMNY0ZCP+7zKTX6tL0M8MjG
 OfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794272688; x=1794877488;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ryk9ktTAYXBQ47FGJu+WGjFeXcDUCiNF7xVkpaBwbU8=;
 b=HBnsMvsuGKycmoiAWOO8t+JfcCGav/b1aHh2umILLa5WH84dnfYt8s66EF+42bjUbP
 ynFL+/CWJsBW+rlVZfbjt+Md1/WiDIaXv/a/Vd05mQAl5wiI83a1K3KiVEf7A4fEkggj
 mfoNDNaAbLyP1S6M/7tNG7E3BDm2eZ7kLHav39gtqFvd9Gcq6L8Ywow0ft5Zavj8p5Ob
 DdDIsqhAATYdhqAVdyCEEKoC+bEY7TlOp5rf8nfwEnRNAmBQkkyEP9s/hpKOpQNeFZll
 Tw22e6kOHEUVXsIpFfF+Ub9Vgm4DH770k4PiyRqj0X5xTg7s5TjMjJeVD28rEqlGklfj
 +fZA==
X-Gm-Message-State: APuU4Z9KVC7Hpb0PyzBARnMoqolsz9RJwM163nT/T4/aQf9tXMluGRLT
 wdEi0djV6xWaRdw4/qtQ4aptdRXKxbUpSVyU7T8TGv+qFC/IhdPxW8AdVYn1ggR1XCeCANp3mH2
 rQKbSNkSt5Pi6J5cHydU9pQfqspyzyugRiSTI
X-Gm-Gg: AYBFou0J5gCLeJNhDC//DXHhz5PSMGV6p95jKIfkoSpiyl6SsZorQlLoIF7EYpY9fyS
 NqYkoC6yysQeGHGLLMyzjFJjp888Sk8s4dIfafBKbn34dXTf3NVNT6X9f4/WyhHUF7mlaabnYb0
 7KALLzwt9vwh/hVCwMG/z2KZw6pfFvymSEHxN/ja06u7Csf2wi7RM+7troLvHvz77VjEMWvteYm
 Td0ztZIbjeWwn9sTRWZX8uOYQJNxJ5zF6gGdP+JVa2fu93x4OD9+FHM35i1xvh+1/kPVypX1WzJ
 eV2lXukZ5ilu4W1vasEMxuC4uQLDfvXbowun3W0C5J6AJU6vxJyCQ8u1sQLswvKgUURylT2Nph0
 w8hRdCVUqkj3LppZE3QpYD7Zfau2rpi3RXwUTtTWIUe4BWxbKZ1JOQ2UrZdRAf6aHrJU=
X-Received: by 2002:a17:903:2282:b0:2d9:4358:73ab with SMTP id
 d9443c01a7336-2edb91f56a0mr8401485ad.19.1794272687964; Mon, 09 Nov 2026
 17:04:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Americo Simoes <amexsimoes@gmail.com>
Date: Tue, 10 Nov 2026 09:04:35 +0800
X-Gm-Features: AclHuK9BAoHo9Bicw70LJu0S11Ru1NXkSoc3qoWYKRokkcDbZZTE7WwC9rrzc4Y
Message-ID: <CADw33JPRrx_EenTcQmsaXV=SvtEZ8gqP8v51b9FwsBiHGkbgTQ@mail.gmail.com>
Subject: Measured DMA-BUF coherency hazard on i915 Gen9 with a working
 userspace contract
To: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000032567d065fe1aab4"
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000032567d065fe1aab4
Content-Type: text/plain; charset="UTF-8"

Here is the email for `dri-devel@lists.freedesktop.org`. It is the one that
reaches the people who actually maintain the DMA-BUF contract, and it asks
a question they can answer rather than pitching a product.

**To:** dri-devel@lists.freedesktop.org
**Subject:**

Hello,

I am writing with a measured result and a question about DMA-BUF coherency
on i915, and a working userspace implementation that exercises it.

The measurement

I have a userspace test that allocates a buffer via i915 GEM + PRIME,
exports it as a DMA-BUF, maps it for CPU access, submits an
`XY_SRC_COPY_BLT` to the BLT ring with softpin, and brackets the CPU read
with `DMA_BUF_IOCTL_SYNC`. The composition test passes: 0 mismatches out of
1024 elements.

The negative control runs the same copy with the `DMA_BUF_IOCTL_SYNC`
bracket removed, 100 times per case, on a Skylake-U iGPU (HD Graphics 520,
Gen9, kernel 7.2.13). Results:

- Both sync calls omitted: across batches, 42 to 99 stale reads out of 100.
- Output sync omitted only: 87 to 100 stale reads out of 100.

The hazard is real and timing-dependent. The rate varies between batches,
which is expected for a race. The output bracket is the more critical of
the two. An earlier single-run negative control landed in the clean
minority and reported "no stale reads"; the 100-run loop exposed the race.

The question

The bracket is required by the DMA-BUF contract, and the measurement
confirms it is load-bearing on this hardware. What I would like to
understand is whether this matches what the i915 and DMA-BUF maintainers
expect on Gen9, or whether there is a kernel-side reason the hazard is
timing-dependent rather than deterministic. If the bracket is supposed to
be mandatory, is there a reason a single run can appear clean? If there is
a documented explanation, a pointer would be useful for the audit document
that records this work.

The implementation

The library is at `github.com/SimoesCTT/the-level`. `chipmem` is the
allocation and coherency contract; `blit` is the async 2D engine with three
backends (i915 BLT zero-copy, Rusticl with a copy, CPU fallback). The audit
document at `docs/linux-equivalents.md` records the paths that did not work
(udmabuf returning `EINVAL` on first sync, `GEM_SET_DOMAIN` being retired,
`GEM_WAIT` returning `ENODEV`, relocations rejected on Gen9) and the exact
measurement methodology.

I am not proposing a kernel change. The kernel machinery is there. I am
reporting a measurement and asking whether it is consistent with the
framework's expectations.

Thank you for your time.

Americo Simoes
`github.com/SimoesCTT/the-level`
*Tel: +65 87635603*


*email: amexsimoes@gmail.com <amexsimoes@gmail.com>*

--00000000000032567d065fe1aab4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Here is the email for `<a href=3D"mailto:dri-devel@li=
sts.freedesktop.org">dri-devel@lists.freedesktop.org</a>`. It is the one th=
at reaches the people who actually maintain the DMA-BUF contract, and it as=
ks a question they can answer rather than pitching a product.<br><br>**To:*=
* <a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freede=
sktop.org</a><br>**Subject:**=C2=A0<br><br>Hello,<br><br>I am writing with =
a measured result and a question about DMA-BUF coherency on i915, and a wor=
king userspace implementation that exercises it.<br><br>The measurement<br>=
<br>I have a userspace test that allocates a buffer via i915 GEM + PRIME, e=
xports it as a DMA-BUF, maps it for CPU access, submits an `XY_SRC_COPY_BLT=
` to the BLT ring with softpin, and brackets the CPU read with `DMA_BUF_IOC=
TL_SYNC`. The composition test passes: 0 mismatches out of 1024 elements.<b=
r><br>The negative control runs the same copy with the `DMA_BUF_IOCTL_SYNC`=
 bracket removed, 100 times per case, on a Skylake-U iGPU (HD Graphics 520,=
 Gen9, kernel 7.2.13). Results:<br><br>- Both sync calls omitted: across ba=
tches, 42 to 99 stale reads out of 100.<br>- Output sync omitted only: 87 t=
o 100 stale reads out of 100.<br><br>The hazard is real and timing-dependen=
t. The rate varies between batches, which is expected for a race. The outpu=
t bracket is the more critical of the two. An earlier single-run negative c=
ontrol landed in the clean minority and reported &quot;no stale reads&quot;=
; the 100-run loop exposed the race.<br><br>The question<br><br>The bracket=
 is required by the DMA-BUF contract, and the measurement confirms it is lo=
ad-bearing on this hardware. What I would like to understand is whether thi=
s matches what the i915 and DMA-BUF maintainers expect on Gen9, or whether =
there is a kernel-side reason the hazard is timing-dependent rather than de=
terministic. If the bracket is supposed to be mandatory, is there a reason =
a single run can appear clean? If there is a documented explanation, a poin=
ter would be useful for the audit document that records this work.<br><br>T=
he implementation<br><br>The library is at `<a href=3D"http://github.com/Si=
moesCTT/the-level`">github.com/SimoesCTT/the-level`</a>. `chipmem` is the a=
llocation and coherency contract; `blit` is the async 2D engine with three =
backends (i915 BLT zero-copy, Rusticl with a copy, CPU fallback). The audit=
 document at `docs/linux-equivalents.md` records the paths that did not wor=
k (udmabuf returning `EINVAL` on first sync, `GEM_SET_DOMAIN` being retired=
, `GEM_WAIT` returning `ENODEV`, relocations rejected on Gen9) and the exac=
t measurement methodology.<br><br>I am not proposing a kernel change. The k=
ernel machinery is there. I am reporting a measurement and asking whether i=
t is consistent with the framework&#39;s expectations.<br><br>Thank you for=
 your time.<br><br>Americo Simoes<br>`<a href=3D"http://github.com/SimoesCT=
T/the-level`">github.com/SimoesCTT/the-level`</a><br><b style=3D"background=
-color:transparent;font-size:10pt;font-family:verdana,sans-serif">Tel: +65 =
87635603</b></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smar=
tmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div><p style=3D"margin-bottom:0cm;line=
-height:100%" align=3D"justify"><font style=3D"font-size:10pt" size=3D"2" f=
ace=3D"verdana, sans-serif"><b>email: <a href=3D"mailto:amexsimoes@gmail.co=
m" target=3D"_blank">amexsimoes@gmail.com</a><br></b></font></p><p style=3D=
"margin-bottom:0cm;line-height:100%" align=3D"justify"><br><br></p></div><s=
pan style=3D"color:rgb(204,0,0)"><span></span></span></div></div></div></di=
v></div></div></div></div>

--00000000000032567d065fe1aab4--
