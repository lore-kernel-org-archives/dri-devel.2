Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD0FC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0570F10EBD3;
	Tue,  4 Aug 2026 21:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iChpCThh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5DD10EBD3
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 21:07:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F87B41694;
 Tue,  4 Aug 2026 21:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A91F000E9;
 Tue,  4 Aug 2026 21:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785877670;
 bh=vf4vi0Tg8+nNVAvQ/zoVGFY2XJ39oqLOnFtarSIHfts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iChpCThhF5vzXH1Wm5CMgoqQNY8uxImaD8NKUtlYTQxEyavJDdyG8OAKwp9M4EYC7
 LZCmcaO3X4rsGvmmFWZIq48IYgTMotKM0OlIfY/as5Pg6FW6xzrevDyBsvPX5kdZsN
 ifDY8sZjjtO+tmRw+ZQMFC+w3AxAdlmbK6r3MOo+ryjCqDnrvA9CZgXEYHelPlt3gm
 ebBgNwMk15RzsVVDhsR9pc9uWvZBwSVa4XIjyAOz0mB1n34OP7jWmELayMUE4tTbLK
 a83VqSfwyzJIRbr3oHSZOrsDj8m+dUnZx4GxynLTSeZIvEeZLSzQVgTtSW82mfAQq8
 8EFyQDEmhecrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] fbdev: honour the device tree boot logo
 placement properties
To: "Max Pedraza" <maximpedraza@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260804225617.264861-4-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-4-maximpedraza@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 21:07:47 +0000
Message-Id: <20260804210748.BB8A91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unvalidated device tree coordinates cause out-of-bounds memory acc=
esses in the framebuffer.
- [High] DT logo placement logic ignores SMP logo count and extra logos, br=
eaking centering and overlapping extra logos.
- [High] fb_logo_dt_reserve() calculates logical console space reservations=
 using the incorrect physical axis during screen rotation.
- [High] Overriding logo rotation via device tree breaks the reservation co=
ordinate space contract with fbcon.
- [Medium] TOC-TOU initialization race on `read_done` static flag in `fb_lo=
go_dt_read`.
--

--- Patch [3]: [PATCH v2 3/6] fbdev: honour the device tree boot logo place=
ment properties ---
commit bd67300c4f145f9b35c28ceac495f14e402f271d
Author: Max Pedraza <maximpedraza@gmail.com>

fbdev: honour the device tree boot logo placement properties

A logo supplied by the device tree describes a specific product, so where
it lands on the panel matters in a way it does not for the built-in Tux.
Honour the optional "logo-position", "logo-offset", "logo-centered" and
"logo-rotation" properties of the "linux,boot-logo-clut224" node.

> diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/cor=
e/fb_logo.c
> --- a/drivers/video/fbdev/core/fb_logo.c
> +++ b/drivers/video/fbdev/core/fb_logo.c
> @@ -2,12 +2,178 @@
> =20
>  #include <linux/fb.h>
>  #include <linux/linux_logo.h>
> +#include <linux/of.h>

[ ... ]

> +static void fb_logo_dt_read(void)
> +{
> +	struct fb_logo_dt_placement *p =3D &fb_logo_dt;
> +	static bool read_done;
> +	struct device_node *np;
> +	const char *rotation;
> +	u32 val[2];
> +	int rot;
> +
> +	if (read_done)
> +		return;
> +
> +	read_done =3D true;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "linux,boot-logo-clut224");

[Severity: Medium]
Could this lead to a race condition if called concurrently?

By setting read_done to true before the fb_logo_dt structure is actually
populated, could another thread see read_done as true and proceed to use an
uninitialized structure?

[ ... ]

> +/* Top edge of the logo, in the coordinate space the caller works in */
> +static int fb_logo_dt_top(unsigned int yres, unsigned int logo_height)
> +{
> +	struct fb_logo_dt_placement *p =3D &fb_logo_dt;
> +	int top;
> +
> +	if (p->centered)
> +		top =3D ((int)yres - (int)logo_height) / 2;
> +	else if (p->has_position)
> +		top =3D p->y;
> +	else
> +		top =3D 0;
> +
> +	return max(top + p->offset_y, 0);
> +}

[Severity: High]
When the screen is hardware-rotated (for example, CW or CCW), does returning
the physical Y coordinate here result in a broken reservation geometry?

fb_prepare_logo() needs the reservation height in the logical coordinate sp=
ace
of the console. When rotated, the console's logical vertical axis maps to t=
he
hardware's horizontal X-axis, but this logic unconditionally uses the physi=
cal
Y position (p->y).

> +static void fb_logo_dt_place(struct fb_info *info, struct fb_image *imag=
e)
> +{
> +	struct fb_logo_dt_placement *p =3D &fb_logo_dt;
> +	int dx;
> +
> +	fb_logo_dt_read();
> +
> +	if (!p->valid)
> +		return;
> +
> +	if (p->centered)
> +		dx =3D ((int)info->var.xres - (int)image->width) / 2;
> +	else if (p->has_position)
> +		dx =3D p->x;
> +	else
> +		dx =3D image->dx;
> +
> +	image->dx =3D max(dx + p->offset_x, 0);
> +	image->dy =3D fb_logo_dt_top(info->var.yres, image->height);
> +}

[Severity: High]
Does this logic break the centering of SMP logos and the vertical stacking =
of
extra logos?

When rendering multiple logos, fb_show_logo_line() calculates a block-cente=
red
X coordinate for the SMP penguins and an accumulated Y coordinate to stack =
any
extra logos.

By calculating dx using only a single image->width, this seems to break SMP
block centering. Additionally, overwriting image->dy with a static position
forces all subsequent extra logos to render at the exact same vertical posi=
tion
causing them to overlap.

[Severity: High]
Can these unvalidated device tree coordinates cause an out-of-bounds memory
access in the framebuffer?

fb_logo_dt_place() applies the device tree positions directly to image->dx
and image->dy without clamping them to the actual screen dimensions.

If a large offset is provided, would fb_do_show_logo() process the unvalida=
ted
Y coordinate? For example, in the FB_ROTATE_UR case:

    for (x =3D 0;
         x < num && image->dx + image->width <=3D info->var.xres;
         x++) {
            info->fbops->fb_imageblit(info, image);

The loop checks the X bounds but lacks checks for image->dy + image->height
against info->var.yres, potentially passing arbitrarily large Y coordinates
to the driver's fb_imageblit callback.

[ ... ]

> @@ -423,6 +592,8 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
> =20
>  	memset(&fb_logo, 0, sizeof(struct logo_data));
> =20
> +	rotate =3D fb_logo_dt_rotation(rotate);
> +
>  	if (info->flags & FBINFO_MISC_TILEBLITTING ||
>  	    info->fbops->owner || !fb_logo_count)
>  		return 0;

[Severity: High]
Does overriding the caller's rotation parameter here break the coordinate s=
pace
agreement with the fbcon subsystem?

The fbcon subsystem calls fb_prepare_logo() with its own console rotation s=
tate
and expects the returned reservation height to scale accurately against its
logical vertical axis. If fb_logo_dt_rotation() overrides this with a
differing rotation from the device tree, will fbcon incorrectly interpret t=
he
resulting reservation height against its differing logical axis?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804225617.2648=
61-1-maximpedraza@gmail.com?part=3D3
