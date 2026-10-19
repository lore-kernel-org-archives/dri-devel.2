Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EEECCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5FF10E8EC;
	Mon, 19 Oct 2026 09:16:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5889810E8EA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C53640705;
 Mon, 19 Oct 2026 09:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C2B1F000C4;
 Mon, 19 Oct 2026 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792401359;
 bh=o6jSxeq8KEN6lcSAetzW14Uw/OiZctLceWCg0UBb5cM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FSLBpt7nI0tDAPuAe79xPk2YV8cK8YCbbYEPuHTqtpqRE8s+BWdddJ66PwfobsM9c
 OWvZ8d+zba1e3P3F7060jG0Cd2Wi7WY4dnLZHSDUYX+RCn9ORNEsOE4Y9vFEG/2KbU
 vpO9LARQACuAEQjdy+ZpC4V6gUNnZwxludcdkx0mX2oLP8ABOwKpAIKBYFAr9oxivl
 ThJaPB42LjijCD/O2ZNtMrBMIQmw7651cPt4gFxkuFfR2P0eehi4p6lr5tOhKZ4vO8
 Vbb0xF5e6+EH4VHM2lrdDYWwm6lQo9VsIqsoMuwElha4FWux9DRg5x0Ld2J2vN5lpI
 AUvrwkBKKCiOQ==
Message-ID: <sashiko-outbox-176885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] fbcon: Retry rotated font allocation after failure
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019090206.1094958-4-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
 <20261019090206.1094958-4-yyaqia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:15:58 +0000
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
- [High] fbcon: stale rotated font cache key in fbcon_rotate_font() on erro=
r rollback
--

commit 4c61e799dc92607244ca176d7070e7e3d2fde5e4
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Retry rotated font allocation after failure

This commit checks par->rotated.buf in the early-out condition of
fbcon_rotate_font() so that a failed rotated font allocation is retried on
the next call instead of leaving the console blank.

> diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbde=
v/core/fbcon_rotate.c
> index 660a3fa81baed..7afd63dcee7be 100644
> --- a/drivers/video/fbdev/core/fbcon_rotate.c
> +++ b/drivers/video/fbdev/core/fbcon_rotate.c
> @@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_d=
ata *vc)
>  	    par->rotate =3D=3D par->rotated.buf_rotate &&
>  	    vc->vc_font.width =3D=3D par->rotated.buf_width &&
>  	    vc->vc_font.height =3D=3D par->rotated.buf_height &&
> -	    vc->vc_font.charcount =3D=3D par->rotated.buf_charcount)
> +	    vc->vc_font.charcount =3D=3D par->rotated.buf_charcount &&
> +	    par->rotated.buf)
>  		return 0;
> =20
>  	par->rotated.fontdata =3D par->p->fontdata;

[Severity: High]
Should fbcon_rotate_font() update the cache key fields in par->rotated only
after font_data_rotate() succeeds, rather than relying solely on checking
par->rotated.buf in the early-out?

Because fbcon_rotate_font() records par->rotated.fontdata, buf_rotate,
buf_width, buf_height, and buf_charcount before calling font_data_rotate(),
those fields still get overwritten with the new font's metadata when
font_data_rotate() fails.

In drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font(), the caller saves
par->rotated.buf before calling rotate_font() and restores the old buffer on
failure:

drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font() {
	if (con_is_visible(vc)) {
		set_blitting_type(vc, info);
		if (par->bitops->rotate_font) {
#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
			saved_rotated_buf =3D par->rotated.buf;
			saved_rotated_bufsize =3D par->rotated.bufsize;
			par->rotated.buf =3D NULL;
			par->rotated.bufsize =3D 0;
			rotated_saved =3D true;
#endif
			ret =3D par->bitops->rotate_font(info, vc);
			if (ret)
				goto err_out;
		}
	}
	...
err_out:
	if (rotated_saved) {
		kfree(par->rotated.buf);
		par->rotated.buf =3D saved_rotated_buf;
		par->rotated.bufsize =3D saved_rotated_bufsize;
	}
}

If rotate_font() (or the subsequent vc_resize()) fails in fbcon_do_set_font=
()
when switching a visible console from a smaller font (e.g. 8x8) to a larger
font (e.g. 16x32), err_out restores par->rotated.buf to the smaller font's
non-NULL saved_rotated_buf while leaving par->rotated.{fontdata, buf_rotate,
buf_width, buf_height, buf_charcount} set to the failed larger font's
metadata.

If another console already uses that same larger font (or if changing to a
built-in/shared font matching that stale key is retried), the next
fbcon_switch() -> fbcon_rotate_font() sees all key fields match and
par->rotated.buf !=3D NULL, so it returns 0 without reallocating or rotating
the buffer. Could the rotated rendering callbacks (cw_putcs(), ccw_putcs(),
ud_putcs(), cw_cursor(), ccw_cursor(), ud_cursor()) then read out of bounds
from the smaller restored par->rotated.buf using the larger font's geometry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019090206.1094=
958-1-yyaqia@gmail.com?part=3D3
