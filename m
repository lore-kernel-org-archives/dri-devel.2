Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1303C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAFE10EF9B;
	Wed,  1 Jul 2026 22:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M5Y3S2Wu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6555310EF9B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 22:30:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD26C43A3B;
 Wed,  1 Jul 2026 22:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC6E1F000E9;
 Wed,  1 Jul 2026 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782945033;
 bh=rxaZl1iNZt5ANy1KMZUBn5YsbnoowvqTaCw1xC/QJKU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M5Y3S2WuUuaNC6kP/tmWzKOxn5U/uPHSzoOq2WcX9md86+/ZvIdD0Wl+WS2sfFfg7
 OXlfiNL/D80pE7LWNx3kk3mBA0w2E6pLszmnL476MgONOuSCOdYoijuOxkzbR1QkuC
 Lai18R2CSV8Bd65MnVzzYwLpSt7eiqJ+wl4LFdmwxQLAb6KCvbIIMJrH2OouhrX/IZ
 BhZsJ9isNqAutqkh4dTuhV0bkOeRoyPRGhTdLWm7BMXTsFHPuezPX5uujtj1Ml+Dtl
 LvO8rPZdV0UveiXZYXjKYDFOC6GTZk/Gtqb2ESiArMxMQOhGDkjAjkgWFvRJqPML1d
 gRHZn7GZgrPIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: protect mode sysfs reads with lock_fb_info()
To: "Melbin K Mathew" <mlbnkm1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701221757.231490-1-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 22:30:32 +0000
Message-Id: <20260701223033.5CC6E1F000E9@smtp.kernel.org>
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
- [High] The patch fails to resolve the local kernel Use-After-Free because=
 it misses lockless traversal and assignment in `store_mode()`.
- [High] Unprivileged local DoS via WARN_ON_ONCE triggered by snprintf size=
 underflow in show_modes().
--

commit 781c0f45188865f8a46896496380e20ca20b9af8
Author: Melbin K Mathew <mlbnkm1@gmail.com>

fbdev: protect mode sysfs reads with lock_fb_info()

This commit adds lock_fb_info() around mode sysfs reads to protect
against concurrent modifications to the modelist by store_modes().

> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/cor=
e/fbsysfs.c
> index ea196603c7a87..6bdb25f7be018 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c

[ ... ]

> @@ -82,11 +82,20 @@ static ssize_t show_mode(struct device *device, struc=
t device_attribute *attr,
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
> +		have_mode =3D true;
> +	}
> +	unlock_fb_info(fb_info);

[Severity: High]
This is a pre-existing issue, but does store_mode() also need similar locki=
ng
protection to fully prevent the use-after-free?

While this patch protects show_mode() and show_modes(), store_mode() still
traverses the modelist locklessly:

drivers/video/fbdev/core/fbsysfs.c:store_mode() {
    ...
    list_for_each_entry(modelist, &fb_info->modelist, list) {
    ...
}

If store_modes() concurrently clears and frees the modelist, could
store_mode() traverse freed list elements?

Additionally, store_mode() locklessly assigns the mode pointer:

drivers/video/fbdev/core/fbsysfs.c:store_mode() {
    ...
    fb_info->mode =3D mode;
    ...
}

If store_modes() freed the old modelist in the interim, could this resurrect
a dangling pointer into fb_info->mode and bypass the fix for subsequent
readers?

[ ... ]

> @@ -134,10 +143,13 @@ static ssize_t show_modes(struct device *device, st=
ruct device_attribute *attr,
>  	const struct fb_videomode *mode;
> =20
>  	i =3D 0;
> +	lock_fb_info(fb_info);
>  	list_for_each_entry(modelist, &fb_info->modelist, list) {
>  		mode =3D &modelist->mode;
>  		i +=3D mode_string(buf, i, mode);
>  	}

[Severity: High]
This is a pre-existing issue, but can this loop trigger a WARN_ON_ONCE
due to integer underflow if the modelist is large?

If the accumulated length in i exceeds PAGE_SIZE (for example, with a very
large modelist), the size calculation in mode_string() appears to underflow:

drivers/video/fbdev/core/fbsysfs.c:mode_string() {
    ...
    return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
                    m, mode->xres, mode->yres, v, mode->refresh);
}

Since offset is unsigned, PAGE_SIZE - offset would become a massive positive
value, which vsnprintf() detects as exceeding INT_MAX and triggers a
WARN_ON_ONCE. Could an unprivileged local user trigger a kernel panic on
systems with panic_on_warn=3D1 by repeatedly reading the modes sysfs file?

> +	unlock_fb_info(fb_info);
> +
>  	return i;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701221757.2314=
90-1-mlbnkm1@gmail.com?part=3D1
