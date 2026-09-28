Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A2EC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD2610E817;
	Mon, 28 Sep 2026 09:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="At/kN12f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0945810E817
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:09:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32A1160052;
 Mon, 28 Sep 2026 09:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC31F000FF;
 Mon, 28 Sep 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790586589;
 bh=wi2jzKuyPggljN5tonSl1aWZJ9v0xu31EY4+l5BAXxY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=At/kN12fRrhOoM3zlwZmebmqx4IOJ4oR8Sfy8pNsbabLgzvnuVBbIuix/8/YagVrb
 7xEPf32vLrL+kLDPhSKCtVT2ZoxX1Sjk+Qt/By/SquyFF432Ctu8rCAOurdYhENS5G
 d5xoxB5IYVnv80mcbhh+70E+7Elm4qMMyMCv91HIXRfX4jR15eYeNTAADH7YW53lXz
 4DOhHQYXAJwFUU+GQeMq+02g2S3CL6SjaDYk3iDRX31KQajgYJfqG8MkcLqw+rIKjD
 JsVvQ8a10FPR/Ne/H6xUVB5gStRxfe0WIRgwa3oyZmEpvmCgU0ypja4fHcOEnsIEHk
 plZw8kZ/eFMUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] vgacon: Use vt_cursor_{start,end}()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260928085724.41660-4-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:09:49 +0000
Message-Id: <20260928090949.A7BC31F000FF@smtp.kernel.org>
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
- [Medium] vgacon: CUR_DEF bypasses pre-VGA hardware cursor hiding workarou=
nd
--

commit d1a44aa19f5cbfffe54990d3cf6f73ab9b42b5ed
Author: Thomas Zimmermann <tzimmermann@suse.de>

vgacon: Use vt_cursor_{start,end}()
   =20
Replace vgacon's custom cursor metrics with the shared helpers
vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
function returns the index of the scanline below the cursor, while
VGA hardware expects the cursor's final scanline. Hence vgacon
subtracts 1 from the end value.
   =20
The cursor shapes remain mostly unchanged, except that non-underline
cursors now also use the glyph's top-most and bottom-most scanline.
This follows the style used by fbcon.
   =20
v2:
- restore use of vc_cell_height (Sashiko)
   =20
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>

> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index 536e7fe4d1426..b1408bb5e2656 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
[ ... ]
> @@ -513,10 +514,11 @@ static void vgacon_cursor(struct vc_data *c, bool e=
nable)
>  	vgacon_restore_screen(c);
> =20
>  	c_height =3D c->vc_cell_height;
> +	c_size =3D CUR_SIZE(c->vc_cursor_type);
> =20
>  	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
> =20
> -	if (!enable) {
> +	if (!enable || c_size =3D=3D CUR_NONE) {

[Severity: Medium]
Does this check fail to intercept CUR_DEF if the default cursor is
configured as CUR_NONE?

If cur_default is set to CUR_NONE and an unprivileged user triggers a cursor
reset (\e[?0c), c_size will equal CUR_DEF. Since CUR_DEF does not equal
CUR_NONE, this bypasses the hardware-specific hide sequence below.

>  	        if (vga_video_type >=3D VIDEO_TYPE_VGAC)
>  			vgacon_set_cursor_size(31, 30);
>  		else
> @@ -524,33 +526,8 @@ static void vgacon_cursor(struct vc_data *c, bool en=
able)
>  		return;
>  	}
> =20
[ ... ]
> -	default:
> -		vgacon_set_cursor_size(1, c_height);
> -		break;
> -	}
> +	vgacon_set_cursor_size(vc_cursor_start(c_height, c_size),
> +			       vc_cursor_end(c_height, c_size) - 1);

[Severity: Medium]
If c_size is CUR_DEF and the default cursor is CUR_NONE, could this
cause cursor wrapping on EGA/MDA hardware?

When vc_cursor_start() and vc_cursor_end() resolve the CUR_DEF to CUR_NONE
internally, they both return c_height. This results in
vgacon_set_cursor_size() being called with start =3D c_height and
end =3D c_height - 1.

Pre-VGA hardware (EGA/MDA/CGA 6845 CRTCs) do not support start > end for
hiding cursors, which leads to a massive wrapping block cursor instead of
hiding it.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D3
