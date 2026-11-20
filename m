Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB2606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwTmR93M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D1110E01F;
	Fri, 20 Nov 2026 12:29:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50E210E01F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:29:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37FEE61903;
 Fri, 20 Nov 2026 12:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2921F008B2;
 Fri, 20 Nov 2026 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795177740;
 bh=CjO+Fla5ztvssdyeZ68Rg9EjVSB1MYR94WMYJ658R6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fwTmR93MvYwD9uvBoV3pN+Be/aVKGscT/eul5kh3KfJm7wk7sajIli9tVJx1DlzoV
 +AOxSpoPlahtf4KT/Je6FTtQAYB/C2XjJJjFDb26XQzllXEj1XvDDXLjkJt8KHUexi
 Uvj7z53ShR0Rd766rgqTx8fiHIGvzuA+ET7z0afn4DVGy+ACumDqjjYQ/vvrh4NAc4
 2Yv5I49kIftub8iDNc43O8Zry3Ycuh9Yh/pWVFlNSgCQzQG7KIdXAC2HOZk0F9h1X1
 XNAktmWdFPqGD3cMyOGj8Z8qNdGhku8Z96xuhz5jKOQGq4e+LR63jnK0A9f4qM8Stn
 RpU6VszpFCXag==
Message-ID: <sashiko-outbox-225142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] fbcon: Handle characters with no glyph defined
 in a consistent way
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120115215.52092-7-tzimmermann@suse.de>
References: <20261120115215.52092-1-tzimmermann@suse.de>
 <20261120115215.52092-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:28:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] fbcon: wrong font buffer in bit_putcs_aligned() and
  bit_putcs_unaligned()
- [Medium] fbcon: fallback lookup in ccw_cursor() repeats c & charmask
  instead of NUL
--

commit 87130bf587571fed7c1353d5789cd5ab5b6c495b
Author: Thomas Zimmermann <tzimmermann@suse.de>

fbcon: Handle characters with no glyph defined in a consistent way

This commit checks the return value of font_data_glyph_buf() for NULL
across fbcon drawing functions, falling back to the '\0' glyph or
skipping the character when undefined.

> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
> index c28329466f051..cf3adc46aaa9a 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -81,7 +81,6 @@ static inline void bit_putcs_aligned(struct vc_data *vc=
, struct fb_info *info,
>  				     unsigned char *buf, u8 *dst)
>  {
>  	u16 charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
> -	unsigned int charcnt =3D vc->vc_font.charcount;
>  	u32 idx =3D vc->vc_font.width >> 3;
>  	struct fbcon_par *par =3D info->fbcon_par;
>  	u32 s_pitch =3D font_glyph_pitch(s_width);
> @@ -90,9 +89,12 @@ static inline void bit_putcs_aligned(struct vc_data *v=
c, struct fb_info *info,
>  	while (cnt--) {
>  		u16 ch =3D scr_readw(s++) & charmask;
> =20
> -		if (ch >=3D charcnt)
> -			ch =3D 0;
>  		src =3D font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
> +		if (!src) {
> +			src =3D font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0'=
);
> +			if (!src)
> +				goto next_char;
> +		}
> =20
>  		if (attr) {
>  			update_attr(buf, src, attr, vc);
> @@ -105,7 +107,7 @@ static inline void bit_putcs_aligned(struct vc_data *=
vc, struct fb_info *info,
>  		else
>  			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
>  					      image->height);
> -
> +next_char:
>  		dst +=3D s_pitch;
>  	}
> =20
> @@ -120,7 +122,6 @@ static inline void bit_putcs_unaligned(struct vc_data=
 *vc,
>  				       unsigned char *buf, u8 *dst)
>  {
>  	u16 charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
> -	unsigned int charcnt =3D vc->vc_font.charcount;
>  	u32 shift_low =3D 0, mod =3D vc->vc_font.width % 8;
>  	u32 shift_high =3D 8;
>  	u32 idx =3D vc->vc_font.width >> 3;
> @@ -131,9 +132,12 @@ static inline void bit_putcs_unaligned(struct vc_dat=
a *vc,
>  	while (cnt--) {
>  		u16 ch =3D scr_readw(s++) & charmask;
> =20
> -		if (ch >=3D charcnt)
> -			ch =3D 0;
>  		src =3D font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
> +		if (!src) {
> +			src =3D font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0'=
);
> +			if (!src)
> +				goto next_char;
> +		}

[Severity: High]
Should the fallback lookups in bit_putcs_aligned() and
bit_putcs_unaligned() pass par->p->fontdata instead of par->rotated.buf?

par->rotated is only defined when CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is
enabled, so builds without it fail to compile.  When rotation support is
compiled in, par->rotated.buf is NULL on an unrotated console, causing
font_data_glyph_buf() -> font_data_num_glyphs() -> font_data_size() to
dereference a NULL pointer whenever an out-of-range character index is
drawn.

[ ... ]

> diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/c=
ore/fbcon_ccw.c
> index 9da6c0e41e7a2..cbaa75fc1cc14 100644
> --- a/drivers/video/fbdev/core/fbcon_ccw.c
> +++ b/drivers/video/fbdev/core/fbcon_ccw.c
[ ... ]
> @@ -246,6 +251,11 @@ static void ccw_cursor(struct vc_data *vc, struct fb=
_info *info, bool enable,
>   	c =3D scr_readw((u16 *) vc->vc_pos);
>  	attribute =3D get_attribute(info, c);
>  	src =3D font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charma=
sk);
> +	if (!src) {
> +		src =3D font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charm=
ask);
> +		if (!src)
> +			return;
> +	}

[Severity: Medium]
Should the fallback call in ccw_cursor() look up '\0' instead of
c & charmask again?  Repeating c & charmask always returns NULL when the
first lookup fails, so the cursor is skipped instead of falling back to
the '\0' glyph.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120115215.5209=
2-1-tzimmermann@suse.de?part=3D6
