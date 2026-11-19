Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489EF606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0Qhr4aM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F481123A4;
	Thu, 19 Nov 2026 13:04:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98985112394
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:04:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E69046697;
 Thu, 19 Nov 2026 13:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE61F000C5;
 Thu, 19 Nov 2026 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795093489;
 bh=Eoa1kGBFpEm/oAGsW+O05XBDdxRDjt0ioK2a7KjYdPU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=U0Qhr4aMAyVJO0AMhJCNQW1CCCu5Xg+M92cdVAEopMVGOHZUkjjhXypy/0YC8uh7U
 yh4e8folHiyTzhZxIVXkdYEkVzGo8p2kjZPknbfx6yq3ytMz15TWCjjjlWx1igIJNx
 zLOpkYJCHvHspoMQbwdm0W0uHJqYlo91ADwOg5aVA28oe7WyFYi6DzeTrs2Q6+6OO/
 eQtQnhoM8MjwwRbS0lJcRjjpKyys71mSbN34SWVa6esRHCKD92T6+EIKvMCbFopdiP
 3SnpbJCrLLAinVZpddK2oPbKw7hXnfV24qNiMGECdsmXVS/PiDuBCeY5QE/n9kO6Vo
 nx7Oqaz8oQ90w==
Message-ID: <sashiko-outbox-223135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbcon: Don't drop last logo line if logo is same size
 as screen
To: "Helge Deller" <deller@gmx.de>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261119124944.98882-1-deller@gmx.de>
References: <20261119124944.98882-1-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:04:48 +0000
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
- [High] fbcon: out-of-bounds access in fbcon_prepare_logo() when logo
  fills screen
--

commit adce6f78babc951d216d03dcfa386a57041815ee
Author: Helge Deller <deller@gmx.de>

fbcon: Don't drop last logo line if logo is same size as screen

This commit changes the upper bound on logo_lines in fbcon_prepare_logo()
from new_rows - 1 to new_rows so that a full-screen boot logo does not
have its last line clipped.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index d7890e119dc7d..2809c7a6893f9 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -666,7 +666,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, st=
ruct fb_info *info,
>  	logo_height =3D fb_prepare_logo(info, par->rotate);
>  	logo_lines =3D DIV_ROUND_UP(logo_height, vc->vc_font.height);
>  	logo_lines =3D min(logo_lines, rows);
> -	logo_lines =3D min(logo_lines, new_rows - 1);
> +	logo_lines =3D min(logo_lines, new_rows);
>  	if (logo_lines <=3D 0) {
>  		logo_lines =3D 0;
>  		logo_shown =3D FBCON_LOGO_DONTSHOW;

[Severity: High]
Can allowing logo_lines to equal new_rows cause an out-of-bounds read past
vc->vc_screenbuf and leave the VT scrolling region empty?

When logo_lines =3D=3D new_rows, it equals vc->vc_bottom (vc->vc_rows), so =
the
end of fbcon_prepare_logo() sets vc->vc_top =3D vc->vc_bottom:

drivers/video/fbdev/core/fbcon.c:fbcon_prepare_logo() {
	...
	if (logo_lines > vc->vc_bottom) {
		logo_shown =3D FBCON_LOGO_CANSHOW;
		pr_info("fbcon: disable boot-logo (boot-logo bigger than screen).\n");
	} else {
		logo_shown =3D FBCON_LOGO_DRAW;
		vc->vc_top =3D logo_lines;
	}
}

In fbcon_switch(), the FBCON_LOGO_DRAW path then calls update_region()
with start =3D vc->vc_origin + vc->vc_size_row * vc->vc_top (which is
vc->vc_scr_end, one u16 past vc->vc_screenbuf) and count =3D 0.
do_update_region() reads scr_readw(p) before checking whether count is
zero, causing a 2-byte slab-out-of-bounds read past vc->vc_screenbuf:

drivers/tty/vt/vt.c:do_update_region() {
	...
	for(;;) {
		u16 attrib =3D scr_readw(p) & 0xff00;
		int startx =3D xx;
		u16 *q =3D p;
		while (xx < vc->vc_cols && count) {
	...
}

Having vc->vc_top =3D=3D vc->vc_bottom =3D=3D vc->vc_rows also leaves an em=
pty
scrolling region: con_scroll() returns early on top >=3D bottom without
scrolling or resetting vc->vc_top to 0, and if DEC Origin Mode
(vc->vc_decom) is enabled, gotoxy() clamps new_y < min_y to
vc->state.y =3D vc->vc_rows, placing vc->vc_pos at or past vc->vc_scr_end
for subsequent console reads and writes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119124944.9888=
2-1-deller@gmx.de?part=3D1
