Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6B60A2602
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAl/v7iA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D3110E004;
	Fri, 20 Nov 2026 18:39:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6755210E004
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:38:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0997541B22;
 Fri, 20 Nov 2026 18:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2392B1F000C4;
 Fri, 20 Nov 2026 18:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795199934;
 bh=GSkaDhfgJm7eZQWSnPkJZuWPaW/8iawjn+9i0AUSV6c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=VAl/v7iATj+i6/kLZ65XGdpHuL2qGnltl2Ue+4rOXb6EHNRSgxzh/Z7HBOOhPC7Ku
 KTTig4ZdfXklEWWAU/5G8OLcY8ja/ToOJZsH2nccNnm4cKL9AsVTmfqqJ7GMOuYfJB
 30pNOm4TT5eqHFur68CLOzCXSXDMmSRCpzKCNJ4Xq9K4HwTdLUusrtuybTg1+AOn+M
 WWcvoTxghPD2e/QV8a+L10xmrPDFTuoUcXV4H3m5FfkKmsmj5/IdkaVFD/ax0bD9og
 X9V1ZAGuU3sG1msgGYd7iYDda91OF3UvygHLKEq5+8SxMyZKmPfpM3gEJvD8WyjmLX
 78NQ49yZbze3w==
Message-ID: <sashiko-outbox-225856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] fbcon: Don't drop last logo line if logo is same
 size as screen
To: "Helge Deller" <deller@gmx.de>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261120175413.176249-2-deller@gmx.de>
References: <20261120175413.176249-1-deller@gmx.de>
 <20261120175413.176249-2-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:38:53 +0000
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
- [Medium] fbcon: full-screen boot-logo overwritten by update_region()
  in fbcon_switch()
--

commit 1d5d014858b9e8c6374a333c00292505b2a11f3a
Author: Helge Deller <deller@gmx.de>

fbcon: Don't drop last logo line if logo is same size as screen

This commit allows logo_lines to reach new_rows in fbcon_prepare_logo() so
a full-screen boot logo is not truncated by one character row, while
keeping vc->vc_top unchanged when logo_lines reaches vc->vc_bottom.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 7720dfc80c165..12a27b520260e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -637,7 +637,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, st=
ruct fb_info *info,
>  	logo_height =3D fb_prepare_logo(info, par->rotate);
>  	logo_lines =3D DIV_ROUND_UP(logo_height, vc->vc_font.height);
>  	logo_lines =3D min(logo_lines, rows);
> -	logo_lines =3D min(logo_lines, new_rows - 1);
> +	logo_lines =3D min(logo_lines, new_rows);
>  	if (logo_lines <=3D 0) {
>  		logo_lines =3D 0;
>  		logo_shown =3D FBCON_LOGO_DONTSHOW;
> @@ -705,7 +705,9 @@ static void fbcon_prepare_logo(struct vc_data *vc, st=
ruct fb_info *info,
>  		pr_info("fbcon: disable boot-logo (boot-logo bigger than screen).\n");
>  	} else {
>  		logo_shown =3D FBCON_LOGO_DRAW;
> -		vc->vc_top =3D logo_lines;
> +		/* keep vc_top if logo covers whole screen */
> +		if (logo_lines < vc->vc_bottom)
> +			vc->vc_top =3D logo_lines;
>  	}
>  }
>  #endif /* MODULE */

[Severity: Medium]
When the boot logo covers the whole screen (logo_lines =3D=3D vc->vc_bottom=
),
does leaving vc->vc_top at 0 cause fbcon_switch() to immediately erase the
logo?

Earlier in fbcon_prepare_logo(), scr_memsetw() fills logo_lines rows of
vc->vc_origin with erase characters.  When fbcon_switch() runs with
logo_shown =3D=3D FBCON_LOGO_DRAW, it draws the logo and then redraws the t=
ext
region starting from vc->vc_top:

drivers/video/fbdev/core/fbcon.c:fbcon_switch() {
    ...
	if (logo_shown =3D=3D FBCON_LOGO_DRAW) {

		logo_shown =3D fg_console;
		fb_show_logo(info, par->rotate);
		update_region(vc,
			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
			      vc->vc_size_row * (vc->vc_bottom -
						 vc->vc_top) / 2);
		return false;
	}
    ...
}

With vc->vc_top left at 0, update_region() blits those blank erase
characters from vc->vc_origin over all rows 0..vc->vc_bottom - 1 right
after fb_show_logo(), wiping out the full-screen logo.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120175413.1762=
49-1-deller@gmx.de?part=3D2
