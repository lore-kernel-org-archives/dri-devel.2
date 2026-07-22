Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48612C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64B010EC77;
	Wed, 22 Jul 2026 07:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JLcpk08f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50CC10EC8A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:02:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9979402FD;
 Wed, 22 Jul 2026 07:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720D81F000E9;
 Wed, 22 Jul 2026 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703752;
 bh=FV6Bse9n7nDntqv3gBgoEiqzRMHxkbUIh+ur4sVxRp0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JLcpk08fgHEP/cKgFxnTfacO2U13be0Xkkp1+91YjCCNpu7QvR5t/trHuEpdHdq+M
 7+9WZ7QUjQLw3Yi7n0ETxuBPOsMDfya9zsqeh/qqShCBklDWuxMUnA3FClTBMft6EV
 pfpDdC48shiXBSGsEF3Tp/E6oLWDy4HfGbPRzWz5YjNmufHLrivR0EPeeuM7a2pouh
 I/lZILZj6/hW0o9PVZWpEOOAWvx8zO+mFYUfuyWJQwMAJC/sK3elc5g846AIttRJkr
 Y+ja9F8nc8t3bJTZJeLi2tqvne306pf3r8tTUZCvDvl5oJUggqDquFvodny4wHN1Du
 fPQTKhh96+3mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] fbdev: Fix out-of-bounds access when rotating
 console after font resize
To: "Zizhi Wo" <wozizhi@huaweicloud.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722062216.2574546-1-wozizhi@huaweicloud.com>
References: <20260722062216.2574546-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:02:31 +0000
Message-Id: <20260722070232.720D81F000E9@smtp.kernel.org>
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
- [Critical] The exact same OOB access remains when the screen resolution i=
s shrunk while a text selection is active or when changing the font size vi=
a ioctl(KDFONTOP) on a rotated console.
- [High] The fallback logic for when rotate_font() fails is fundamentally b=
roken, leading to a silent failure to render text.
--

--- Patch [1]: [PATCH V2] fbdev: Fix out-of-bounds access when rotating con=
sole after font resize ---
commit 8b1b772d608d9f550c7052854497b048b2d6b16a
Author: Zizhi Wo <wozizhi@huawei.com>

fbdev: Fix out-of-bounds access when rotating console after font resize

This commit addresses an out-of-bounds access when changing console
rotation and font size. It ensures clear_selection() is called earlier
and a correctly sized buffer is allocated in time by calling
rotate_font() before vc_resize().

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 9f5c4c101581d..3361479d139d3 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2641,9 +2641,16 @@ static void fbcon_modechanged(struct fb_info *info)
>  	    fbcon_info_from_console(par->currcon) !=3D info)
>  		return;
> =20
> +	clear_selection();
> +

[Severity: Critical]
This is a pre-existing issue, but does moving clear_selection() here still
leave us vulnerable if the screen resolution is shrunk while a text selecti=
on
is active, or if the font size is increased via ioctl(KDFONTOP)?

When clear_selection() calls highlight(), it iterates through the selected
text. If the font size is increased or the screen resolution is smaller,
wouldn't it still use the old, larger vc->vc_cols boundary since vc_resize()
hasn't updated vc_cols yet?

In drivers/video/fbdev/core/fbcon_ccw.c:ccw_putcs(), this could result in:

	image.dy =3D vyres - ((xx + count) * vc->vc_font.width);

If (xx + count) reaches the old max columns, could this cause an underflow
to a massive value, leading to another out-of-bounds memory access?

>  	p =3D &fb_display[vc->vc_num];
>  	set_blitting_type(vc, info);
> =20
> +	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
> +		par->rotate =3D FB_ROTATE_UR;
> +		set_blitting_type(vc, info);
> +	}
> +

[Severity: High]
This is a pre-existing issue, but is this fallback logic effective if
rotate_font() fails?

The code attempts to fall back to an upright rotation (FB_ROTATE_UR), but
doesn't set_blitting_type() internally call fbcon_set_rotation(info)?

drivers/video/fbdev/core/fbcon.c:fbcon_set_rotation() {
    ...
	if (!(info->flags & FBINFO_MISC_TILEBLITTING) &&
	    par->p->con_rotate < 4)
		par->rotate =3D par->p->con_rotate;
    ...
}

It appears this would unconditionally reset par->rotate back to the original
con_rotate. Since par->rotated.buf would remain NULL, might the drawing
routines silently return without rendering any text?

>  	if (con_is_visible(vc)) {
>  		var_to_display(p, &info->var, info);
>  		cols =3D FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722062216.2574=
546-1-wozizhi@huaweicloud.com?part=3D1
