Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1568CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 21:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1539810E04B;
	Wed, 24 Jun 2026 21:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EaPbtYoV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248AE10E04B
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 21:30:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B975040441;
 Wed, 24 Jun 2026 21:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E01F000E9;
 Wed, 24 Jun 2026 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782336627;
 bh=kpsp1O/a2h++t3FFNQQ7+EXZZRgkv8H3NC3g2014xIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EaPbtYoVQPEvr2gjcRqSmMC1tGZkuU5Qws5yCeBGNuQeUUvGaEMtgza9LvBAmWeMz
 h+m4pJ7/uB2Kv4UiIxSgvq7kB80jxUpJgQIJoXwbrPGKdBXyqInD1cfFBLWC9Z0Wj/
 zcX9lhLXxoseDqz3p2I9+a3IBi9O7a5tPJWYIGGDgyHaGB6f3HbRSN8uw0BWshiTER
 3SDAthZV3PYaP38buIz2Op4ZYHSI6RsmHqyd3JuBCTH+RjNi0y90xUAf9XHmdZffG1
 p1AFnVmG67e2DHN7zCWbUjt33oiHd8vibomA9DVxOVz/qjfl1qLZUuXIiPJldwZzqt
 RTeuhDMm7YQjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbcon: fix NULL pointer dereference for a console
 without vc_data
To: "Ian Bridges" <icb@fastmail.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <ajxICA0v-_5NrqhS@dev>
References: <ajxICA0v-_5NrqhS@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 21:30:26 +0000
Message-Id: <20260624213027.6C1E01F000E9@smtp.kernel.org>
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
- [High] Pre-existing NULL pointer dereference via `font_data_get(NULL)` in=
 `fbcon_set_disp()` if the foreground console's font is uninitialized.
- [High] Pre-existing NULL pointer dereference in `fb_videomode_to_var()` w=
hen a console is switched to or resized while its `mode` is NULL.
--

commit 6f0719a9bd0a2231fe53bfe57ca1abf9ddec2785
Author: Ian Bridges <icb@fastmail.org>

fbcon: fix NULL pointer dereference for a console without vc_data

This commit fixes a NULL pointer dereference in fbcon_new_modelist(). It
does this by ensuring a console's mode is only set while it has a valid
vc_data structure.

Closes: https://syzkaller.appspot.com/bug?extid=3D42525d636f430fd5d983

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index b0e3e765360d1..7187be0eea872 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1274,6 +1274,7 @@ static void fbcon_deinit(struct vc_data *vc)
>  	int idx;
> =20
>  	fbcon_free_font(p);
> +	p->mode =3D NULL;

[Severity: High]
This is a pre-existing issue, but does setting p->mode to NULL here expose
us to a crash during a VT switch?

If a subsequent fbcon_init() fails early (e.g. var_to_display() fails to fi=
nd
a matching mode), p->mode will remain NULL. Later, if a user switches to th=
is
VT, the VT layer calls fbcon_switch(), which unconditionally passes p to
display_to_var():

drivers/video/fbdev/core/fbcon.c:fbcon_switch() {
    ...
    memset(&var, 0, sizeof(struct fb_var_screeninfo));
    display_to_var(&var, p);
    ...
}

display_to_var() then calls fb_videomode_to_var():

drivers/video/fbdev/core/fbcon.c:display_to_var() {
    ...
    fb_videomode_to_var(var, disp->mode);
    ...
}

And fb_videomode_to_var() immediately dereferences the pointer:

drivers/video/fbdev/core/modedb.c:fb_videomode_to_var() {
    ...
    var->xres =3D mode->xres;
    ...
}

Can this lead to a NULL pointer dereference if the modelist is altered from
userspace?

>  	idx =3D con2fb_map[vc->vc_num];
> =20
>  	if (idx =3D=3D -1)

[ ... ]

> @@ -1445,14 +1446,14 @@ static void fbcon_set_disp(struct fb_info *info, =
struct fb_var_screeninfo *var,
> =20
>  	p =3D &fb_display[unit];
> =20
> -	if (var_to_display(p, var, info))
> -		return;
> -
>  	vc =3D vc_cons[unit].d;
> =20
>  	if (!vc)
>  		return;
> =20
> +	if (var_to_display(p, var, info))
> +		return;
> +
>  	default_mode =3D vc->vc_display_fg;
>  	svc =3D *default_mode;
>  	t =3D &fb_display[svc->vc_num];

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
in font_data_get() if the foreground console's font is uninitialized?

Just below this hunk in fbcon_set_disp(), the code does:

    if (!p->fontdata) {
        ...
        p->fontdata =3D t->fontdata;
        font_data_get(p->fontdata);
    }

If fbcon_init() previously failed early for the foreground console, its
t->fontdata could be NULL. This assigns NULL to p->fontdata and then passes
it to font_data_get():

lib/fonts/fonts.c:font_data_get() {
    if (font_data_is_internal(fd))
        return; /* never ref static data */

    if (WARN_ON(!REFCOUNT(fd)))
        return; /* should never be 0 */
    ++REFCOUNT(fd);
}

The REFCOUNT() macro and font_data_is_internal() will unconditionally
dereference fd, causing a crash if it is NULL. Does this need an extra NULL
check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ajxICA0v-_5NrqhS@de=
v?part=3D1
