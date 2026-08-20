Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC96C5DF88
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97BD10F01C;
	Thu, 20 Aug 2026 13:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOYGjDYv";
	dkim-atps=neutral
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4AC310F01C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:24:44 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5bf9635a8c1so34759e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787232284; cv=none;
 d=google.com; s=arc-20260327;
 b=GLZP/6cGNflVReinzt9ijEmMfEeJSFmu1pCzz1RmE3x+rgeG4w7TP96HC7FZvyHUY+
 nUh76T046/Pes52rZLk1N2eaXS590aRe2BDVmKmCbPUt0WA1sJY6A0fNFVdk1GwUJtcp
 P+JvRYdCFmJ4NeEfdVYKm4CnxnTCN43qlWbTJO6VurW0TY9xp1UYUWwap+l9LXH2FluD
 /px8KJ0LdpyAfNpxgFMarfE64F91Iu79N/1H+TmqCPlOHJypqdwyUx5/OUSQX2+gNMIi
 /+qjceRSNjxzimFPOxsJcsz+ODyLV2qkeBoXx46MTjKyMjZ+nweoObmpUj9JCCbjA5hv
 jFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a/bb9TS4nrbeO9REdTEH+Ugx741KsO4AaWJeYnqJzhA=;
 fh=ijqTk/8lPKLwdHaf4YvpXXke2movWiq+eVP0ooUbBec=;
 b=KwcCQEy+yTRued1octm5NRJSDnhnmjqnLIifeoifyv8g7mzVdWNo3dABfNCUQ0I8LP
 A5WrCykoUQalx0JUT9uIirqxIkuPMC+QUjRKIvak94sLkgFL8Qahj5hRlx7Bo9TOkJF1
 92qGii95HZ1cKY+aQS7Ydz985QYp0IxP8GiSjXNGzsmu1YXRrO6EqFhKMMRsvW4sVA3r
 1DJ1A9wjoSLunD8lE73iFERg1CV1xeUhc6ZxE/C1yKB71gezzknOvgiaCc2EJMNU+Xl2
 B/rKSw89I/FXzOD32OrayUq/Y+GIdSk0zYqHscriLNM4FP5H2YDmKYDgZ5jb+W0CWlmN
 /rYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787232284; x=1787837084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a/bb9TS4nrbeO9REdTEH+Ugx741KsO4AaWJeYnqJzhA=;
 b=VOYGjDYvsUv4Vcc6GQFRbgQz49HNqCluRVg+nmE5gpgb3XC3nVPjrctRA06FqLwbM7
 2Fb1u9UVkhCNMIgaGC1WmujprXamc95XCbyxqagDlPpIDz4Mvt/N1AH1duzR2hjnpXL+
 Yp8ks/WK6OFopBqIIRyUC68o15oFpwigJ9TEhFYosVodEcfJnewvOc/J5wGgKv5Fuzn4
 LsnTuvUW0k6+mkXwDGNk+iieSI9GE+XCPpQW7XPtGq7FecGNj9gbteG+d+6XiYd7lqcw
 N+MHds9FkpT3cIUWf7DDVkC53FA3WcuDzWTMWiACa4rL2aWbT2wPa2DirOm98FSyR1Qt
 ThZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787232284; x=1787837084;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a/bb9TS4nrbeO9REdTEH+Ugx741KsO4AaWJeYnqJzhA=;
 b=eNiItnAiw62RWbCdXwM+e3TD9cQLUP0FOVlFlZ0PkckCUR7IPihUC9J03I/iS87TMR
 9LPls+fBA3oM/6PdMzxCVgGUFHglpnFV8uDfr/W3C53aQPdiz6ZRBNwSih0PBOYlkRMr
 TXLypXBXSUuUk0zVOHjw/iS4lmFI78G0DWiPuqGTuQvYCKivY5Bhsm77Z0VYV1W0IQ4X
 AlOlLGzfj2D2R0c3DU/WgaPkJJHTmQgV/b1eTBKVP6vwXhKtvPdxKKjxGnRkHEsnYtpm
 X/wfp55tHkaG2j4iZ3pgBvzzMScDYqZ54fMfpWGTpeVt+1qizn0Z3yMre/LwnJIxVtT+
 eg4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqE/7T6Pk+zflY4Irgyj19VOi1mP9ySHoHaYj6YcfvglCVxMImLn+gTp1X1W4tF/gColuz6FP/aNY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze37gE5SIIr6v6sEM/E+uTJLH0eN5K83/lRDADJkA6e08uXikJ
 jT1MXMDY5vA45CBpebuOAjVA9Gq8Lj/A86Ds4sQ4h0I8IJDd9rvGWOpfL1Mz8wP12CgNAXwV7Ot
 vbC8Nes2xm3qLhxHuSRPzhTCcLfKQ4xc=
X-Gm-Gg: AR+sD10s3I2QSaeQP/l6WXbptQrzdwDcnl7mCUbq4OeQTMN24HryhgzTuQVchSU8Mer
 vECTTD5sXhiLR7gEmv1drwRYIQnfhs5SFulCeBiyhe9+PN/pVDt/o/ODiwzpRbTQEpK4/YWFvVo
 IUWvnykohT9C6g+eJdiOc2JOJu2Gf7CxEzzQqWJY8C/SbpdjnwKw+/Oo1b+6wLmIHpFQU/ah0j9
 NsqpzNLIvvZwcYs8/aLuvK7/qFQTlJtI4Rd81uehuvBS6RAr6GPoA+MATHT8zkAoXeXOyyB+xDC
 dn6y3HO4gmCafSPxGshAfY4V+ONlTTwpHZ5T3okffJf+z+IunwtZYhtPuLJrgWqzff+/5ONh2e7
 qlaQxloy5TdUq7ssXDUZdLp3OeKDFpKAHYAyAmrJbng==
X-Received: by 2002:a05:6102:8024:b0:772:cccb:f7eb with SMTP id
 ada2fe7eead31-777fb1adaf4mr1775409137.2.1787232283641; Thu, 20 Aug 2026
 06:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260601211931.2837-2-gilles.risch@gmail.com>
 <010001a01df94f48-3026542f-b8eb-4661-868e-1d35cfd0254b-000000@email.amazonses.com>
In-Reply-To: <010001a01df94f48-3026542f-b8eb-4661-868e-1d35cfd0254b-000000@email.amazonses.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 09:24:31 -0400
X-Gm-Features: AcwNN1X2Up83ezJvdOticUb5SaZjCUlqZ1r-YJnM-q1UsARSxIOswEHsKqhXwOU
Message-ID: <CADnq5_N7_w0k5mrgvcEgLZAa4Huv6PP-mTChsoxNx7Vnrb1qzQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Erik Gregg <hank@mowden.top>
Cc: gilles.risch@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 20, 2026 at 8:50=E2=80=AFAM Erik Gregg <hank@mowden.top> wrote:
>
> On Mon, 1 Jun 2026 23:19:32 +0200, Gilles Risch <gilles.risch@gmail.com> =
wrote:
> > The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> > (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> > DisplayPort path. Without this fix the display stays dark under KMS.
> >
> > This machine suffers from the same issue as iMac10,1 and iMac11,2:
> > Apple routes the internal display through Link B of the DIG encoder
> > instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> > the Apple-specific encoder assignment into its own block, independent
> > of the DCE version check.
> >
> > Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> > and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> > to avoid affecting other boards.
> >
> > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
>
> I tested this patch on top of 7.1.7-arch1 on a Late 2009 27" iMac11,1
> with the Mobility Radeon HD 4850. With nomodeset the machine boots with
> a working (efifb) console. On vanilla 7.1.7 without nomodeset the panel
> stays completely black (backlight off) and no radeon init is visible in
> dmesg over SSH.
>
> With the patch and without nomodeset, radeon initializes normally per
> dmesg, but at the fbcon modeset (~4s) the panel goes blank and then
> shows flashing horizontal lines that start at the top and sweep down at
> regular intervals. It never recovers. The logs below are from that case,
> gathered by logging in blind on the console and running commands blind.
>
> I tried radeon.dpm=3D0, radeon.audio=3D0, video=3DeDP-1:2560x1440@60 and
> radeon.modeset=3D1, with no change.

I wonder if different variants of the board are wired up differently.
@Gilles Risch, can you attach your dmesg output as well?  Maybe there
are different panels on different variants?

Alex

>
> Renderer: AMD RV770 (DRM 2.51.0 / 7.1.7-arch1-1-imac), Mesa 26.1.6
>
> [    3.028962] radeon 0000:02:00.0: fence driver on ring 3 uses gpu addr =
0x0000000020000c0c
> [    3.029207] radeon 0000:02:00.0: fence driver on ring 5 uses gpu addr =
0x0000000000056230
> [    3.030250] radeon 0000:02:00.0: radeon: using MSI.
> [    3.030275] [drm] radeon: irq initialized.
> [    3.076796] [drm] ring test on 0 succeeded in 1 usecs
> [    3.076803] [drm] ring test on 3 succeeded in 2 usecs
> [    3.252855] radeon 0000:02:00.0: [drm] ring test on 5 succeeded in 1 u=
secs
> [    3.252861] radeon 0000:02:00.0: [drm] UVD initialized successfully.
> [    3.253264] [drm] ib test on ring 0 succeeded in 0 usecs
> [    3.253283] [drm] ib test on ring 3 succeeded in 0 usecs
> [    3.906199] radeon 0000:02:00.0: [drm] ib test on ring 5 succeeded
> [    3.906669] [drm] radeon atom DIG backlight initialized
> [    3.906672] radeon 0000:02:00.0: [drm] Radeon Display Connectors
> [    3.906674] radeon 0000:02:00.0: [drm] Connector 0:
> [    3.906676] radeon 0000:02:00.0: [drm]   DP-1
> [    3.906677] radeon 0000:02:00.0: [drm]   HPD2
> [    3.906679] radeon 0000:02:00.0: [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7=
e64 0x7e68 0x7e68 0x7e6c 0x7e6c
> [    3.906682] radeon 0000:02:00.0: [drm]   Encoders:
> [    3.906683] radeon 0000:02:00.0: [drm]     DFP1: INTERNAL_UNIPHY
> [    3.906685] radeon 0000:02:00.0: [drm] Connector 1:
> [    3.906687] radeon 0000:02:00.0: [drm]   eDP-1
> [    3.906688] radeon 0000:02:00.0: [drm]   HPD3
> [    3.906689] radeon 0000:02:00.0: [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7=
e24 0x7e28 0x7e28 0x7e2c 0x7e2c
> [    3.906692] radeon 0000:02:00.0: [drm]   Encoders:
> [    3.906693] radeon 0000:02:00.0: [drm]     LCD1: INTERNAL_UNIPHY
> [    3.906695] radeon 0000:02:00.0: [drm] Connector 2:
> [    3.906697] radeon 0000:02:00.0: [drm]   VGA-1
> [    3.906698] radeon 0000:02:00.0: [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7=
e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> [    3.906701] radeon 0000:02:00.0: [drm]   Encoders:
> [    3.906702] radeon 0000:02:00.0: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    3.915213] [drm] Initialized radeon 2.51.0 for 0000:02:00.0 on minor =
0
> [    3.988184] [drm] fb mappable at 0xC0347000
> [    3.988187] [drm] vram apper at 0xC0000000
> [    3.988188] [drm] size 14745600
> [    3.988189] [drm] fb depth is 24
> [    3.988190] [drm]    pitch is 10240
> [    3.988263] fbcon: radeondrmfb (fb0) is primary device
> [    4.026022] radeon 0000:02:00.0: [drm] fb0: radeondrmfb frame buffer d=
evice
> [    5.366673] systemd[1]: Load Kernel Module drm skipped, unmet conditio=
n check ConditionKernelModuleLoaded=3D!drm
> [    8.464118] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops radeon=
_audio_component_bind_ops [radeon])
>
> Happy to test further patches or gather more logs.
>
> Regards,
> Erik
