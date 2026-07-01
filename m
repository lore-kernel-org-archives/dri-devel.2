Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADF1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D26010E3E2;
	Wed,  1 Jul 2026 23:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lFFHhxLT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02D310E3E2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:26:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B5F06001D;
 Wed,  1 Jul 2026 23:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EFC1F000E9;
 Wed,  1 Jul 2026 23:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782948418;
 bh=Rwr89121+WvTFwXuO/hsNGZiWo2/z7Zocp3P/zLdz7E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lFFHhxLTwgSbsMgWTOhlBAxXFS7AmngY8SQUquwNkfb7PrumjjIUMXSLYDOnLGFBq
 Vs18EEFER06xkrj2oA4ah8gvOOp54E2WdxV3bLBL2ou5EjwHELumFGG6tUNSrzRBp7
 dX1NpNmNIfA+gb9p5mCAWPUyyUFpRBz4CTDtfxfcBU7zg/wybiACyKMdxS8zOaW/+U
 pQItN9YHRVLo6389tpEA4BGWU7eFKtx7Al0n2VXL37Pzc53ChP7XrqQ0b3umisGJYI
 nDaEQrEK5W+fgqQkfQ4lmQ6iq+f/1SW6pO6y26Uws4dlrULMUKzcvYOyMT5Xuizo6A
 5ft6R2+xKUmCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] fbdev: bound mode sysfs output to the sysfs buffer
To: "Melbin K Mathew" <mlbnkm1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701231706.234715-2-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
 <20260701231706.234715-2-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 23:26:57 +0000
Message-Id: <20260701232657.E0EFC1F000E9@smtp.kernel.org>
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
- [High] Lockless reads of `fb_info->var` cause torn reads and state corrup=
tion.
--

commit b5317fd1a6886d886e344587e27b5ae1721b2542
Author: Melbin K Mathew <mlbnkm1@gmail.com>

fbdev: bound mode sysfs output to the sysfs buffer
   =20
mode_string() uses snprintf() which can return a value larger than the
remaining buffer space. show_modes() accumulates the return value into i
without checking whether i has reached PAGE_SIZE. This commit adds a size
parameter to mode_string() and uses scnprintf() to return only the bytes
actually written.
   =20
Cc: stable@vger.kernel.org

> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/cor=
e/fbsysfs.c
> index ea196603c7a87..af21dc5052df3 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c

[ ... ]

> @@ -64,7 +67,7 @@ static ssize_t store_mode(struct device *device, struct=
 device_attribute *attr,
> =20
>  	list_for_each_entry(modelist, &fb_info->modelist, list) {
>  		mode =3D &modelist->mode;
> -		i =3D mode_string(mstr, 0, mode);
> +		i =3D mode_string(mstr, sizeof(mstr), 0, mode);
>  		if (strncmp(mstr, buf, max(count, i)) =3D=3D 0) {
> =20
>  			var =3D fb_info->var;

[Severity: High]
This isn't a bug introduced by this patch, but while looking at fbsysfs.c,
I noticed several other functions perform a lockless copy of the
fb_info->var struct:

    var =3D fb_info->var;

This happens in store_bpp(), store_rotate(), store_virtual(), and store_pan=
().

If this lockless sysfs read races with an ioctl(FBIOPUT_VSCREENINFO)
executing fb_set_var() (which modifies info->var under fb_info->lock),
could it tear the large struct fb_var_screeninfo?

Modifying and writing this corrupted state back to the hardware via activat=
e()
or fb_pan_display() might configure the display controller with invalid=20
settings, potentially causing display corruption or crashes in low-level=20
graphics drivers.

Should these other functions also serialize their access with lock_fb_info(=
)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701221757.2314=
90-1-mlbnkm1@gmail.com?part=3D1
