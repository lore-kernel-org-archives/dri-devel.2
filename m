Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0DBC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE18B10E259;
	Thu, 27 Aug 2026 19:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="caZiuM7p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F227810E259
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:25:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2240600D4;
 Thu, 27 Aug 2026 19:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF81F00A3A;
 Thu, 27 Aug 2026 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787858734;
 bh=liM7vgTjmUm5n6RpLjwlfmzvmxa80WHxUVHF/vR/7uY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=caZiuM7pf9eWWkd454RQyZemP2hlx+jL9JVKiCxL7+9kJxVM5vsErt55fCyVf/JHV
 rat957dYlyX8+BmHOs1P7NNgUox7xr8HG71SZd+XghndcR+fl82D8q+np7sfCzzDkM
 ETAatyhoUfQcRYQ8/c5GKLbPGVvFaVzHW6b3sjUgmEwMYMkjJnLfQFxEtDtzEPFpnz
 oqTLM4i6hX1QIjbZCsrkyjyKq5LOXl48g4GOgGf89jvG2b50zpTBpKGVGAF0YObs7t
 /hhWRgn3FA46E/jq7y2QR6WiAfzmLea8PqtQIyn3H18PKdsbAmcc4irjeqH8dR464i
 bSB0gZLPcoMCQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 9/9]: vt: Misc changes, e.g. to #include directives
To: "Alan Mackenzie" <acm@muc.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <apCI6JhoH5D7ss34@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box> <apCI6JhoH5D7ss34@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:25:34 +0000
Message-Id: <20260827192534.73AF81F00A3A@smtp.kernel.org>
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
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `con=
_font_get()` can lead to a kernel heap buffer overflow.
- [Critical] Pre-calculating the allocation size `c` based on the per-conso=
le `vc->vc_font.charcount` causes a heap buffer overflow in `vgacon_font_ge=
t()` due to a per-console versus global state mismatch.
--

commit 501185cf94f089f684db150e409e50e6d10bc832
Author: Alan Mackenzie <acm@muc.de>

vt: Misc changes, e.g. to #include directives

Rearrange some #include directives, add some clarifying comments, and some
code changes which didn't fit elsewhere.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index baf7c98429e9c..0c389a5643576 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -4967,14 +4968,16 @@ static int con_font_get(struct vc_data *vc, struc=
t console_font_op *op)
>  {
>  	struct console_font font;
>  	int c;
> -	unsigned int vpitch =3D op->op =3D=3D KD_FONT_OP_GET_TALL ? op->height =
: 32;
> +	unsigned int vpitch =3D
> +		op->op =3D=3D KD_FONT_OP_GET_TALL ? vc->vc_font.height : 32;
> =20
>  	if (vpitch > max_font_height)
>  		return -EINVAL;
> =20
>  	void *font_data __free(kvfree) =3D NULL;
> +	c =3D DIV_ROUND_UP(vc->vc_font.width, 8) * vpitch * vc->vc_font.charcou=
nt;
>  	if (op->data) {
> -		font.data =3D font_data =3D kvzalloc(max_font_size, GFP_KERNEL);
> +		font.data =3D font_data =3D kvzalloc(c, GFP_KERNEL);

[Severity: Critical]
Does this introduce a race condition regarding the allocation size?

Since the buffer size c is now calculated using vc->vc_font.width and
vc->vc_font.charcount before acquiring the console_lock, couldn't another
thread concurrently call con_font_set(), update the console font dimensions
to be larger, and cause the newly sized font data to be written into this
undersized heap allocation later when vc_sw->con_font_get() is called inside
the lock?

Additionally, can this cause an issue with the vgacon driver due to a misma=
tch
between per-console and global state?

The vgacon driver tracks whether a 512-character font is in use globally
via vga_512_chars. However, vc->vc_font.charcount is maintained per-console.

If a 512-character font is set on one terminal (setting vga_512_chars to
true), but con_font_get() is called on a different terminal that still
has a 256-character font, this calculation will size the allocation for 256
characters.

The vgacon_font_get() callback will then observe the global flag and
force a read of 512 characters, writing out of bounds into the smaller
buffer during vgacon_do_font_op().

>  		if (!font.data)
>  			return -ENOMEM;
>  	} else
> @@ -4991,8 +4994,6 @@ static int con_font_get(struct vc_data *vc, struct =
console_font_op *op)
>  			return ret;
>  	}
> =20
> -	c =3D DIV_ROUND_UP(font.width, 8) * vpitch * font.charcount;
> -
>  	if (op->data && font.charcount > op->charcount)
>  		return -ENOSPC;
>  	if (font.width > op->width || font.height > op->height)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D9
