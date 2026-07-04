Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C77AC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 22:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E50810E0DE;
	Sat,  4 Jul 2026 22:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bd+LYDEV";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0545210E0DE
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 22:04:31 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39afb0d9f7eso16404571fa.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 15:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783202669; cv=none;
 d=google.com; s=arc-20260327;
 b=n1uTPcdEtL4sbsblgZvpKJkUFNA1M+t58UbuVGNgxojXP0FnWNgDOCbCqAqdlhkzVb
 v1s5q8nF+cc+fnLudZr+n27TITRq5gG5Li7gzDIIXofSRj3ycUPZ9laLjxxSUHW20/Iu
 PmBPFaxaHZBjPhXf43sZv215gQIQ8Icv/PErKRORB8GNj6fxiYbL1o4Y/WJbGF90Uy/F
 iVtbKN98zEfCJ2sXbWF3aoao1ykE/CIpKzlLt/vcmZQacunmN+snLIFky98sLOzVb5X+
 OaafmVrsemCOYni5nOi/SsRfS5GsjMumWFRJXe/ni5ZLwOrzWvJHKuJC/Qr/NLy5Ccgg
 EJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=imtw4Ja43+86I9p9y9tUxtB3JG8gRr4QZxWm1ZiCc9w=;
 fh=NVdf2cEPp+vcRT5MxnApYu2RXnwD6WKcZL4sJXCpc6s=;
 b=AJCJIYfVBv852Ex2BvoZmNtfbKX8YmtGKpbBFAqTIFPxhX/15y/OCxI8aFQI2LSyrR
 oywAqa60QsT4FDDPa/4SK08TNr5ZxpuLX0nbWyFGYSE5EJv7w3hGwyYkytIxVb3NtEie
 OBBJG4TxSLDZ8AnVvPP37WyN7G49NELpiKdTVkLXYs+HseFrnfzIAteU237Z3cGKvpft
 bsmi628MTuiuY2QeICRMwKC6kP7U6miTcyhiiYwomjDhZI8p3MeXJJYaZ/hvNjJ7eDWv
 csnrzVT89qfuwFIBKqjMJ1uENjhWGnCBeBHWNQu90KAee9LFFxAC862fnPLda6XfNrSk
 4Frg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783202669; x=1783807469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imtw4Ja43+86I9p9y9tUxtB3JG8gRr4QZxWm1ZiCc9w=;
 b=bd+LYDEVp1Ujynw2cEinc2AwaDXVZjClbVY9iVXfOUUTSrSgaJ/ekyzcC3Mwjg3/4Z
 zi5nX0j+mUAw+dDMmQqvrUd/1pwyQK1LKX47OMebXKSe2DkCcq5I8xcCfKPEtNBJgy3H
 5ee9CIvup6A24kd5NZVh7V5k83L1KjLCZ56v9Kn4swWJ9egxyCLv9p61Haxu5g0e9kpg
 efCEvlw2EUgl4sttBo0Rg3LJUtvSlvvOc3soohxcuIoMjPOagMN8fdZ97FjPmsrvtwqZ
 p+JTepmSBTC5+jJFd8kDpXn7t5FGN00mAHcYLgMJJ7lZdnySFEW6lv6Flfsbq9EGZK8w
 NS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783202669; x=1783807469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=imtw4Ja43+86I9p9y9tUxtB3JG8gRr4QZxWm1ZiCc9w=;
 b=WCWTKYslxVNuoc4XwW1tpAry9NxKOm9buv4Z7ShtVVDN4jyT/0mYdjg2A/AZmCnhe1
 yTAvlL34NTuTPuZz8LiYW1Wahvvm2578iOo9/kgjuzl1ddKeJpABsylzQZqY79nPeAV2
 0yxEvOoFul5TUtDrs3kAy1hV4sGtB3KF0F6xIB7+EcJ4TQbS4o8G6gFrF33ZMHCf9qMR
 zikwaqUXwhWR3wAUna9XK02TFPUzu6DafPcS3W+06rdOfjP1iv/mJjmsxsBGhHMHpd2I
 L5A8xEoyU2kiaE6IYDBedidAizOKR3Sf7dE2gfF1YdWSwRdJNm7fkgncYsROt7ZX8fCn
 UBRQ==
X-Gm-Message-State: AOJu0YxqyVxyhKF9JD2xQgRwC+xK9mLbl7iP9vJLMo8ijXJVD+fYgL8y
 GTv2GOEAf1gLXz73qCFl03Ieki5ksaN4iB//p/VkzKy7SQSR9tlllLtIogKn5YwEOnK6sQkvukD
 GTThOq6ZtgDIP+iNP3+6L8kOx3wyrkCQ=
X-Gm-Gg: AfdE7ckmPAFukzlzL008uQqiqcqQYsWn/GTj4UqPhQai67W+CAXNvqXjM61DtNlAId/
 YbyxBxYxjT02tlUifMrZS9yaBSRo+tcQHUBdjrTBp6ZoBNuzx0dKBreP6lO5ljn3jz1GF86SGZ0
 pfMx3v58a22nefCyiCEL84rDZgqRvs7+E+m+oHwmYiKBO1S0SgXLjghn+bqwTgmkAupSNfKdCH6
 MnL7LMZHkDOvRHT96HBYA9W/jy77GcPYRtKC6wf35qw/G9rgHrGiopi4GhQUVt2kCe/Q16iUvn0
 YCVIrlDr4u4nycmQddogQIeqen1TgeS4rEFwkhOvP+HCxEA2wbNnzzyWhN/PIQ==
X-Received: by 2002:a05:651c:2102:b0:39a:e9c1:5809 with SMTP id
 38308e7fff4ca-39b53b5b23cmr8342201fa.3.1783202668746; Sat, 04 Jul 2026
 15:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
In-Reply-To: <aj5MNiKSCiEDvDzL@raspi>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 5 Jul 2026 03:33:51 +0530
X-Gm-Features: AVVi8CcSIfFK5hT-w5CsIKgn7jtLkN9mCQbJXOSTVkqzWIMXRePG02SF--UMxGI
Message-ID: <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, marex@nabladev.com, 
 daniel.baluta@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 airlied@gmail.com, simona@ffwll.ch
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

On Fri, Jun 26, 2026 at 3:22=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle wrote:
>
> [...]
>
> > The current dc/ implementation is a multi-device component driver with =
one
> > platform_driver per block bound via the component framework. The downst=
ream
> > i.MX95 driver is a single monolithic platform_driver mapping all blocks=
 from
> > one register base. Unifying appears to require reconciling two bind mod=
els,
> > rather than only adding match_data.
>
> I think that upstream i.MX95 display controller driver would also be base=
d
> on the component helper.  That's something for sure.
>
> [...]
>
> > There is also anticipated divergence which is not yet upstream (i.MX8QX=
P
> > prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95 blit
> > engine), although mainline dc/ is KMS-only today.
>
> Just want to point out that I sent out v5 patch set[2] to add i.MX8QXP
> prefetch engine(DPRC + PRG) support for KMS.  That changes the driver's
> mode setting code a lot.
>
> [2] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d49=
41@nxp.com/
>
> [...]
>
> > One question for Liu Ying is whether the separate-driver plus shared
> > helper-library approach is still the preferred direction, and where the
> > helper boundary would be drawn (which blocks/ops are shared versus
> > implemented per driver).
>
> Yes, separate DRM drivers + a helper library approach is still the direct=
ion
> I want.  I think that the drivers and library would sit in the same
> directory drivers/gpu/drm/imx/dc/.
>
> The purpose to add a library is to share code to reduce overall code line=
s.
> I'd assume that shared blocks or common part of slightly different blocks
> should be covered by the library.
>
> [...]
>
> > how the component and monolithic driver models
> > would be reconciled given the differences described above.
>
> Like I said above, I don't think upstream driver would be monolithic.
>
> --
> Regards,
> Liu Ying

Hi Liu,

A quick follow-up with some progress.
I went ahead with the refactoring we discussed and now have it working on t=
he
i.MX95 15x15 FRDM, following the component-based model.
The common implementations for ConstFrame, ExtDst, LayerBlend, FrameGen and
the FetchUnit base have been moved into shared dc-lib-* helpers, with
SoC-specific register layouts and tables supplied as data. The per-SoC glue=
 is
split into dc-drv-common.c, dc-drv-imx8qxp.c and dc-drv-imx95.c, while
i.MX95-specific blocks such as DomainBlend, Dither, FetchEco, FetchYUV,
HScaler and VScaler remain separate component drivers.

The implementation is functional on the FRDM over the pipeline
DPU -> pixel-interleaver -> pixel-link -> LDB -> LVDS PHY -> IT6263 -> HDMI

EDID is read successfully, the initial modeset works for all tested modes
(1920x1080@60, 1280x720@60, 720x480 and 640x480), and Weston and sway both =
run.

There are still two known limitations. The initial modeset works, but
subsequent mode changes currently wedge the ExtDst content shadow load, whi=
ch
appears related to the lack of a reset path for the i.MX95 FrameGen. In
addition, the DSI path is implemented on the DC side but remains unvalidate=
d.

The implementation is currently based on v7.2-rc1 together with your prefet=
ch
v5 series.

The work is now ready to be posted as patch series: Adding LVDS/DSI
i.MX95 support.


Regards,
Piyush Patle
