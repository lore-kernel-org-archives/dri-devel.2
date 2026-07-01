Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3633C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EB510F108;
	Wed,  1 Jul 2026 23:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f041gQTN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E45E10F108
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:57:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6740A600AF;
 Wed,  1 Jul 2026 23:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48441F000E9;
 Wed,  1 Jul 2026 23:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782950220;
 bh=siK+y9P8hBXMugzbpgWX2QKBvbLXY7R3SHSvdzhdBd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f041gQTNkAQNpTThjr/s0Eh7y8uItDd8Io82EgaXckFzpdsOHP01SaJIdbPjpaQA2
 Ii7Bbnbe45pu0pmyJgQXIP4qlZDwIFZ+5zXM+JeEDvCgTC4pjdJ5Y8FrFn4YADMLu6
 26wzX9iuFDCOhVFhvmxl3hV4FAHxV08LU2XdQR9IcHXqHA1dEa7S8qiypZEegRZvVK
 BsTd7uCrv9YVoOULr1vFFHalZ+VBp8RjEO9lDA1/Eu7CNFTAo/put9X7GzWPdFcSAF
 AvEAWYWvloMkcLld7SQRsqUJwBKyljd0PFK6VYnyZAos0jPMLvr6pgmbM4b4KxdlUO
 DJYQ8eoNXVcMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] fbdev: serialize mode sysfs access with
 lock_fb_info()
To: "Melbin K Mathew" <mlbnkm1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701234248.236023-4-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
 <20260701234248.236023-4-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 23:56:59 +0000
Message-Id: <20260701235659.E48441F000E9@smtp.kernel.org>
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
- [High] show_modes() iterates fb_info->modelist without holding console_lo=
ck(), which is required to protect against concurrent list modifications by=
 fbcon.
- [High] Sysfs store handlers (store_bpp, store_rotate, store_virtual, stor=
e_pan, store_blank) bypass lock_fb_info(), risking torn reads and concurren=
t driver execution.
--

commit 52388e2c8c0d0f6bb72f9bedf44a38f798ee348d
Author: Melbin K Mathew <mlbnkm1@gmail.com>

fbdev: serialize mode sysfs access with lock_fb_info()

show_mode(), show_modes(), and store_mode() access fb_info->modelist
and fb_info->mode without holding lock_fb_info(). This commit adds
lock_fb_info() in these functions to serialize with store_modes() and
avoid data races.

Cc: stable@vger.kernel.org

> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/cor=
e/fbsysfs.c
> index af21dc5052df3..d3d60c555bb86 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c

[ ... ]

> @@ -137,12 +164,15 @@ static ssize_t show_modes(struct device *device, st=
ruct device_attribute *attr,
>  	const struct fb_videomode *mode;
> =20
>  	i =3D 0;
> +	lock_fb_info(fb_info);
>  	list_for_each_entry(modelist, &fb_info->modelist, list) {

[Severity: High]
This is a pre-existing issue, but show_modes() iterates fb_info->modelist
without holding console_lock(), which is required to protect against
concurrent list modifications by fbcon.

Can concurrent VT switches call fbcon_switch() -> fb_set_var() ->
fb_add_videomode() and modify fb_info->modelist under console_lock()
without holding lock_fb_info()? Would an unprivileged user reading
this sysfs attribute risk a torn pointer or out-of-bounds access
since console_lock() is missing here?

>  		mode =3D &modelist->mode;
>  		i +=3D mode_string(buf, PAGE_SIZE, i, mode);
>  		if (i >=3D PAGE_SIZE - 1)
>  			break;
>  	}
> +	unlock_fb_info(fb_info);
> +
>  	return i;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but other sysfs store handlers
(store_bpp, store_rotate, store_virtual, store_pan, store_blank) bypass
lock_fb_info(), risking torn reads and concurrent driver execution.

For example, in store_bpp(), store_rotate(), and store_virtual(),
fb_info->var is read locklessly before activating it. In store_pan()
and store_blank(), driver functions like fb_pan_display() or
fb_blank_from_user() are invoked without taking lock_fb_info().

Does this bypass the mutual exclusion that drivers rely on in the
equivalent ioctl paths? Could this result in applying corrupt
configurations to hardware or concurrent execution of non-reentrant
driver code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701231706.2347=
15-1-mlbnkm1@gmail.com?part=3D3
