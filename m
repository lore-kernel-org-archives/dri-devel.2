Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDCECCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339C310E8DE;
	Mon, 19 Oct 2026 09:15:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A8810E8DE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:15:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B51740C02;
 Mon, 19 Oct 2026 09:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBAD1F000C4;
 Mon, 19 Oct 2026 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792401348;
 bh=Uq3rLqaKpf+aEXk2SA+1QTndT7yvUIjt8sNDwPSDplc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nAwIAxD99XJCnZf7xMXh3Cd31QXniVw9rA38g1maWX1QRF01LTomZhYE2xKPUWxLp
 1x6Z4Uj1bO9zrhQZ4y/CyijZe5QdEMatagoJknLeLCHTIZ4MwC7D8Hrx5u0P6lMGl4
 pZ/yRkIIObQESPlBIODoOA5A634VIQE5Scq9QCEhEKZ1Vz1/A6+ODzMedHuZf4njle
 q+RUf/kycgYH2Yjjoa83KmFK+cmdOZsuMzavXHeG5Nt4yBkWPh1Q7pmmTU1OpINcQL
 vaBFMVggrPsHF3bG8DolL1HHpev/k47VdY3E7AUHTGJQCVl/H5BtSqIgnfkGj2OiVE
 AHxvpeKQjWscg==
Message-ID: <sashiko-outbox-176884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] fbcon: Rebuild rotated font buffer on font change
To: "Yao Yiqi" <yyaqia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019090206.1094958-3-yyaqia@gmail.com>
References: <20261019090206.1094958-1-yyaqia@gmail.com>
 <20261019090206.1094958-3-yyaqia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:15:47 +0000
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
- [High] fbcon: incomplete par->rotated rollback on error in fbcon_do_set_f=
ont()
- [High] fbcon: incomplete par->rotated state save and restore in fbcon_do_=
set_font()
--

commit 40279fe676962065434b918b61507d77c5b4a060
Author: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon: Rebuild rotated font buffer on font change

This patch rebuilds the rotated font buffer in fbcon_do_set_font() when
changing fonts on the visible console so that vc_resize() does not render
using a rotated font cache sized for the old font. If rotation or resizing
fails, it restores the saved rotated buffer and rolls back the font change.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 01715873ea49b..7605e4237ca5b 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2414,6 +2414,11 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  	font_data_t *old_fontdata =3D p->fontdata;
>  	const u8 *old_data =3D vc->vc_font.data;
>  	unsigned short old_hi_font_mask =3D vc->vc_hi_font_mask;
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
> +	u8 *saved_rotated_buf =3D NULL;
> +	size_t saved_rotated_bufsize =3D 0;
> +	bool rotated_saved =3D false;
> +#endif
> =20
>  	font_data_get(data);
> =20
> @@ -2432,6 +2437,29 @@ static int fbcon_do_set_font(struct vc_data *vc, i=
nt w, int h, int charcount,
>  	else if (!vc->vc_hi_font_mask && charcount =3D=3D 512)
>  		set_vc_hi_font(vc, true);
> =20
> +	/*
> +	 * Select the console's blitting state and update par->rotated to
> +	 * match the new font, so that the rendering below does not use a
> +	 * cache that was built for the old font. Clear the buffer so the
> +	 * rebuild allocates a fresh one; the old buffer is kept until the
> +	 * font change can no longer fail.
> +	 */
> +	if (con_is_visible(vc)) {
> +		set_blitting_type(vc, info);
> +		if (par->bitops->rotate_font) {
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
> +			saved_rotated_buf =3D par->rotated.buf;
> +			saved_rotated_bufsize =3D par->rotated.bufsize;
> +			par->rotated.buf =3D NULL;
> +			par->rotated.bufsize =3D 0;
> +			rotated_saved =3D true;
> +#endif
> +			ret =3D par->bitops->rotate_font(info, vc);

[Severity: High]
Can clearing only par->rotated.buf and par->rotated.bufsize here cause the
active rotated font buffer to be freed and lost when re-setting the same
font?

In drivers/video/fbdev/core/fbcon_rotate.c, fbcon_rotate_font() checks
whether the cache metadata matches before allocating a new buffer:

drivers/video/fbdev/core/fbcon_rotate.c:fbcon_rotate_font() {
	if (par->p->fontdata =3D=3D par->rotated.fontdata &&
	    par->rotate =3D=3D par->rotated.buf_rotate &&
	    vc->vc_font.width =3D=3D par->rotated.buf_width &&
	    vc->vc_font.height =3D=3D par->rotated.buf_height &&
	    vc->vc_font.charcount =3D=3D par->rotated.buf_charcount)
		return 0;
}

At this commit, before the subsequent commit 4c61e799dc92 ("fbcon: Retry
rotated font allocation after failure") adds a check for par->rotated.buf,
re-applying a font with the same fontdata and geometry (for example via
fbcon_set_font() deduplication or fbcon_set_def_font()) hits this early
return with par->rotated.buf still NULL. fbcon_do_set_font() then calls
kfree(saved_rotated_buf), leaving par->rotated.buf NULL.

> +			if (ret)
> +				goto err_out;
> +		}
> +	}
> +
>  	if (resize) {
>  		int cols, rows;
> =20
> @@ -2448,12 +2476,27 @@ static int fbcon_do_set_font(struct vc_data *vc, =
int w, int h, int charcount,
>  		update_screen(vc);
>  	}
> =20
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
> +	if (rotated_saved)
> +		kfree(saved_rotated_buf);
> +#endif
>  	if (old_fontdata)
>  		font_data_put(old_fontdata);
> =20
>  	return 0;
> =20
>  err_out:
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
> +	/*
> +	 * Drop the buffer built for the new font and restore the saved
> +	 * one.
> +	 */
> +	if (rotated_saved) {
> +		kfree(par->rotated.buf);
> +		par->rotated.buf =3D saved_rotated_buf;
> +		par->rotated.bufsize =3D saved_rotated_bufsize;
> +	}
> +#endif

[Severity: High]
What happens to the cache key fields in par->rotated when rotate_font() or
vc_resize() fails and jumps to err_out?

In fbcon_rotate_font(), the cache key fields are updated with the new
font's pointer and geometry before font_data_rotate() is called:

drivers/video/fbdev/core/fbcon_rotate.c:fbcon_rotate_font() {
	...
	par->rotated.fontdata =3D par->p->fontdata;
	par->rotated.buf_rotate =3D par->rotate;
	par->rotated.buf_width =3D vc->vc_font.width;
	par->rotated.buf_height =3D vc->vc_font.height;
	par->rotated.buf_charcount =3D vc->vc_font.charcount;
	...
	buf =3D font_data_rotate(...);
}

If font_data_rotate() or the subsequent vc_resize() in fbcon_do_set_font()
fails, err_out restores par->rotated.buf and par->rotated.bufsize to the
old font's buffer and restores p->fontdata and vc->vc_font to the old font,
but leaves par->rotated.{fontdata,buf_rotate,buf_width,buf_height,
buf_charcount} set to the failed new font's metadata.

Because par->rotated.buf is restored to the non-NULL saved_rotated_buf,
even with commit 4c61e799dc92 ("fbcon: Retry rotated font allocation after
failure") applied, switching via fbcon_switch() to another console that
uses that same font and larger geometry (or a subsequent font operation
that reuses the freed font_data_t address with the larger geometry) will
see all cache key fields match and par->rotated.buf !=3D NULL in
fbcon_rotate_font(). It will return early without rebuilding the buffer,
and the rotated blitting and cursor callbacks (cw_putcs/ccw_putcs/ud_putcs
and cw_cursor/ccw_cursor/ud_cursor) will index the smaller
saved_rotated_buf using the larger cell size, triggering a
slab-out-of-bounds read.

Would saving and clearing the entire par->rotated struct before calling
rotate_font(), and restoring the whole struct in err_out, avoid both
issues?

[ ... ]

>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019090206.1094=
958-1-yyaqia@gmail.com?part=3D2
