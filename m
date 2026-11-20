Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514F606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCuhTT8V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC1311297B;
	Fri, 20 Nov 2026 12:01:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3629F112980
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:01:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A696662712;
 Fri, 20 Nov 2026 12:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05E21F000D0;
 Fri, 20 Nov 2026 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795176067;
 bh=c+vVERstLO3oItYRhFW50EmgEr3o7iS7G8avI+C84+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hCuhTT8VqeN0j3lYiuE4b8QQI4rdWuae991F0qNxe4fNUkX7hxXvyG+lHXMQWqMWc
 9UDB6JAaETlJB7O7LJl5KXLT9xox6mizeBexVc/u10ka7BUndOD4fGTO5IVlV8Z2AS
 3nUrHtJ0ktqRjZi0oaMmgzRSzVuLGuLPwo3l/Lr94W+6Y0Q0x+qIPQX/0KAOH5XtAA
 y0JWB0hWyWjawsmCnvma7A7w6SCdVYUnrjIWHHj5v0nc8i9R1b5iSfG7CHdSZAVF5V
 VZn83lJhz4z8ooqL5iH8D61u4kLISm2j6vcuSKafiSKqKSWVqXCVlLsFPOczSQBfVc
 CKdtkObM0gw9Q==
Message-ID: <sashiko-outbox-225104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] lib/fonts, fbcon: Use font_data_t for rotated fonts
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120115215.52092-4-tzimmermann@suse.de>
References: <20261120115215.52092-1-tzimmermann@suse.de>
 <20261120115215.52092-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:01:07 +0000
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
- [High] fbcon: invalid kfree() of font_data_t pointer in
  fbcon_do_set_font()
- [Low] lib/fonts: contradictory kernel-doc comment for
  font_data_rotate()
--

commit b5f0d07cd7c39fad0c72c3148ca9444f977625ca
Author: Thomas Zimmermann <tzimmermann@suse.de>

lib/fonts, fbcon: Use font_data_t for rotated fonts

This commit converts font_data_rotate() and struct fbcon_rotated.buf to
use font_data_t instead of unsigned char *, releasing rotated font data in
fbcon with font_data_put().

> diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/=
fbcon.h
> index 289a3d18f917f..28111c706e348 100644
> --- a/drivers/video/fbdev/core/fbcon.h
> +++ b/drivers/video/fbdev/core/fbcon.h
> @@ -75,8 +75,7 @@ struct fbcon_bitops {
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
>  struct fbcon_rotated {
>  	font_data_t *fontdata;       /* source font */
> -	unsigned char *buf;          /* rotated glyphs */
> -	size_t bufsize;
> +	font_data_t *buf;            /* rotated font */
>  	int buf_rotate;              /* rotation of buf */
>  	unsigned int buf_width;      /* geometry of source font */
>  	unsigned int buf_height;

[Severity: High]
Does fbcon_do_set_font() still pass struct fbcon_rotated.buf directly to
kfree() when changing the font on a visible rotated console?

drivers/video/fbdev/core/fbcon.c:fbcon_do_set_font() {
    ...
#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
	if (rotated_saved)
		kfree(saved_rotated.buf);
#endif
    ...
err_out:
#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
	if (rotated_saved) {
		kfree(par->rotated.buf);
		par->rotated =3D saved_rotated;
	}
#endif
    ...
}

Because __font_data_alloc() returns &font_data->data[0] (offset 16 bytes
past the start of struct font_data), calling kfree() on saved_rotated.buf
or par->rotated.buf frees an interior pointer and corrupts the slab. Both
paths need to check for a non-NULL buffer and release it with
font_data_put() instead.

[ ... ]

> diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
> index 275406008823b..ea54bd618ffb0 100644
> --- a/lib/fonts/font_rotate.c
> +++ b/lib/fonts/font_rotate.c
> @@ -181,8 +181,7 @@ EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
>   * @height: The number of scanlines in the glyph
>   * @charcount: The number of glyphs in the font
>   * @steps: Number of rotation steps of 90=C2=B0
> - * @buf: Preallocated output buffer; can be NULL
> - * @bufsize: The size of @buf in bytes; can be NULL
> + * @buf: Preallocated font data; can be NULL
>   *
>   * The parameters @width and @height refer to the visible number of pixe=
ls
>   * and scanlines in a single glyph. The number of glyphs is given in @ch=
arcount.
> @@ -194,16 +193,14 @@ EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
>   * as returned by font_data_buf(). Callers are responsible to free the r=
eturned
>   * buffer with kfree(). Font rotation typically happens when displays get
>   * re-oriented. To avoid unnecessary re-allocation of the memory buffer,=
 the
> - * caller can pass in an earlier result buffer in @buf for reuse. The ol=
d and
> - * new buffer sizes are given and retrieved by the caller in @bufsize. T=
he
> - * allocation semantics are compatible with krealloc().
> + * caller can pass in an earlier result in @buf for reuse. The returned =
font
> + * data should be released with font_data_put().

[Severity: Low]
This isn't a bug, but the earlier sentences in this kernel-doc comment
still say that the returned buffer is not compatible with font_data_t and
must be freed with kfree(), contradicting the new sentence at the end.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120115215.5209=
2-1-tzimmermann@suse.de?part=3D3
