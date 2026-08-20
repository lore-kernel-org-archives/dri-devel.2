Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049AEC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6358510F02D;
	Thu, 20 Aug 2026 13:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gML6kYK7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D78110F024
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:25:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FF1344016;
 Thu, 20 Aug 2026 13:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094B91F00A3E;
 Thu, 20 Aug 2026 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787232325;
 bh=VQkAyst9uD67IFAIMVwA5FtyjzPfhLcpi0iskRX/v+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gML6kYK70jiOVdit4JX7I1y0h+lpQLIBNo5uVzMJHBPDs84P6FSXzSAJT9xK2Jw6D
 AvHThkqwLsb8KmKmQMKUJbgL235TwrTOjNQGltM3RrscDQ6L1lCaVE3MGG1upYxImi
 TKiaQ0qMdjPlD7VtELP+QdBK83YKnHaGtlLF4DsU3R+P/me6W7MRbmbHcuOFBCXlMP
 64eHtQDLIF+oKgbM92qR1Dp7JnjVeH68XKYFnIu9ot/0szPnL2m1LF+/CW9+2Zbn6q
 qe0yfCFGFBX1WRuPu3h79ucSapJTY/GJIA9PTxt0InUyiP74Bd4JqaR3T/C4iY9uT3
 25RH1le7q90ZQ==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory"
 has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026082007-trouble-unscrew-aa17@gregkh>
References: <2026082007-trouble-unscrew-aa17@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 13:25:24 +0000
Message-Id: <20260820132525.094B91F00A3E@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An integer underflow in the `tegra_fb_create` plane size calculati=
on allows an attacker to bypass GEM object bounds checks, leading to an out=
-of-bounds DMA read by the display controller.
--

--- Patch [1]: Patch "drm/tegra: fbdev: Remove offset into framebuffer memo=
ry" has been added to the 6.1-stable tree ---
commit 696762710748d2e202ebca2f2997d6adca30bffb
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has been ad=
ded to the 6.1-stable tree

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Link: https://patch.msgid.link/20260421073646.144712-3-tzimmermann@suse.de

> diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> index 9291209154a7a..0e908e7f7b721 100644
> --- a/drivers/gpu/drm/tegra/fb.c
> +++ b/drivers/gpu/drm/tegra/fb.c

[Severity: High]
This isn't a bug introduced by this patch, but does an integer underflow in
tegra_fb_create() allow bypassing GEM object bounds checks?

If a user calls DRM_IOCTL_MODE_ADDFB2 with cmd->height =3D 1 and a subsampl=
ed
pixel format (like YUV420 where vsub =3D 2), the plane height calculation
evaluates to 0:

    unsigned int height =3D cmd->height / (i ? info->vsub : 1);

Then, the size computation evaluates to:

    size =3D (height - 1) * cmd->pitches[i] +
           width * bpp + cmd->offsets[i];

Because height is 0, (height - 1) underflows to UINT_MAX. In 32-bit
arithmetic, UINT_MAX * pitches[i] is equivalent to -pitches[i], which can
result in a small positive size if an attacker supplies specifically crafted
pitches and offsets.

This artificially small size easily passes the bounds check:

    if (gem->size < size) {
        err =3D -EINVAL;
        goto unreference;
    }

The display controller could then be programmed with bo->iova + offsets[i],
pointing far beyond the GEM object's bounds, which may lead to an
out-of-bounds DMA read.

> @@ -267,9 +266,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *he=
lper,
> =20
>  	drm_fb_helper_fill_info(info, helper, sizes);
> =20
> -	offset =3D info->var.xoffset * bytes_per_pixel +
> -		 info->var.yoffset * fb->pitches[0];
> -

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026082007-trouble-=
unscrew-aa17@gregkh?part=3D1
