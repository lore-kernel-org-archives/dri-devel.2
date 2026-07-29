Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1829C54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44F210E61C;
	Wed, 29 Jul 2026 02:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i7AmDx0K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B1F10E61C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:43:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5656060A5E;
 Wed, 29 Jul 2026 02:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71681F000E9;
 Wed, 29 Jul 2026 02:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785292980;
 bh=1qXmM2YWBVgrm+9laSJYiqQDI8Ei38IIkYsmREM7oD0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i7AmDx0K2FXcNTDdQ0SqzRE7QuOw2rOwy6E4zFlwwL43fl9ZKvhuklHpYN6IChM/v
 SpZSv5fXdEv0QMBET0OZCW4h8wYlCbhZWSuCM6FLT2ar7gM8rJrUQeOR/8oiF8Rs0X
 rE4po8RQUZH7fFfkQe85XXlAICmOmVEdMNkN/vD0BGNCyDM3r+IwnQ52i4Xb/tXPfl
 PIrgbhvjESlraZcLn8S5SCgAbwYFoG6GbK96b9HgAWOj0K66Mrr7S5OWHY3MWr2XiZ
 C2+HXg5gTC/72rKU9SmwXMkGzljfrGMd5w8aSmIz8hOiLEWaUQmE98GvqPz+AQmJ/Z
 qhMAzhpKhCy8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] fbdev: Fix out-of-bounds access when rotating
 console after font resize
To: "Zizhi Wo" <wozizhi@huaweicloud.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729021204.3385299-1-wozizhi@huaweicloud.com>
References: <20260729021204.3385299-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:42:59 +0000
Message-Id: <20260729024259.D71681F000E9@smtp.kernel.org>
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
- [High] Ineffective fallback logic on memory allocation failure causes a N=
ULL pointer dereference in the console rendering path.
- [High] Out-of-bounds access or NULL pointer dereference in fbcon_init() d=
ue to missing selection pre-clearing fix.
- [High] Out-of-bounds access when changing font size on an actively rotate=
d console.
- [High] Ignored vc_resize() return value leaves stale geometry, causing an=
 out-of-bounds memory access.
--

--- Patch [1]: [PATCH V3] fbdev: Fix out-of-bounds access when rotating con=
sole after font resize ---
commit f333e84fec0269170d8087f048fca7b2a06cbd02
Author: Zizhi Wo <wozizhi@huawei.com>

fbdev: Fix out-of-bounds access when rotating console after font resize
   =20
This commit fixes an out-of-bounds access when rotating the console after a
font resize. It resolves the issue by pre-clearing the selection before
switching bitops in fbcon_modechanged() and fbcon_set_all_vcs(), ensuring
that par->rotated.buf is rebuilt before subsequent updates.

Link: https://lore.kernel.org/all/20260722062216.2574546-1-wozizhi@huaweicl=
oud.com/
Link: https://lore.kernel.org/all/20250905024340.337521-1-wozizhi@huaweiclo=
ud.com/

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 9f5c4c101581d..23b3c536d53d1 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2641,9 +2641,31 @@ static void fbcon_modechanged(struct fb_info *info)
>  	    fbcon_info_from_console(par->currcon) !=3D info)
>  		return;
> =20
> +	/*
> +	 * Clear the selection before switching bitops.  Without this, the
> +	 * clear_selection() inside vc_resize() below repaints the highlighted
> +	 * cells through the new bitops while the console geometry(vc_rows/vc_c=
ols)
> +	 * has not been updated to match, so the repaint is computed from a
> +	 * half-switched geometry and overflows the framebuffer address.
> +	 * Pre-clearing makes that repaint a no-op.
> +	 */
> +	clear_selection();
> +
>  	p =3D &fb_display[vc->vc_num];
>  	set_blitting_type(vc, info);
> =20
> +	/*
> +	 * Rebuild par->rotated.buf for the new rotation now that bitops have
> +	 * switched.  The new putcs/cursor ops read this buffer; if it is still
> +	 * sized for the old rotation, fbcon_putcs() and the cursor path reached
> +	 * via update_screen() below overflow it.  Mirrors fbcon_switch(); fall
> +	 * back to unrotated rendering on allocation failure.
> +	 */
> +	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
> +		par->rotate =3D FB_ROTATE_UR;
> +		set_blitting_type(vc, info);
> +	}

[Severity: High]
This is a pre-existing issue, but does this fallback logic actually prevent
the crash on allocation failure?

When rotate_font() fails, par->rotated.buf is freed and set to NULL. The
fallback attempts to revert to unrotated rendering by setting par->rotate =
=3D
FB_ROTATE_UR and calling set_blitting_type(vc, info).

However, set_blitting_type() internally calls fbcon_set_rotation(info),
which resets par->rotate back to the failing requested rotation from
par->p->con_rotate:

drivers/video/fbdev/core/fbcon.c:set_blitting_type() {
    ...
    fbcon_set_rotation(info);
    fbcon_set_bitops(par);
}

This causes the rotated bitops to be selected again. Subsequent screen upda=
tes
will then dereference the now-NULL par->rotated.buf. Should par->p->con_rot=
ate
also be updated to FB_ROTATE_UR in this fallback path?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to ignore the ret=
urn
value of vc_resize() later in fbcon_modechanged()?

If vc_resize() fails (e.g., due to kzalloc returning -ENOMEM), it leaves
vc->vc_cols and vc->vc_rows unmodified, potentially at older, larger values.
The execution then continues unconditionally to update_screen():

drivers/video/fbdev/core/fbcon.c:fbcon_modechanged() {
    ...
    vc_resize(vc, cols, rows);
    ...
    update_screen(vc);
}

This loops over the stale, oversized vc->vc_cols. In ccw_putcs(), the
calculation:

image.dy =3D vyres - ((xx + count) * vc->vc_font.width)

can underflow because the stale xx + count is too large for the new vyres.
This results in a massive image.dy offset and a page fault when calculating
the framebuffer address, reintroducing the out-of-bounds access upon
allocation failure.

[Severity: High]
This is a pre-existing issue, but does fbcon_init() suffer from the same
missing selection pre-clearing issue this patch addresses?

In fbcon_init(), set_blitting_type() is called to switch bitops before
rotate_font() is invoked:

drivers/video/fbdev/core/fbcon.c:fbcon_init() {
    set_blitting_type(vc, info);
    ...
    if (init) {
        vc->vc_cols =3D new_cols;
        vc->vc_rows =3D new_rows;
    } else
        vc_resize(vc, new_cols, new_rows);
    ...
}

If the console is visible and has a selection, vc_resize() triggers
clear_selection(), which forces a screen redraw. Since rotate_font() has not
yet been called, par->rotated.buf may be NULL or improperly sized, leading
the newly-switched bitops to read out-of-bounds or dereference NULL.

[Severity: High]
This isn't a bug introduced by this patch, but could changing the font size=
 on
an actively rotated console cause an out-of-bounds access?

When a KDFONTOP ioctl increases the font size on a rotated console,
fbcon_do_set_font() updates the font dimensions and calls vc_resize():

drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font() {
    ...
    ret =3D vc_resize(vc, cols, rows);
    ...
}

vc_resize() triggers a screen update using the new font geometry. However,
fbcon_do_set_font() never calls par->bitops->rotate_font() to reallocate
par->rotated.buf for the new dimensions. During the redraw, rotated renderi=
ng
functions like ccw_putcs() calculate memory offsets based on the larger font
sizes, reading past the end of the existing, too-small par->rotated.buf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729021204.3385=
299-1-wozizhi@huaweicloud.com?part=3D1
