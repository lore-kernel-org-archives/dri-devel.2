Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C2FC5AD2B
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 02:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE4A10E03B;
	Sat,  8 Aug 2026 02:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fhbqHRUJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D53810E03B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 02:46:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6EED46001A;
 Sat,  8 Aug 2026 02:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07761F000E9;
 Sat,  8 Aug 2026 02:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786157210;
 bh=CK3v4shHyZsbrYqEv+rIpNlNC+UOlK8g1WufY3ztiwY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fhbqHRUJ2ZiV5xFxEWEJooaPOUZuw1E+zaorOFHX4vM/mrhFqZKYpD4XWaUCzTgbq
 tBcwK4azAfoGcoJdjfT/GVNCf3PlpjMWXZOdpDurclQKilJsYXgFtqEpEXA24lomPf
 Rke2CJJUxdevpxqXm3R0NcsOXP1sVF/YHgPBomB1FKFsKYq7wEkYkJFnpm04BWO3a2
 gmXdiWqToNM+MO3DWQIyqJozVBo5o1ihN8YSXU4ttg2imBmZYKkI7SmibC253/e1rK
 HGV0GPe+2BYzSOG1Z3mrEEXo6VDFzAyfwep2YMXV5hHs3xPz/FjFdQ/a8t1zhz+bXo
 Vks7EuneA2x1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: bitblit: bound-check glyph index in bit_cursor()
To: "Rik van Riel" <riel@surriel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807221956.4e9dde5c@fangorn>
References: <20260807221956.4e9dde5c@fangorn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 02:46:48 +0000
Message-Id: <20260808024649.F07761F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The bounds checking for glyph indices is missing in software rotat=
ion paths (fbcon_ccw.c, fbcon_cw.c, fbcon_ud.c), leaving them vulnerable to=
 out-of-bounds heap reads.
--

--- Patch [1]: [PATCH] fbdev: bitblit: bound-check glyph index in bit_curso=
r() ---
commit eb8c6b0049962d4bc836a2579e035e53104adf59
Author: Rik van Riel <riel@surriel.com>

fbdev: bitblit: bound-check glyph index in bit_cursor()

This commit adds bounds checking for the glyph index in bit_cursor() to pre=
vent
out-of-bounds reads when fetching glyphs. It addresses cases where the scre=
en
buffer contains values larger than the current font's glyph count, which can
happen after a font resize or via malicious writes to /dev/vcsa.

Link: https://lore.kernel.org/all/6a75205c.01d0871a.3a0d52.0032.GAE@google.=
com/
Closes: https://syzkaller.appspot.com/bug?extid=3D61b1db46218109869c14

> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/cor=
e/bitblit.c
> index 65681dcc5930d..39f44258d793f 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -273,9 +273,14 @@ static void bit_cursor(struct vc_data *vc, struct fb=
_info *info, bool enable,
>  	if (!vc->vc_font.data)
>  		return;
> =20
> - 	c =3D scr_readw((u16 *) vc->vc_pos);
> +	c =3D scr_readw((u16 *) vc->vc_pos);
>  	attribute =3D get_attribute(info, c);
> -	src =3D vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
> +	c &=3D charmask;
> +
> +	/* Clamp to font size, same as bit_putcs_aligned() */
> +	if (c >=3D vc->vc_font.charcount)
> +		c =3D 0;
> +	src =3D vc->vc_font.data + (c * (w * vc->vc_font.height));

[Severity: High]
This isn't a bug introduced by this patch, but while checking the bounds for
the glyph index in bitblit.c is a great fix, could similar out-of-bounds
reads still occur in the software rotation paths?

Looking at the rotation code (fbcon_ccw.c, fbcon_cw.c, fbcon_ud.c), the bou=
nds
checking appears to be missing entirely. For example, in fbcon_ccw.c:

drivers/video/fbdev/core/fbcon_ccw.c:ccw_cursor() {
    ...
    c =3D scr_readw((u16 *) vc->vc_pos);
    attribute =3D get_attribute(info, c);
    src =3D par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
    ...
}

And in the putcs equivalents:

drivers/video/fbdev/core/fbcon_ccw.c:ccw_putcs_aligned() {
    ...
    src =3D par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
    ...
}

If a user loads a custom font with fewer than 256 or 512 glyphs (e.g., 100
glyphs), the rotation buffer par->rotated.buf is sized dynamically based on
charcount. If they then write an arbitrary 16-bit character index (e.g., 25=
5)
to the screen buffer via /dev/vcsa using vcs_write(), these rotated blit
functions will mask the index with 0xff or 0x1ff and directly use it to ind=
ex
par->rotated.buf.=20

Without clamping against vc->vc_font.charcount, wouldn't this result in
reading past the end of the heap-allocated rotation buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221956.4e9d=
de5c@fangorn?part=3D1
