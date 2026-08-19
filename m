Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06756C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5808010E109;
	Wed, 19 Aug 2026 19:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vp+jQ2aO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7D510E109
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 19:42:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B5F7414E3;
 Wed, 19 Aug 2026 19:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB181F000E9;
 Wed, 19 Aug 2026 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787168546;
 bh=/uxw1sgLwEi0s71/aNw+Mg7PMzIPlp2VhnlxllOgTRs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vp+jQ2aOp67bI6Xv4hkNR2K+b6sUXIsz1XvibYWfdmbnZiFmiheoIVoZnVg2w3tSb
 Y0qIVw8oVrqJ+kmdwmjIpXp+YUfsQ4kMfRyImet7IK/2VlbIUuBrETY325MIY8/5aB
 irC7TnFi9E54ZaDKc+qWc07s70/qTdTg03mgKwSrREWpltGXn5ZxJy4jOWM0b/0mX4
 2/LlgAOxiUXpYGTPuXgUueP+ai+uVugzidcgdr2JvNlMg9SrCEkBGfn5ZywfDexzBL
 Cxt683h8fpGANZ69W7jfcPmd594eOfswp4wXl61Fae/vmrFgZ9aU54MWkfNQpsVvjR
 cl7v2ftbddsJQ==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] KASAN: vmalloc-out-of-bounds Read in imageblit
To: "Jaeyoung Chung" <jjy600901@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819192516.57820-1-jjy600901@snu.ac.kr>
References: <20260819192516.57820-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:42:25 +0000
Message-Id: <20260819194226.1AB181F000E9@smtp.kernel.org>
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

New issues:
- [High] The proposed patch consists entirely of artificial delays and hard=
coded process name checks meant for a fuzzer reproducer. It introduces user=
-controllable `mdelay()` calls, which allows local users to trigger soft lo=
ckups and Denials of Service (DoS) under critical locks like the console lo=
ck.

Pre-existing issues:
- [High] Pre-existing vulnerability: A race condition exists between consol=
e initialization, font/geometry changes, and character rendering, leading t=
o a KASAN vmalloc-out-of-bounds read in `imageblit`.
--

--- Patch [1]: [BUG] KASAN: vmalloc-out-of-bounds Read in imageblit ---
commit dcf37f3f2180abb3c3000d7b65ab0ea65910d9e2
Author: Jaeyoung Chung <jjy600901@snu.ac.kr>

KASAN: vmalloc-out-of-bounds Read in imageblit
   =20
This commit is a bug report for a vmalloc-out-of-bounds read in imageblit
found by a fuzzer. It includes a reproducer patch that adds artificial dela=
ys
and process name checks to reliably trigger the race condition.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 23b3c536d53d1..774a38378aa5b 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -1231,6 +1233,13 @@ static void fbcon_init(struct vc_data *vc, bool in=
it)
>  		set_blitting_type(vc, info);
>  	}
> =20
> +	if (strncmp(current->comm, "syzrepro0", 9) =3D=3D 0) {
> +		pr_info("syz_rg: fbcon_init arm vc=3D%u fg=3D%d par_rotate=3D%d fg_con=
_rotate=3D%d var=3D%ux%u\n",
> +			vc->vc_num, fg_console, par->rotate,
> +			fb_display[fg_console].con_rotate,
> +			info->var.xres, info->var.yres);
> +		mdelay(30);
> +	}

[Severity: High]
Is it intentional to include this diagnostic reproducer in the patch?
This introduces a 30ms busy-wait delay based on a user-controllable
process name during console initialization, which allows local users
to trigger soft lockups and Denials of Service under console locks.

>  	par->p =3D &fb_display[fg_console];

[Severity: High]
This is a pre-existing issue, but does this assignment alter the shared
console state in a way that can race with concurrent geometry computations?

Concurrent execution of fbcon_init(), fbcon_do_set_font(), and cw_putcs()
appears to cause shared state to become unsynchronized, leading to the
vmalloc-out-of-bounds read.

>  }
> =20
> @@ -2432,6 +2441,13 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  		rows =3D FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
>  		cols /=3D w;
>  		rows /=3D h;

[Severity: High]
This is a pre-existing issue, but can computing cols and rows using
potentially corrupted or racing par->rotate lead to oversized console
dimensions?

> +		if (strncmp(current->comm, "syzrepro1", 9) =3D=3D 0) {
> +			pr_info("syz_rg: set_font rot=3D%d cols=3D%d rows=3D%d font=3D%dx%d v=
ar=3D%ux%u vc=3D%ux%u\n",
> +				par->rotate, cols, rows, w, h,
> +				info->var.xres, info->var.yres,
> +				vc->vc_cols, vc->vc_rows);
> +			mdelay(10);
> +		}

[Severity: High]
Does this code introduce a 10ms busy-wait delay in the font setting path
that could be exploited for a local Denial of Service?

>  		ret =3D vc_resize(vc, cols, rows);
>  		if (ret)
>  			goto err_out;
> diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/co=
re/fbcon_cw.c
> index bde820967eb9a..f93a4364f89c1 100644
> --- a/drivers/video/fbdev/core/fbcon_cw.c
> +++ b/drivers/video/fbdev/core/fbcon_cw.c
[ ... ]
> @@ -137,6 +139,14 @@ static void cw_putcs(struct vc_data *vc, struct fb_i=
nfo *info,
>  	image.width =3D vc->vc_font.height;
>  	image.depth =3D 1;

[Severity: High]
This is a pre-existing issue, but does reading from vc->vc_font without
sufficient synchronization propagate out-of-bounds parameters to the blitter
when vc_cols * vc->vc_font.width > info->var.yres?

> +	if (strncmp(current->comm, "syzrepro", 8) =3D=3D 0 &&
> +	    vc->vc_cols * vc->vc_font.width > info->var.yres) {
> +		pr_info("syz_rg: cw_putcs pre-oob yy=3D%d xx=3D%d dx=3D%u dy=3D%u iw=
=3D%u cols=3D%u font=3D%ux%u yres=3D%u yvirt=3D%u vxres=3D%u\n",
> +			yy, xx, image.dx, image.dy, image.width,
> +			vc->vc_cols, vc->vc_font.width, vc->vc_font.height,
> +			info->var.yres, info->var.yres_virtual, vxres);
> +		mdelay(5);
> +	}

[Severity: High]
Could this 5ms busy-wait delay in the character output path also be used
to trigger soft lockups by local users?

>  	if (attribute) {
>  		buf =3D kmalloc(cellsize, GFP_KERNEL);
>  		if (!buf)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819192516.5782=
0-1-jjy600901@snu.ac.kr?part=3D1
