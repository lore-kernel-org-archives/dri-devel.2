Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00608C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A0C10F18B;
	Thu, 27 Aug 2026 19:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UMAgCkVx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514CB10F18B
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:22:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8715C600D9;
 Thu, 27 Aug 2026 19:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1746E1F000E9;
 Thu, 27 Aug 2026 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787858528;
 bh=OYHS1NO2GgjbDIZlUFLc3vRrFCtzRKpicpFqTlXsr3Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UMAgCkVxCKSy5Kfx3X+7A8lyJ6dkWR643cyQfeNzDfgrGKMEGJQBYe/901YBVKPwO
 U2doNbOqkH8Ij/MfxRFkiDtPDM91ujoyxovTgWO8VOpz6pzXxWdab14wz4ZS7Sh/Gl
 gXFd/nyVYxnD457LEFN5ZlnUoFyhEfr0rHrMyKv678HRsWf0EwX+BYiSLD4O87KK66
 JcbV0bFDtCAp+DtjTvpfcmvUUG/UpwNtR0HVoCQNxpxXDZVHojAwgUglkjkYiiN4ky
 v5dyaRYtwEcWeMf+0Xu1UikRjVv9G7m9A3ZRIkxGx63ZtN/HqpZhafDrpudtg03tno
 FzbRrnauA2YhA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 6/9]: vt: Use u32 and typedef u1632 to handle whole glyphs
To: "Alan Mackenzie" <acm@muc.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <apCHgPpGWGfVz2cI@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCHgPpGWGfVz2cI@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:22:07 +0000
Message-Id: <20260827192208.1746E1F000E9@smtp.kernel.org>
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
- [Critical] Using a raw 32-bit pointer dereference for VGA I/O memory caus=
es hardware faults on strict architectures and overflows 16-bit hardware vi=
deo RAM.
- [High] Casting a 32-bit stack variable's address to a 16-bit pointer in `=
con_putc` leads to blank or NUL characters on all big-endian architectures =
when 21-bit glyphs are disabled.
- [High] Pointer arithmetic in `fbcon_switch` implicitly assumes 16-bit gly=
phs, causing buffer misalignment and screen corruption when 32-bit glyphs a=
re enabled.
- [Medium] Fallback console translation macros were not updated for the new=
 `u1632` types, resulting in data truncation and build warnings.
--

commit 6fc77218ba179478ec0c7c9f101ceadca53ba76a
Author: Alan Mackenzie <acm@muc.de>

vt: Use u32 and typedef u1632 to handle whole glyphs

vt: 32b glyph: 6. Use u32 and typedef u1632 to handle whole glyphs

The glyph size u1632 is an either 32- or 16-bit unsigned word
depending on whether or not CONFIG_FB_GLYPH_21BIT is #defined.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8c7cbc47836fd..9208970f731e0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -322,12 +322,12 @@ static inline u16 *screenpos(const struct vc_data *=
vc, unsigned int offset,
>  	return (u16 *)(origin + offset);
>  }
> =20
> -static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigne=
d int x)
> +static void con_putc(struct vc_data *vc, u32 ca, unsigned int y, unsigne=
d int x)
>  {
>  	if (vc->vc_sw->con_putc)
>  		vc->vc_sw->con_putc(vc, ca, y, x);
>  	else
> -		vc->vc_sw->con_putcs(vc, &ca, 1, y, x);
> +		vc->vc_sw->con_putcs(vc, (u16 *)&ca, 1, y, x);

[Severity: High]
Does casting this 32-bit local variable address to a 16-bit pointer expose
the endian-dependent memory layout to the backend driver?

On big-endian architectures where 21-bit glyphs are disabled, this cast
points to the most-significant 16 bits of the 32-bit variable (which are
zero). This leads to the backend reading 0x0000 and rendering a NUL charact=
er
instead of the true glyph.

[ ... ]
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 3e7cba53bdfc2..576be479d9286 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -2166,6 +2166,7 @@ static bool fbcon_switch(struct vc_data *vc)
>  	struct fbcon_par *par;
>  	struct fbcon_display *p =3D &fb_display[vc->vc_num];
>  	struct fb_var_screeninfo var;
> +	unsigned short *d, *s;
>  	int i, ret, prev_console;
> =20
>  	info =3D fbcon_info_from_console(vc->vc_num);

[Severity: High]
Does the pointer arithmetic in fbcon_switch implicitly assume 16-bit glyphs?

When a logo is displayed and the console is switched, the row pointers are
advanced using vc_cols:

			while (i--) {
				scr_memcpyw(d, s, conp2->vc_size_row);
				d +=3D conp2->vc_cols;
				s +=3D conp2->vc_cols;
			}

When CONFIG_FB_GLYPH_21BIT is enabled, vc_size_row is vc_cols * 4 bytes.
However, d and s are unsigned short *, so adding vc_cols only advances the
pointer by vc_cols * 2 bytes. Can this cause subsequent rows to overwrite
the second half of the previous row?

[ ... ]
> diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
> index 539d488fdc03f..5e50b4d4bd0b3 100644
> --- a/include/linux/consolemap.h
> +++ b/include/linux/consolemap.h
[ ... ]
> @@ -32,7 +42,7 @@ unsigned int ucs_get_width(uint32_t cp);
>  u32 ucs_recompose(u32 base, u32 mark);
>  u32 ucs_get_fallback(u32 cp);
>  #else
> -static inline u16 inverse_translate(const struct vc_data *conp, u16 glyp=
h,
> +static inline u1632 inverse_translate(const struct vc_data *conp, u16 gl=
yph,
>  		bool use_unicode)
>  {
>  	return glyph;

[Severity: Medium]
Were the fallback console translation macros missed when updating to the new
u1632 types?

The fallback for inverse_translate still accepts a u16 glyph, truncating any
32-bit glyph passed into it.

Additionally, the set_translate fallback below this (not shown in the diff)
still returns unsigned short *, which causes a type mismatch when assigned =
to
vc->vc_translate (which is now a u1632 *).

[ ... ]

Additionally, I have a question regarding the scr_writeg macro defined in
include/linux/vt_buffer.h, which is heavily used by these console updates:

include/linux/vt_buffer.h:
#define scr_writeg(val, addr) \
        (*((u32 *)(addr)) =3D (val))

[Severity: Critical]
Does using a raw 32-bit pointer dereference for VGA I/O memory cause hardwa=
re
faults on strict architectures (e.g., Alpha, MIPS)?

This bypasses architectural I/O accessors like writel/writew, which are
required for accessing MMIO space on these architectures. Furthermore, can
this overflow 16-bit hardware video RAM, since VGA VRAM requires exactly
16-bit accesses per character cell?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D6
