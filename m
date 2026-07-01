Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB9FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A21510F103;
	Wed,  1 Jul 2026 23:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="exeMoj6M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34E810E3F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:29:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55C1640885;
 Wed,  1 Jul 2026 23:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9211F000E9;
 Wed,  1 Jul 2026 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782948596;
 bh=Aji1VCHNBG70AcgzJ17mQp6B24S/sj8zEkkZne1FyrQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=exeMoj6MTTMLQKpPVBlyVB9EAS8EkLGGeTjOM9NHslFjdnY8W7PQH4I80cRG51h9x
 //DU9Q1ISCA9CDE/vcgegjP/FRIo6IRe00j1hJmUYD8gCFQwllpih29niJ989sYDkA
 guRQ9h0PznxN/WKysOx8CzWo5mQfnldECpkNEOF3Xiomug4p+wjtc6gKVa37Y5IYKl
 V2twgOnncT4c+PhyovPwXYzgjGa3Qa6WXgauV7iKssY1OJIYWN3AVL7ZYWyLmJOJ96
 t0lz4rmPsbjFjtu1wEdylmFM4FBAnrUMteUFAzW/ykekZnDRr1JHaLSVRLr+e94CGT
 Z1EOibIEYNMNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] fbdev: serialize mode sysfs access with
 lock_fb_info()
To: "Melbin K Mathew" <mlbnkm1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701231706.234715-3-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
 <20260701231706.234715-3-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 23:29:55 +0000
Message-Id: <20260701232956.0B9211F000E9@smtp.kernel.org>
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
- [High] fb_info->mode can become a dangling pointer if the active mode is =
deleted via ioctl(FBIOPUT_VSCREENINFO) with FB_ACTIVATE_INV_MODE, leading t=
o a Use-After-Free in show_mode().
--

commit 243c82e865602245e21ae16b7cdd7738ccfa6a53
Author: Melbin K Mathew <mlbnkm1@gmail.com>

fbdev: serialize mode sysfs access with lock_fb_info()

Take lock_fb_info() in show_mode(), show_modes(), and store_mode() to
serialize with store_modes(). In show_mode(), copy the mode to the
stack and format after dropping the lock. In store_mode(), split
activate() into a _locked variant to avoid double-locking.

> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/cor=
e/fbsysfs.c
> index af21dc5052df3..d3d60c555bb86 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c

[ ... ]

> @@ -85,11 +103,20 @@ static ssize_t show_mode(struct device *device, stru=
ct device_attribute *attr,
>  			 char *buf)
>  {
>  	struct fb_info *fb_info =3D dev_get_drvdata(device);
> +	struct fb_videomode mode;
> +	bool have_mode =3D false;
> =20
> -	if (!fb_info->mode)
> +	lock_fb_info(fb_info);
> +	if (fb_info->mode) {
> +		mode =3D *fb_info->mode;

[Severity: High]
This is a pre-existing issue, but can fb_info->mode become a dangling point=
er
and lead to a use-after-free here?

If the active mode is deleted via ioctl(FBIOPUT_VSCREENINFO) with
FB_ACTIVATE_INV_MODE, it appears fb_delete_videomode() unlinks and frees
the mode node:

drivers/video/fbdev/core/modedb.c:fb_delete_videomode() {
    ...
    list_del(pos);
    kfree(pos);
    ...
}

However, it does not seem to clear the fb_info->mode reference. If a user
subsequently reads /sys/class/graphics/fb0/mode, would this dereference the
freed memory even while holding the lock?

> +		have_mode =3D true;
> +	}
> +	unlock_fb_info(fb_info);
> +
> +	if (!have_mode)
>  		return 0;
> =20
> -	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
> +	return mode_string(buf, PAGE_SIZE, 0, &mode);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701221757.2314=
90-1-mlbnkm1@gmail.com?part=3D2
