Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089D6C88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA9810E4C7;
	Sat, 12 Sep 2026 21:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pwer88JW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B5810E4C7
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:29:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69AF360213;
 Sat, 12 Sep 2026 21:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016901F000FF;
 Sat, 12 Sep 2026 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789248563;
 bh=xuCMal6XNEGqi/A5sUZYPzUWIVGmU9ZbBcFcIwfOXSU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pwer88JWA5Q7Os0AgTRsCvs92VPVlz3rGD7GFaUQmsQz7aoPjxEnSmjCaKx/rOL+n
 Qg5e9KR4zvycAYqzL79kjk2/Uz6u8Df8Y0TMO7l0bnp2kKyXhrzkH4vbzAgo2x2cZP
 ovhRumJBTZ5lz3TG6ekYxs4PAsYoibUqTuRTZY5v2VZHM9yL3dPJk3o9AIhIDZguoe
 dwQS0GJWmzA+N0WsSYPnyMq8W9I+ZUJAn32bnZk9vDX+0LRNfHXqgxFjBGw4qD/3tU
 yeoMMA+1IpBgoR4jQFUOTAzP1c8Fs8N9lHdPwieCI02fCcHtVzwaUBsIXOtR+rBvrW
 nrNaAyGIYRk6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: udlfb: don't rebuild the mode list while the
 framebuffer is in use
To: "Xiang Mei" <xmei5@asu.edu>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912211512.2049147-1-xmei5@asu.edu>
References: <20260912211512.2049147-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 21:29:22 +0000
Message-Id: <20260912212923.016901F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing locking in edid_store() leads to data races, double free, =
and memory corruption.
- [High] The patch fails to prevent a Use-After-Free of `fb_info->mode` via=
 sysfs attributes.
- [High] The `edid` sysfs attribute is world-writable (0666), enabling unpr=
ivileged users to exploit multiple driver vulnerabilities.
- [Medium] Repeated calls to `dlfb_setup_modes()` leak the old `dlfb->edid`=
 buffer.
- [Medium] Unbounded memory leak of the dynamically allocated `info->monspe=
cs.modedb` array.
--

commit c422e1f65727b9cb9b5d809088416cf97c54aea9
Author: Xiang Mei <xmei5@asu.edu>

fbdev: udlfb: don't rebuild the mode list while the framebuffer is in use

This commit attempts to fix a use-after-free in fb_videomode_to_var() by
checking dlfb->fb_count before destroying the modelist in
dlfb_setup_modes(). This prevents fbcon from referencing a freed mode
list.

Link: https://lore.kernel.org/all/1jSCSNaDKmuUG7h40rTsSl1rMaSwdlJef4rp%40bu=
gs.sh/

> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index e78d6f95c9c5c..92b352bc7e969 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1293,6 +1293,11 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
>  		goto error;
>  	}
> =20
> +	if (dlfb->fb_count) {
> +		result =3D -EINVAL;
> +		goto error;
> +	}
> +
>  	fb_destroy_modelist(&info->modelist);

[Severity: High]
This isn't a bug introduced by this patch, but does writing to the mode sys=
fs
attribute increment dlfb->fb_count?

If an unprivileged user sets fb_info->mode to a node in info->modelist via
fbsysfs.c:store_mode(), and then writes to the edid sysfs attribute,
dlfb->fb_count remains 0. The check above passes, and fb_destroy_modelist()
is executed, leaving fb_info->mode as a dangling pointer.

Subsequent reads from the mode sysfs attribute would invoke show_mode(),
triggering a use-after-free.

>  	memset(&info->monspecs, 0, sizeof(info->monspecs));

[Severity: Medium]
This is a pre-existing issue, but does this memset() leak the dynamically
allocated info->monspecs.modedb array?

If fb_edid_to_monspecs() previously parsed the EDID and dynamically allocat=
ed
the array of struct fb_videomode, unconditionally zeroing the structure here
appears to erase the pointer before it can be freed, leaking the memory on
every sysfs write.

[Severity: Medium]
While not introduced by this patch, could this leak the old dlfb->edid
buffer?

When dlfb_setup_modes() succeeds:

drivers/video/fbdev/udlfb.c:dlfb_setup_modes() {
    ...
		if (info->monspecs.modedb_len > 0) {
			dlfb->edid =3D edid;
			dlfb->edid_size =3D i;
			break;
		}
    ...
}

Does this overwrite dlfb->edid with a newly allocated 128-byte edid buffer
without freeing the previous pointer?


[Severity: High]
This is a pre-existing issue, but is it safe for edid_store() to call
dlfb_ops_set_par() without holding info->lock?

drivers/video/fbdev/udlfb.c:edid_store() {
    ...
	ret =3D dlfb_ops_set_par(fb_info);
    ...
}

dlfb_ops_set_par() invokes dlfb_realloc_framebuffer() which performs memory
freeing and list_add() operations, explicitly relying on the lock:

drivers/video/fbdev/udlfb.c:dlfb_realloc_framebuffer() {
/*
 * Assumes &info->lock held by caller
 */
static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb,
                                    struct fb_info *info, u32 new_len)
    ...
}

If an unprivileged user concurrently writes to the edid sysfs attribute,
could this lead to data races resulting in a double-free of
info->screen_buffer and list corruption on dlfb->deferred_free?


[Severity: High]
Finally, as a pre-existing issue, should the edid sysfs attribute be
world-writable?

drivers/video/fbdev/udlfb.c:edid_attr {
static const struct bin_attribute edid_attr =3D {
	.attr.name =3D "edid",
	.attr.mode =3D 0666,
	.size =3D EDID_LENGTH,
	.read =3D edid_show,
	.write =3D edid_store
};
}

This 0666 permission allows any unprivileged user to alter the physical
display configuration, and easily trigger the memory leaks, double frees,
and use-after-free vulnerabilities mentioned above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912211512.2049=
147-1-xmei5@asu.edu?part=3D1
