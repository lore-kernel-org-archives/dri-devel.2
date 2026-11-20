Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED2606A330
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWueO9F7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6665510E7ED;
	Fri, 20 Nov 2026 12:22:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EA510E75D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:22:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8056260E48;
 Fri, 20 Nov 2026 12:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E751F000C4;
 Fri, 20 Nov 2026 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795177324;
 bh=QQk7FIIbl8HF409lOXuo7wEnPDUrmoqERTU1WVLdYa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OWueO9F7O3o1qR7r99u8CD+4EBixRl+MAMKzHIdx4TkkAQuR4ICZBao7hzqFde5zs
 bHaXtDSwP4ruOjwns3QaKoQwFK86T+SJc4v0kaW3hqjGPwHZ1CHtTjDQCnVGpgEOPV
 zi6VAkI9ZgnejPwryDLirm0lA+f957DPztLXO10QPZaRcQgc2UThCfTZo8cwqRykYG
 lKpwh037tQYO4ftFfsBkH8PNdReDQ3Xhu44jRACSig00GhPURdQcY/2CZueSNwKR4F
 K8URS9S9Qkd44mnbMhItcqDJf2syEoQ6Ou+Qa9bFbG409EUyn3/oduXtBS5l39tMSY
 0cMNQ4TBJfb1Q==
Message-ID: <sashiko-outbox-225136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] fbcon: Look up glyphs using the font interface
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120115215.52092-6-tzimmermann@suse.de>
References: <20261120115215.52092-1-tzimmermann@suse.de>
 <20261120115215.52092-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:22:04 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] fbcon: mismatched par->p->fontdata lookup and NULL deref in
  bitblit
--

commit 715441bc0ed4d52171baff9d0046bf7f7969ee89
Author: Thomas Zimmermann <tzimmermann@suse.de>

fbcon: Look up glyphs using the font interface

This commit replaces open-coded glyph lookups and cell-size calculations
in the fbcon bitblit and rotation implementations with font_data_glyph_buf()
and font_glyph_size().

> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
> index 1cbfbe50bebff..c28329466f051 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -76,13 +76,15 @@ static void bit_clear(struct vc_data *vc, struct fb_i=
nfo *info, int sy,
> =20
>  static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info =
*info,
>  				     const u16 *s, u32 attr, u32 cnt,
> -				     u32 d_pitch, u32 s_pitch, u32 cellsize,
> +				     u32 d_pitch, u32 s_width, u32 s_vpitch,
>  				     struct fb_image *image,
>  				     unsigned char *buf, u8 *dst)
>  {
>  	u16 charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
>  	unsigned int charcnt =3D vc->vc_font.charcount;
>  	u32 idx =3D vc->vc_font.width >> 3;
> +	struct fbcon_par *par =3D info->fbcon_par;
> +	u32 s_pitch =3D font_glyph_pitch(s_width);
>  	const unsigned char *src;
> =20
>  	while (cnt--) {
> @@ -90,7 +92,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc=
, struct fb_info *info,
> =20
>  		if (ch >=3D charcnt)
>  			ch =3D 0;
> -		src =3D vc->vc_font.data + (unsigned int)ch * cellsize;
> +		src =3D font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
> =20
>  		if (attr) {
>  			update_attr(buf, src, attr, vc);
> @@ -113,7 +115,7 @@ static inline void bit_putcs_aligned(struct vc_data *=
vc, struct fb_info *info,
>  static inline void bit_putcs_unaligned(struct vc_data *vc,
>  				       struct fb_info *info, const u16 *s,
>  				       u32 attr, u32 cnt, u32 d_pitch,
> -				       u32 s_pitch, u32 cellsize,
> +				       u32 s_width, u32 s_vpitch,
>  				       struct fb_image *image,
>  				       unsigned char *buf, u8 *dst)
>  {
> @@ -122,6 +124,8 @@ static inline void bit_putcs_unaligned(struct vc_data=
 *vc,
>  	u32 shift_low =3D 0, mod =3D vc->vc_font.width % 8;
>  	u32 shift_high =3D 8;
>  	u32 idx =3D vc->vc_font.width >> 3;
> +	struct fbcon_par *par =3D info->fbcon_par;
> +	u32 s_pitch =3D font_glyph_pitch(s_width);
>  	const unsigned char *src;
> =20
>  	while (cnt--) {
> @@ -129,7 +133,7 @@ static inline void bit_putcs_unaligned(struct vc_data=
 *vc,
> =20
>  		if (ch >=3D charcnt)
>  			ch =3D 0;
> -		src =3D vc->vc_font.data + (unsigned int)ch * cellsize;
> +		src =3D font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
> =20
>  		if (attr) {
>  			update_attr(buf, src, attr, vc);

[ ... ]

> @@ -289,7 +294,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_=
info *info, bool enable,
>  	/* Clamp to font size, same as bit_putcs_aligned() */
>  	if (c >=3D vc->vc_font.charcount)
>  		c =3D 0;
> -	src =3D vc->vc_font.data + (c * cellsize);
> +	src =3D font_data_glyph_buf(par->p->fontdata, width, vpitch, c);
> =20
>  	if (par->cursor_state.image.data !=3D (const char *)src ||
>  	    par->cursor_reset) {

[Severity: High]
Can looking up glyphs in par->p->fontdata instead of vc->vc_font.data
cause a NULL pointer dereference in bit_putcs_aligned(),
bit_putcs_unaligned(), and bit_cursor()?

par is shared across all virtual consoles mapped to info, so par->p does
not always point to &fb_display[vc->vc_num].  For example, con_font_set()
calls hide_cursor(vc) -> fbcon_cursor(vc, false) -> bit_cursor() on a
background console while par->p still points to &fb_display[fg_console],
and set_con2fb_map() sets par->p =3D &fb_display[unit] for a background
console before con2fb_init_display() calls update_screen() on fg_console.

When par->p->fontdata belongs to a console with a smaller font buffer
than vc (such as an 8x16 font on par->p vs a 16x32 font on vc), any
character index c >=3D font_data_num_glyphs(par->p->fontdata, width, vpitch)
still passes the c >=3D vc->vc_font.charcount clamp, causing
font_data_glyph_buf() to return NULL.  That unchecked NULL src is then
dereferenced in soft_cursor(), update_attr(), or the fb_pad_*_buffer()
helpers; and if the console referenced by par->p was deallocated via
VT_DISALLOCATE so that par->p->fontdata is NULL, font_data_glyph_buf()
itself dereferences NULL in FNTSIZE().

The follow-up commit "fbcon: Handle characters with no glyph defined in a
consistent way" adds if (!src) checks after font_data_glyph_buf(), but does
not fix the par->p->fontdata mismatch in bitblit.c and falls back to
dereferencing par->rotated.buf (which is NULL in bitblit) when !src.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120115215.5209=
2-1-tzimmermann@suse.de?part=3D5
