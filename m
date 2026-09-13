Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF0C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEB910EA29;
	Sun, 13 Sep 2026 21:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ynn/NWGQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A131110EA29
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:08:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEE2460FD2;
 Sun, 13 Sep 2026 21:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24141F000FF;
 Sun, 13 Sep 2026 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789333717;
 bh=vRvOj75Y/SwrfSsu8ZOrne36Y4OtabCRBZjebXP/bM8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ynn/NWGQymg3WGuHRWRijSLhaV0NGQL7bPlkWUwsfHqvogwJj9xM/JtcYplnTNrGa
 FUQ12cpJbTdTui2/9rHZMt4mZeXxlxiMsPX+wKQ5ZpE5KkHehNO/qpX0vRLp3QagYc
 40yvT90zlXRbDpjtwArwI0QADx0UBhuLksmJX5v2PfOGyqtYpxNCcoxdxL7WSYv5Sd
 slpyRftwTA0L9rySeEGrkdLixOOQL5zz+TTUpxi9XMmfMPQlPtW29sRNub8495xGrN
 ++iebesJwMfbt0yVD3JuK9eFmrKqhAd8zlbtrpdxO7way+3nZkvapQFyYq7HibhUvk
 Q/wuFThWGelpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbdev: sh_mobile_lcdcfb: Restore the per-overlay
 sysfs attributes
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912102152.86744-1-kmehltretter@gmail.com>
References: <20260912102152.86744-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:08:36 +0000
Message-Id: <20260913210836.F24141F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Framebuffer structure (`fb_info`) Use-After-Free and registration =
leak if `fb_device_create` fails.
- [High] Concurrent sysfs stores and fbdev ioctls cause data races and hard=
ware register clobbering due to missing locks.
--

commit 2445fda1d6b2eaa304debdee2b9155ce76236747
Author: Karl Mehltretter <kmehltretter@gmail.com>

fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes

This commit restores the per-overlay sysfs attributes by renaming them and
registering the sysfs groups on each overlay's framebuffer device instead
of the platform driver's dev_groups. It also fixes incorrect dev_get_drvdat=
a()
accesses caused by an earlier regression.

> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev=
/sh_mobile_lcdcfb.c
> index e8324b01700f6..5743c96d54814 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
[ ... ]
> @@ -1337,22 +1337,24 @@ overlay_rop3_store(struct device *dev, struct dev=
ice_attribute *attr,
>  	return count;
>  }
> =20
> -static DEVICE_ATTR_RW(overlay_alpha);
> -static DEVICE_ATTR_RW(overlay_mode);
> -static DEVICE_ATTR_RW(overlay_position);
> -static DEVICE_ATTR_RW(overlay_rop3);
> -
> -static struct attribute *overlay_sysfs_attrs[] __maybe_unused =3D {
> -	&dev_attr_overlay_alpha.attr,
> -	&dev_attr_overlay_mode.attr,
> -	&dev_attr_overlay_position.attr,
> -	&dev_attr_overlay_rop3.attr,
> +static struct device_attribute dev_attr_ovl_alpha =3D
> +	__ATTR(ovl_alpha, 0644, overlay_alpha_show, overlay_alpha_store);

[Severity: High]
This isn't a bug introduced by this patch, but do these sysfs store
callbacks need locking to prevent hardware state corruption?

Functions like overlay_alpha_store() and overlay_rop3_store() modify
overlay state variables and call sh_mobile_lcdc_overlay_setup() to perform
direct I/O writes to the LCDC hardware registers without acquiring any lock=
s.

Concurrently, standard fbdev ioctls like fb_blank() modify the same state
and call sh_mobile_lcdc_overlay_setup() from sh_mobile_lcdc_overlay_blank()
while properly holding info->lock.

Could concurrent sysfs writes and fbdev ioctls interleave register writes a=
nd
clobber the hardware state?

[ ... ]
> @@ -1510,9 +1512,10 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mob=
ile_lcdc_overlay *ovl)
>  {
>  	struct fb_info *info =3D ovl->info;
> =20
> -	if (info =3D=3D NULL || info->dev =3D=3D NULL)
> +	if (!info || !dev_of_fbinfo(info))
>  		return;

[Severity: High]
This is a pre-existing issue, but does this early return cause a memory leak
and use-after-free in the fbdev core?

If fb_device_create() fails due to memory pressure or sysfs conflicts,
info->dev is set to NULL but register_framebuffer() still returns success.
When tearing down the device, this check for dev_of_fbinfo() evaluates to
true and causes an early return, bypassing unregister_framebuffer().

Later, sh_mobile_lcdc_overlay_fb_cleanup() calls framebuffer_release(), whi=
ch
frees the fb_info structure while it is still linked in the fbdev core's
registered_fb array.

Can unregister_framebuffer() be called regardless of whether device creation
succeeded, both here and in sh_mobile_lcdc_channel_fb_unregister()?

> =20
> +	device_remove_groups(dev_of_fbinfo(info), overlay_sysfs_groups);
>  	unregister_framebuffer(ovl->info);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912102152.8674=
4-1-kmehltretter@gmail.com?part=3D1
