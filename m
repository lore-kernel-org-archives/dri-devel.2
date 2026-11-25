Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF3606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLHq8Ykg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F48110E25F;
	Wed, 25 Nov 2026 21:05:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8BC10E25F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:05:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CD80620FA;
 Wed, 25 Nov 2026 21:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E741F000C6;
 Wed, 25 Nov 2026 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795640719;
 bh=RXDovrYSC5tpWDgHIoYPv5VxAIeIjDcxFnCzrKO3OIY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=kLHq8YkgGFPwViA0lNzBHTM1+WuHgT8MIQIOntjEYCHpdPgD0dNTdui2e6om/BMR3
 jELVCtxTCGq0ZoGbysGb2Qoi4eGv2b8jSnvzWYQr/zrc3NEep0+U2AOI5+miCe9xOv
 pMuSMWHAp6AiwYvws+kix956bobyrDqcDqgGT2YyIUf+12PM9XbUmCzSy3ZNo2U1E8
 uiTdtr/XiLVfyZ1iLeJyB2Cg11mDksL8xhf35UynSRPEM5IpG/2BSStX5uOWGFmIDR
 NT1Ytwan/9AAE9royL0oCvBe8SIeT4GBAwRnvP4uc+7O7uDDFnqTPNu81zA4Ll/vDK
 ZRz5ynpFySBIw==
Message-ID: <sashiko-outbox-234155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] fbcon: Don't drop last logo line if logo is same
 size as screen
To: "Helge Deller" <deller@gmx.de>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261125204846.428877-1-deller@gmx.de>
References: <20261125204846.428877-1-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:05:18 +0000
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
- [High] fbcon: slab-out-of-bounds read in fbcon_prepare_logo() when
  rows < logo_lines
--

commit c7b7e4b07b9a1354bf2bc5159428ad41f71350a8
Author: Helge Deller <deller@gmx.de>

fbcon: Don't drop last logo line if logo is same size as screen

This commit allows full-screen boot logos to use all screen rows while
keeping vc_top at 0 so console text can still scroll across the full
screen.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index d7890e119dc7d..289e6ce37f96d 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -665,13 +665,15 @@ static void fbcon_prepare_logo(struct vc_data *vc, =
struct fb_info *info,
>  		erase &=3D ~0x400;
>  	logo_height =3D fb_prepare_logo(info, par->rotate);
>  	logo_lines =3D DIV_ROUND_UP(logo_height, vc->vc_font.height);
> -	logo_lines =3D min(logo_lines, rows);
> -	logo_lines =3D min(logo_lines, new_rows - 1);
> +	logo_lines =3D min(logo_lines, new_rows);
>  	if (logo_lines <=3D 0) {
>  		logo_lines =3D 0;
>  		logo_shown =3D FBCON_LOGO_DONTSHOW;
>  		return;
>  	}
> +	if (logo_lines >=3D vc->vc_bottom)
> +		goto logo_fullscreen;
> +
>  	q =3D (unsigned short *) (vc->vc_origin +
>  				vc->vc_size_row * rows);
>  	step =3D logo_lines * cols;

[Severity: High]
Does dropping logo_lines =3D min(logo_lines, rows) reintroduce the
out-of-bounds read before vc->vc_origin that 94e6a058b168 ("fbcon: Fix
KASAN slab-out-of-bounds Read in fbcon_prepare_logo") fixed?

In fbcon_init(), rows holds the pre-resize row count while vc_resize() has
already updated vc->vc_bottom to new_rows.  When the console grows (for
example during vgacon-to-fbcon takeover) and rows < logo_lines < new_rows,
the logo_lines >=3D vc->vc_bottom check is not taken, so
r =3D q - logo_lines * cols underflows before vc->vc_origin (the start of
vc->vc_screenbuf):

drivers/video/fbdev/core/fbcon.c:fbcon_prepare_logo() {
	...
	q =3D (unsigned short *) (vc->vc_origin +
				vc->vc_size_row * rows);
	step =3D logo_lines * cols;
	for (r =3D q - logo_lines * cols; r < q; r++)
		if (scr_readw(r) !=3D vc->vc_video_erase_char)
			break;
	if (r !=3D q && new_rows >=3D rows + logo_lines) {
		...
			r =3D q - step;
			for (cnt =3D 0; cnt < logo_lines; cnt++, r +=3D i)
				scr_memcpyw(save + cnt * new_cols, r, 2 * i);
	...
}

scr_readw(r) then reads slab memory before vc->vc_screenbuf, and if
new_rows >=3D rows + logo_lines, scr_memcpyw() copies that out-of-bounds
heap data into save and then into the visible screen buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125204846.4288=
77-1-deller@gmx.de?part=3D1
