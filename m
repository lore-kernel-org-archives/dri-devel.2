Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDEACDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0BE10E30C;
	Fri, 26 Jun 2026 05:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lxVqQL5F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325DC10E30C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:09:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48A3660098;
 Fri, 26 Jun 2026 05:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13871F000E9;
 Fri, 26 Jun 2026 05:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782450543;
 bh=VjjHz0qKSG91xc6NHzmoYcfnjU98Hz08LdbTuxGTHbc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lxVqQL5FkeFcsqH7SfAKeDOoxcCKWr/k6G9kEnN8u7ERCdudNp6JYl3Y++SMf/IpG
 vXZulsqmS2UD8ZHzwIvTt/MElAo0VX1Zk8ijAx0UibnHHZwTMSwPAGpwFPrdRv+WM6
 CYodgaQf0PGeAbQZuY3K540dXNpXPxwRMwerkdxFqlaAH+XcdS5LxyRVYUA+MY5eJX
 hpHmS/0SlBse13+PU1AEWDgb1HDeZb/2SqOO1xUjtibtdqliOk37sW0/RqqbL2r7Xd
 dkIkFy/jD5XeQKnRLToHW963+2MT8jXhsQgth9rrhOIwmfjwvgidK2sSC7fSJrAUNG
 c9QAU/t9Kom1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbdev: fix use-after-free in store_modes()
To: "Ian Bridges" <icb@fastmail.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <aj4FKJtIuU97rEA4@dev>
References: <aj4FKJtIuU97rEA4@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:09:02 +0000
Message-Id: <20260626050902.C13871F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing locking in sysfs readers (`show_mode`, `show_modes`) creat=
es a TOCTOU race leading to Use-After-Free.
- [High] Buffer overflow via integer underflow in `mode_string()`.
- [High] `FBIOPUT_VSCREENINFO` ioctl with `FB_ACTIVATE_INV_MODE` deletes mo=
des without clearing dangling pointers.
- [High] Unchecked NULL pointer dereference in `display_to_var()` leads to =
kernel panic.
--

commit f37a3c1901e8e451a34ca5fd10fa0a9b6e643e23
Author: Ian Bridges <icb@fastmail.org>

fbdev: fix use-after-free in store_modes()

store_modes() replaces a framebuffer's modelist with modes from userspace.
This patch fixes use-after-free bugs by clearing fb_display[i].mode and
fb_info->mode pointers before freeing the old modelist.

Link: https://lore.kernel.org/all/ajjoDhAi2y4ArSlz@dev/

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/=
fbsysfs.c
index d9743ef353552..ea196603c7a87 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c

[ ... ]

@@ -108,8 +109,15 @@ static ssize_t store_modes(struct device *device,
 	if (fb_new_modelist(fb_info)) {
 		fb_destroy_modelist(&fb_info->modelist);
 		list_splice(&old_list, &fb_info->modelist);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing lock in
the sysfs readers that could lead to a use-after-free?

While store_modes() correctly takes lock_fb_info() before replacing the
modelist, show_mode() and show_modes() appear to read fb_info->mode and
iterate fb_info->modelist locklessly:

drivers/video/fbdev/core/fbsysfs.c:show_mode() {
        if (!fb_info->mode)
                return 0;
        return mode_string(buf, 0, fb_info->mode);
}

drivers/video/fbdev/core/fbsysfs.c:show_modes() {
        ...
        list_for_each_entry(modelist, &fb_info->modelist, list) {
                mode =3D &modelist->mode;
                i +=3D mode_string(buf, i, mode);
        }
        ...
}

If store_modes() executes concurrently, replaces the modelist, frees the
old nodes via fb_destroy_modelist(), and sets fb_info->mode to NULL, could
a concurrent sysfs read hit a use-after-free or NULL pointer dereference?


[Severity: High]
This is a pre-existing issue, but does show_modes() have an integer
underflow leading to a buffer overflow?

In show_modes(), the offset accumulates indefinitely based on the return
value of snprintf:

drivers/video/fbdev/core/fbsysfs.c:show_modes() {
        ...
        list_for_each_entry(modelist, &fb_info->modelist, list) {
                mode =3D &modelist->mode;
                i +=3D mode_string(buf, i, mode);
        }
        ...
}

If there are enough modes in the modelist, i will exceed PAGE_SIZE. This
value is then passed as the offset to mode_string():

drivers/video/fbdev/core/fbsysfs.c:mode_string() {
        return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
                        m, mode->xres, mode->yres, v, mode->refresh);
}

When offset is greater than PAGE_SIZE, does PAGE_SIZE - offset underflow to
a massive unsigned limit, causing snprintf() to write out of bounds beyond
the sysfs page buffer?

> -	} else
> +	} else {
> +		/*
> +		 * fb_display[i].mode and fb_info->mode both point into the old
> +		 * list. Clear them before it is freed.
> +		 */
> +		fbcon_delete_modelist(&old_list);
> +		fb_info->mode =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the modelist
here expose an unchecked NULL pointer dereference?

The patch modifies store_modes() to call fbcon_delete_modelist(), which
clears disp->mode to NULL. However, functions like fbcon_resize() and
fbcon_switch() unconditionally call display_to_var():

drivers/video/fbdev/core/fbcon.c:display_to_var() {
        ...
        fb_videomode_to_var(var, disp->mode);
        ...
}

drivers/video/fbdev/core/fbcon.c:fbcon_resize() {
        ...
        display_to_var(&var, p);
        fb_videomode_to_var(&var, mode);
        ...
}

Can a user write to sysfs modes, setting fb_display[i].mode to NULL,
followed by a console resize or VT switch that leads to a kernel panic when
fb_videomode_to_var() dereferences the NULL mode?

>  		fb_destroy_modelist(&old_list);
> +	}
> =20
>  	unlock_fb_info(fb_info);
>  	console_unlock();

[Severity: High]
This is a pre-existing issue, but does fb_set_var() suffer from the exact
same dangling pointer issue this patch fixes in store_modes()?

When executing an FBIOPUT_VSCREENINFO ioctl with FB_ACTIVATE_INV_MODE,
fb_set_var() checks if the mode is used by mapped consoles:

drivers/video/fbdev/core/fbmem.c:fb_set_var() {
        ...
        ret =3D fbcon_mode_deleted(info, &mode1);
        if (!ret)
                fb_delete_videomode(&mode1, &info->modelist);
        ...
}

Since fbcon_mode_deleted() intentionally skips unmapped consoles, it will
return 0 if the mode is only referenced by unmapped consoles.

Does this result in fb_delete_videomode() freeing the mode while
fb_display[i].mode in the unmapped console and fb_info->mode still point
to the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aj4FKJtIuU97rEA4@de=
v?part=3D1
