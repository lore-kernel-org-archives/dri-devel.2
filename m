Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C6606A6EA
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdmEwQwF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4331510E035;
	Fri, 20 Nov 2026 19:58:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F04410E035
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:58:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E964444D35
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA091F000C4;
 Fri, 20 Nov 2026 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795204707;
 bh=VDM1d0EDWS2rm0wJTFcMUA6Q/uCzeoO1eePW0KoUL/c=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OdmEwQwFvYrooyvXLDhycia+qSan+N5n1zBjQV50Lzm43OEVGWoMa+UdpvWnrayng
 ce5RzjVMlmltK1V3+ZZ1TBDSC0bjPZHykEeQ4t5n8W+COa40WafJFODucrZN1K/nuX
 nsiSRuvujY+eEvDdRNhwkyNGY3+OidS9ksoJQnnzCvYsXYPd02mQmpjwDOe2ejgjn5
 1vnAgI+icd+GmrVfDyjGWoBPZX927/ViFysRjQ/plFPYGV9pcFkqek9+eE3vUp6v5K
 zwwuBrdmyQS9EpOZPE0PAuFLfPRK7m82IzUU5YQyKrFOEcXkiRn3GmxvLLIgJl787U
 CtMVfY+/Zaayg==
Message-ID: <sashiko-outbox-225984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] fbcon: Don't drop last logo line if logo is same
 size as screen
To: "Helge Deller" <deller@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <awCcqwVKi_n0KMhi@carbonx1>
References: <awCcqwVKi_n0KMhi@carbonx1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:58:26 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] fbcon: slab-out-of-bounds read in fbcon_prepare_logo() when
  cols > new_cols
- [Medium] fbcon: full-screen logo overwritten in fbcon_prepare_logo()
  if rows < new_rows
- [Low] fbcon: stale vc_top kept in fbcon_prepare_logo() when dimensions
  match
--

commit d343bfc671c341be6e2717c9d73d4817c83b82d0
Author: Helge Deller <deller@kernel.org>

fbcon: Don't drop last logo line if logo is same size as screen

This commit allows bootlogos that match the screen height to use all rows
without dropping the last line, while keeping vc_top unchanged and skipping
update_region() when a logo covers the entire screen.

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 7720dfc80c165..3be7f2ade65cc 100644
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

[Severity: High]
Can r underflow vc->vc_origin and cause a slab-out-of-bounds read in
scr_readw(r) when cols > new_cols?

In fbcon_init(), vc_resize(vc, new_cols, new_rows) runs before
fbcon_prepare_logo(), reallocating vc->vc_screenbuf to new_cols * new_rows
characters and setting vc->vc_size_row =3D 2 * new_cols:

drivers/video/fbdev/core/fbcon.c:fbcon_prepare_logo() {
    ...
	q =3D (unsigned short *) (vc->vc_origin +
				vc->vc_size_row * rows);
	step =3D logo_lines * cols;
	for (r =3D q - logo_lines * cols; r < q; r++)
		if (scr_readw(r) !=3D vc->vc_video_erase_char)
			break;
    ...
}

When transitioning from a console such as 80x25 vgacon to a narrower fbcon
(for example new_cols =3D 79, new_rows =3D 25, where vgacon_resize() return=
ed
-EINVAL during fbcon_startup() so cols is still 80), allowing logo_lines =
=3D=3D
rows makes logo_lines * cols larger than rows * new_cols.  Then r =3D q -
logo_lines * cols starts before vc->vc_origin.

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
Does a full-screen logo still set vc->vc_top to rows and get partially
overwritten whenever rows < new_rows?

Earlier in fbcon_prepare_logo(), logo_lines is clamped with min(logo_lines,
rows), whereas vc_resize() has already set vc->vc_bottom to new_rows.  When
taking over from a smaller console (such as 80x25 vgacon on a display with
more than 25 character rows), logo_lines is clamped to 25 while
vc->vc_bottom is new_rows, so logo_lines < vc->vc_bottom is true even for a
full-screen logo.  That sets vc->vc_top =3D rows, causing fbcon_switch() to
call update_region() after fb_show_logo() and erase the bottom new_rows -
rows lines of the logo.

[Severity: Low]
Can vc->vc_top remain non-zero when logo_lines =3D=3D vc->vc_bottom if the
console dimensions did not change?

When new_cols =3D=3D vc->vc_cols and new_rows =3D=3D vc->vc_rows, vc_do_res=
ize()
returns early via resize_screen() without resetting vc->vc_top to 0.  If
vc->vc_top was non-zero prior to fbcon_prepare_logo() (for example from an
earlier scrolling region or console unbind/rebind), skipping the assignment
leaves the stale non-zero vc->vc_top in place, and fbcon_switch() will call
update_region() over the full-screen logo.  Explicitly setting vc->vc_top =
=3D
0 in an else branch would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/awCcqwVKi_n0KMhi@ca=
rbonx1?part=3D1
