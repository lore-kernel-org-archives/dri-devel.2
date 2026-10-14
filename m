Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72518CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B485B10E02D;
	Wed, 14 Oct 2026 09:33:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E95EC10E02D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:33:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC48C60214;
 Wed, 14 Oct 2026 09:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F01F000FF;
 Wed, 14 Oct 2026 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791970401;
 bh=naJW/wGhhAZ+LwMtT7mOTbFNampwnbG26z1hEfORhQ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I0FS9nW/tdunH4EZMStkapmyuH4IhnkkFVaGGRTquRdQgETBZt652q75nBb6uPlSu
 Bhx05C4WiMrAxD6ctQ6N7+pZ2CV3wP0O+p7rdzanSUBCt0GZLayPXakBlAn3RZsJ0g
 FTdpc4jq5c2SPXrfivmm+QG4LsVejUHn632ByvM0L0AImku5drWrU5ZHE/B1+GZZdB
 yF801J8Pnvs44uZ9+vHFFo9MD2KNrXFRsKJ0U6lOylIZp2sMmES2obnfjpd3mN7G2u
 8sjfxEWYkqwjSuVPF3mOxuoMQgpGMXTWGWsWhRHW8/wmX4VZzvDEVT8OVsyAReBw6q
 eBipt8h2BRkBQ==
Message-ID: <sashiko-outbox-171078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] fbcon: Retry rotated font allocation after failure
To: "Yao Yiqi" <yaoyiqi3@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014085102.497789-2-yaoyiqi3@huawei.com>
References: <20261014085102.497789-1-yaoyiqi3@huawei.com>
 <20261014085102.497789-2-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 09:33:21 +0000
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
- [High] fbcon: OOB read via dimension-swapped font loading
- [Medium] fbcon: broken fallback to unrotated rendering on rotate_font fai=
lure
--

commit 1bccc1e9cd74782edba7f76b0ad2e196a29fd948
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Retry rotated font allocation after failure

fbcon_rotate_font() records the font and rotation it is about to handle in
par->rotated.fontdata and par->rotated.buf_rotate before calling
font_data_rotate(). If that allocation fails it clears par->rotated.buf,
but the cached font/rotation state already looks up to date, so the next
call takes the early-out and never retries.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fail=
s")
Cc: stable@vger.kernel.org

> The rotated putcs/cursor ops keep returning early on the NULL buffer and
> the console stays blank until the font or the rotation is changed, even
> once memory is available again.

[Severity: Medium]
Is the fallback to unrotated rendering on rotate_font() failure broken?

When par->bitops->rotate_font() fails, existing callers attempt to fall back
to unrotated rendering:

drivers/video/fbdev/core/fbcon.c:fbcon_init() {
    ...
	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
		par->rotate =3D FB_ROTATE_UR;
		set_blitting_type(vc, info);
	}
    ...
}

But set_blitting_type() invokes fbcon_set_rotation() unconditionally, which
overwrites the fallback state back to the originally requested rotation:

drivers/video/fbdev/core/fbcon.c:fbcon_set_rotation() {
    ...
	if (!(info->flags & FBINFO_MISC_TILEBLITTING) &&
	    par->p->con_rotate < 4)
		par->rotate =3D par->p->con_rotate;
    ...
}

Because the bitops are left as rotated, and par->rotated.buf is NULL, all
drawing operations abort and the screen remains completely blank:

drivers/video/fbdev/core/fbcon_ccw.c:ccw_putcs() {
    ...
	if (!par->rotated.buf)
		return;
    ...
}

Also, it appears the call to rotate_font() in fbcon_do_set_font() ignores
its return value entirely:

drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font() {
    ...
	if (con_is_visible(vc) && par->bitops->rotate_font)
		par->bitops->rotate_font(info, vc);
    ...
}

> diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbde=
v/core/fbcon_rotate.c
> index 6cdbc96eeca6f..6b148e0e81e66 100644
> --- a/drivers/video/fbdev/core/fbcon_rotate.c
> +++ b/drivers/video/fbdev/core/fbcon_rotate.c
> @@ -21,7 +21,9 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_d=
ata *vc)
>  	unsigned char *buf;
>  	int ret;
> =20
> -	if (par->p->fontdata =3D=3D par->rotated.fontdata && par->rotate =3D=3D=
 par->rotated.buf_rotate)
> +	if (par->p->fontdata =3D=3D par->rotated.fontdata &&
> +	    par->rotate =3D=3D par->rotated.buf_rotate &&
> +	    par->rotated.buf)
>  		return 0;

[Severity: High]
Does this early return still rely only on the fontdata pointer?

If a new font shares the same raw byte array (reused via font_data_is_equal)
but has different dimensions, it looks like it could bypass rotated buffer
reallocation because the fontdata pointer remains the same.

Rendering operations could then use the new, larger cellsize to index the
un-updated rotated buffer, resulting in an out-of-bounds read:

drivers/video/fbdev/core/fbcon_cw.c:cw_putcs_aligned() {
    ...
	src =3D par->rotated.buf + (scr_readw(s++) & charmask) * cellsize;
    ...
}

> =20
>  	par->rotated.fontdata =3D par->p->fontdata;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014085102.4977=
89-1-yaoyiqi3@huawei.com?part=3D2
