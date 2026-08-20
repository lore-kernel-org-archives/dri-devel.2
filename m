Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE33BC5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3421210E603;
	Thu, 20 Aug 2026 19:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RWMkBDWT";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB0510F17C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:34:34 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cbe4592c193so28086a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787254474; cv=none;
 d=google.com; s=arc-20260327;
 b=FmrL9Yax6s1zD2VXYFn2UFE0SsxIVr5u5SonAr9PNvQEJMnb+tXzQUJFFAVgkVEYm3
 9H3Wj++0/Ni0bhFqw6RkiIq+4kXIp/arJzg/r2w9Jwh9rTeGoiCLvwLQdNDa0HL+GvbC
 kKMPFz9+XA+GRHSQXG6CGnonvqE4xEMiVCUtduAosESjYUrBE8C1hJ5R17RoR4enGRe5
 V5NzB+lf+FfZD8gahtjbtDqREskUtaD7hkGONjXFVyMUZzBolfJCTmUaLtlu6kd5mSHT
 nbSGjcaBysxGtlD8UBzia+MUq32u807NItKmmxnoRFxQH0Mh0jPX9HzLhtq/PNOmADD8
 jtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dPlCotS2r/D7gi3E/PoHViYh+YnVAxJCTi+3Pa0/DcQ=;
 fh=efYJIoALTLW9cgW9e7MYDLFXSLRhKKVXHcoCQfZWveY=;
 b=LV3+chpzHO/7ZOFfpJTydpo79p6Z9g4Vyv/409TIzoJnVZt4rrX8wtxwpVSXU+Y5Sp
 EmpVqqGyQEfPliHN58rFRHHiEU/ASWN9OhuebrbJfHIQhapTmrxdrvYomiSHK24a2XsD
 tJO7SY7dL6XsBZhdn/lx/eCj7SppLPJnB6t5jw88zKylZqUYByNIIjfjYj6+QXHH5LSD
 6aTCCu4aSwIjDb0rM/80RNDgNhC6nIE7hBiBnZdynHsnWG2T4f5UkOwaM47BhM1Vq0Ff
 zKKqHsqmJCQY2i3N9u1NDJxIkey2Jgo/PxrwREpqh/UayjkaMdCRujRH03w7+1oDku+W
 iDMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787254474; x=1787859274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dPlCotS2r/D7gi3E/PoHViYh+YnVAxJCTi+3Pa0/DcQ=;
 b=RWMkBDWT3Y4qOTUl2TgnahRtNgcwYVVB3hkWcm6199GqJI0SSOLCO30nWSIemL5sPq
 +KKnKOOfrPVSxJxgWFefWd9XyOv0REd2fznqzdQQ29FZ/IVJ7J1B8K8azxHG7EUclckZ
 m1VnSWkTjFVycRBCj0lFEr77avSOsFqFYYts4bmUS2eWku8a8dGK0CUMHNGvaIlupKXk
 P4//4tJEsyb9gnl/JxmuU6gFu7a2dyyFS3acU/bYCZmax+IBzgmWejkdYb+Af9tYzaij
 NQyIB2hJ66uzfeWU1x1asnPOu15I4N2dSbTkr27I+c67Y7cJc5OSxRbeNVDy//2a2UDZ
 mwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254474; x=1787859274;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dPlCotS2r/D7gi3E/PoHViYh+YnVAxJCTi+3Pa0/DcQ=;
 b=V77dl3hX/S4Hb4VHxc/AX991rCYl8wgoDR/+Hqk4Xkuz8BIvlJhhxwDhSFwDsnPQ5p
 OvUoEM5pU5YTmd1ndMNMPlvYd27WuNgGXawL9YXuuvvctaqHB2BBMr30lChAgd/Q8A0z
 4tFDHrGdCRKa6bqXx2LV3Qk2lLUSD83H7DeI3VRKtvMkxWJUX998r1NEPFA27b06W0if
 JQ0UduWOFTdbbtVhtXXPgKruFXm/WUdMncaTOrJlmmGmQUR0uw6Bcs1BYaJBrjFTL86+
 vGNC9ydJqibUkgm+mbTjHWtMD4sK0pmaWJjmYRuJ6WsGrqGtx1ReFsLZHXUWEFoTS5BQ
 sxfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNoQ5TgXeHqatx4R9Svvx6wqvUABH5BIET0ylsExyfUZM0xI58eMvcVYzwvxxzK5Ln0DWSxgZakuU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQPRHBFxDljPS8TrVDIKbLIozJpOZNSIi8v9WNv5gFap6B/ulN
 +PGiUTZ1wDvgLlz3wRD0qU6WKH7l22fuynzzdh9q4M+9CiFKBHjIPbdmvx74VgTMnnhGK5zUvom
 AMfIYsnw1mQpj2MGqskii3TgWOJqb+io=
X-Gm-Gg: AR+sD11yWHtKZam9vKzLM/6mQlQv/IGes7UUN2TXud40CP0ivOEsEw/TWYP7OXVg5cY
 clEw4aZLQ3bwiQgEjhOFWZ5w7i/VOhrRMjdBi1Bk3GocNaUC+xAqxuaKN00dpw4Jzw+3POATru+
 ZVF3XzHX8HCRMt60EDafHF8zPgnz0N1RPRlf/HbIz0VHKbWfgbhdjt6TD39bmn1aj5gpW0itgPm
 opyLDet89jCFbiDhXVdHt0pmAcnXHUa7+/h3e8VJ3bhduLaZFkdC/6k0CxfaeUrDSYEzCgHQLLA
 HUeTg+g1bn5jb6aQ7H9dL2D+F56Mct5IabJKQP3qu9h6nQUOBtRBsnHdTZdV5W/NszHCSPeZ7tY
 V8IFh1dnX1qssu2ypPfhxZIofPjhAfOc=
X-Received: by 2002:a17:90b:1c8d:b0:395:4df3:8800 with SMTP id
 98e67ed59e1d1-395c2f3cdefmr761936a91.0.1787254473619; Thu, 20 Aug 2026
 12:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260601211931.2837-2-gilles.risch@gmail.com>
 <010001a01df94f48-3026542f-b8eb-4661-868e-1d35cfd0254b-000000@email.amazonses.com>
 <CADnq5_N7_w0k5mrgvcEgLZAa4Huv6PP-mTChsoxNx7Vnrb1qzQ@mail.gmail.com>
 <5310cd8c-c0e4-4196-97d3-3bbb57a190a2@gmail.com>
In-Reply-To: <5310cd8c-c0e4-4196-97d3-3bbb57a190a2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 15:34:21 -0400
X-Gm-Features: AcwNN1XhIuYNQVAQ37m4XZblaxYNLpbkADmjJIBR4U-tPODb9taoLSi3miogAC4
Message-ID: <CADnq5_PhfdtFz_hUnGx58YfYvPZYb2ExESuBgQ5UvhbaT-grmA@mail.gmail.com>
Subject: Re: [PATCH v5] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Gilles Risch <gilles.risch@gmail.com>
Cc: Erik Gregg <hank@mowden.top>, alexander.deucher@amd.com, 
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

On Thu, Aug 20, 2026 at 2:59=E2=80=AFPM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> Good afternoon,
>
> no problem, please find attached my complete dmesg output after a fresh
> reboot. I don't see a bit difference, except that my card is connected
> to a different PCI bus.
>
> I don=E2=80=99t pass any kernel parameters via GRUB and I don=E2=80=99t u=
se a xorg.conf
> configuration file either. Have you connected an additional, external
> display?
> Kind regards,
> Gilles
>
> On 20.08.26 15:24, Alex Deucher wrote:
> > On Thu, Aug 20, 2026 at 8:50=E2=80=AFAM Erik Gregg <hank@mowden.top> wr=
ote:
> >> On Mon, 1 Jun 2026 23:19:32 +0200, Gilles Risch <gilles.risch@gmail.co=
m> wrote:
> >>> The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 485=
0
> >>> (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> >>> DisplayPort path. Without this fix the display stays dark under KMS.
> >>>
> >>> This machine suffers from the same issue as iMac10,1 and iMac11,2:
> >>> Apple routes the internal display through Link B of the DIG encoder
> >>> instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> >>> the Apple-specific encoder assignment into its own block, independent
> >>> of the DCE version check.
> >>>
> >>> Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> >>> and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> >>> to avoid affecting other boards.
> >>>
> >>> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> >> I tested this patch on top of 7.1.7-arch1 on a Late 2009 27" iMac11,1
> >> with the Mobility Radeon HD 4850. With nomodeset the machine boots wit=
h
> >> a working (efifb) console. On vanilla 7.1.7 without nomodeset the pane=
l
> >> stays completely black (backlight off) and no radeon init is visible i=
n
> >> dmesg over SSH.
> >>
> >> With the patch and without nomodeset, radeon initializes normally per
> >> dmesg, but at the fbcon modeset (~4s) the panel goes blank and then
> >> shows flashing horizontal lines that start at the top and sweep down a=
t
> >> regular intervals. It never recovers. The logs below are from that cas=
e,
> >> gathered by logging in blind on the console and running commands blind=
.
> >>
> >> I tried radeon.dpm=3D0, radeon.audio=3D0, video=3DeDP-1:2560x1440@60 a=
nd
> >> radeon.modeset=3D1, with no change.
> > I wonder if different variants of the board are wired up differently.
> > @Gilles Risch, can you attach your dmesg output as well?  Maybe there
> > are different panels on different variants?

@Erik Gregg Can you narrow down which hunk(s) if this patch are
problematic?  If I had to guess, I'd say it's this hunk:

+       if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
+           dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
+           dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
+               enc_idx =3D (dig->linkb) ? 1 : 0;
+               goto assigned;
+       }

Alex

> >
> > Alex
> >
> >> Renderer: AMD RV770 (DRM 2.51.0 / 7.1.7-arch1-1-imac), Mesa 26.1.6
> >>
> >> [    3.028962] radeon 0000:02:00.0: fence driver on ring 3 uses gpu ad=
dr 0x0000000020000c0c
> >> [    3.029207] radeon 0000:02:00.0: fence driver on ring 5 uses gpu ad=
dr 0x0000000000056230
> >> [    3.030250] radeon 0000:02:00.0: radeon: using MSI.
> >> [    3.030275] [drm] radeon: irq initialized.
> >> [    3.076796] [drm] ring test on 0 succeeded in 1 usecs
> >> [    3.076803] [drm] ring test on 3 succeeded in 2 usecs
> >> [    3.252855] radeon 0000:02:00.0: [drm] ring test on 5 succeeded in =
1 usecs
> >> [    3.252861] radeon 0000:02:00.0: [drm] UVD initialized successfully=
.
> >> [    3.253264] [drm] ib test on ring 0 succeeded in 0 usecs
> >> [    3.253283] [drm] ib test on ring 3 succeeded in 0 usecs
> >> [    3.906199] radeon 0000:02:00.0: [drm] ib test on ring 5 succeeded
> >> [    3.906669] [drm] radeon atom DIG backlight initialized
> >> [    3.906672] radeon 0000:02:00.0: [drm] Radeon Display Connectors
> >> [    3.906674] radeon 0000:02:00.0: [drm] Connector 0:
> >> [    3.906676] radeon 0000:02:00.0: [drm]   DP-1
> >> [    3.906677] radeon 0000:02:00.0: [drm]   HPD2
> >> [    3.906679] radeon 0000:02:00.0: [drm]   DDC: 0x7e60 0x7e60 0x7e64 =
0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
> >> [    3.906682] radeon 0000:02:00.0: [drm]   Encoders:
> >> [    3.906683] radeon 0000:02:00.0: [drm]     DFP1: INTERNAL_UNIPHY
> >> [    3.906685] radeon 0000:02:00.0: [drm] Connector 1:
> >> [    3.906687] radeon 0000:02:00.0: [drm]   eDP-1
> >> [    3.906688] radeon 0000:02:00.0: [drm]   HPD3
> >> [    3.906689] radeon 0000:02:00.0: [drm]   DDC: 0x7e20 0x7e20 0x7e24 =
0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
> >> [    3.906692] radeon 0000:02:00.0: [drm]   Encoders:
> >> [    3.906693] radeon 0000:02:00.0: [drm]     LCD1: INTERNAL_UNIPHY
> >> [    3.906695] radeon 0000:02:00.0: [drm] Connector 2:
> >> [    3.906697] radeon 0000:02:00.0: [drm]   VGA-1
> >> [    3.906698] radeon 0000:02:00.0: [drm]   DDC: 0x7e40 0x7e40 0x7e44 =
0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> >> [    3.906701] radeon 0000:02:00.0: [drm]   Encoders:
> >> [    3.906702] radeon 0000:02:00.0: [drm]     CRT1: INTERNAL_KLDSCP_DA=
C1
> >> [    3.915213] [drm] Initialized radeon 2.51.0 for 0000:02:00.0 on min=
or 0
> >> [    3.988184] [drm] fb mappable at 0xC0347000
> >> [    3.988187] [drm] vram apper at 0xC0000000
> >> [    3.988188] [drm] size 14745600
> >> [    3.988189] [drm] fb depth is 24
> >> [    3.988190] [drm]    pitch is 10240
> >> [    3.988263] fbcon: radeondrmfb (fb0) is primary device
> >> [    4.026022] radeon 0000:02:00.0: [drm] fb0: radeondrmfb frame buffe=
r device
> >> [    5.366673] systemd[1]: Load Kernel Module drm skipped, unmet condi=
tion check ConditionKernelModuleLoaded=3D!drm
> >> [    8.464118] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops rad=
eon_audio_component_bind_ops [radeon])
> >>
> >> Happy to test further patches or gather more logs.
> >>
> >> Regards,
> >> Erik
>
