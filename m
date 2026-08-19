Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53837C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC77F10E165;
	Wed, 19 Aug 2026 16:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hb4kzG4b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A7510E165
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:57:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95F4961126;
 Wed, 19 Aug 2026 16:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6971F000E9;
 Wed, 19 Aug 2026 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787158637;
 bh=78Zzaeru8Uidqj+exXWIsxUjultI3utxBTz6SqdYnqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hb4kzG4bzSWH1iycqwZ19aryhM4Rh+RZKdAuM2mApagcM5pbej5OO3ogyNB1Bzmsb
 DwGnwBgchgyiRBEkx07LBLPU8ZMc3bFKUAmwDdDUyIz5QY0La+eD84E09gys6beYZM
 pQ1QEkZPifrjs9P7wlQV6Pqml6lPDX0xtS+yCNDO4mzgCqohbWZuq1EazfpMTtQGUo
 DObehMruAaOEDxbHPSkbNapg/tIMkaKoWKglBOqYy45fdKOP1gXSn8Cj4XGjEuHo9N
 lc2I7U/QAdnDAFmj1fAbUMoqH3jE3e/3S6r4fQvmAlu69Enkq+B/9vZzCuMrntl1bD
 06nfNsE93+lTw==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] KASAN: slab-out-of-bounds Read in soft_cursor
To: "Jaeyoung Chung" <jjy600901@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819163440.3702924-1-jjy600901@snu.ac.kr>
References: <20260819163440.3702924-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 16:57:16 +0000
Message-Id: <20260819165717.2F6971F000E9@smtp.kernel.org>
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
- [High] When setting a new console font via `fbcon_do_set_font`, if the fo=
nt dimensions change but the calculated row/column counts remain the same, =
the rotated font buffer (`par->rotated.buf`) is not reallocated. This leads=
 to a KASAN slab-out-of-bounds read during cursor rendering.
--

--- Patch [1]: [BUG] KASAN: slab-out-of-bounds Read in soft_cursor ---
commit 3dbd16581f6fdc2aab0064a8b856b4697ff8078c
Author: Jaeyoung Chung <jjy600901@snu.ac.kr>

KASAN: slab-out-of-bounds Read in soft_cursor

A report of a KASAN slab-out-of-bounds read in soft_cursor found by a fuzze=
r.
Includes a delay patch to reproduce the issue reliably.

> diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbde=
v/core/fbcon_rotate.c
> index 6cdbc96eeca6f..f4797dc2dd78d 100644
> --- a/drivers/video/fbdev/core/fbcon_rotate.c
> +++ b/drivers/video/fbdev/core/fbcon_rotate.c
[ ... ]
> @@ -38,6 +40,9 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_d=
ata *vc)
>  		ret =3D PTR_ERR(buf);
>  		goto err_kfree;
>  	}
> +	if (!strncmp(current->comm, "syzrepro", 8) &&
> +	    par->rotated.bufsize =3D=3D 4096)
> +		mdelay(50);
> =20
>  	par->rotated.buf =3D buf;
> =20

[Severity: High]
This is a pre-existing issue, but since this patch provides a reproducer
for the crash, the root cause appears to be an out-of-bounds read caused
by skipping font reallocation.

When setting a new console font via fbcon_do_set_font(), if the font
dimensions change but the calculated row/column counts remain the same
(e.g., 800/31 =3D=3D 25 and 800/32 =3D=3D 25), vc_do_resize() takes an earl=
y return:

drivers/tty/vt/vt.c:vc_do_resize() {
    ...
    if (new_cols =3D=3D vc->vc_cols && new_rows =3D=3D vc->vc_rows) {
        return resize_screen(vc, new_cols, new_rows, from_user);
    }
    ...
}

Because of this early return, the update_screen() call at the end of
vc_do_resize() is bypassed. Consequently, fbcon_rotate_font() is never
invoked to reallocate the rotated font buffer.

Later, when the cursor blink timer fires, cw_cursor() calculates a read
offset into the stale, undersized par->rotated.buf using the new, larger
font dimensions:

drivers/video/fbdev/core/fbcon_cw.c:cw_cursor() {
    ...
    src =3D par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
    ...
}

Could this stale buffer calculation be the source of the KASAN
slab-out-of-bounds read when passed to soft_cursor()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819163440.3702=
924-1-jjy600901@snu.ac.kr?part=3D1
