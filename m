Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B1606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wis7Wk0p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FEEB10EC7D;
	Mon, 23 Nov 2026 10:30:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FA310EBE1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:30:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6139661FAC;
 Mon, 23 Nov 2026 10:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FD21F000E0;
 Mon, 23 Nov 2026 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795429839;
 bh=csJ8UiN05u+HBHlaQbfO4lV0aFQ3+RlzZYD6cCBi5s0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wis7Wk0p68ORnvNa8QqjCrd6ivro3xkPg3VfxYeBulGniwdO4UrLIjJEEmmDVoEdj
 SETZT7tgD+iN6mv5lH8L1LeDTrvZ1aeftdkw+oRME0gSnKYHvKyHU0Kl0Ri3JbdCgP
 i0ZJruIgLXQhGmzafCh9siIRb/57D3TpF57TcvZsltOLT9SCQS97fZdeQLJy7KnzvA
 yLLczHP/3P8ATihvZTlyMARyqhlANjR3/Afj/pyI00mATpAl5QlHi0+hG2OkJDFSiA
 Oa8R1b3LWmpDIPUO486MhT3DpS9pZkGSg4smjtJINSX2rwfL8pVyfRBPeE5m8kDJif
 hIG6QM5xza16A==
Message-ID: <sashiko-outbox-229040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vt: Skip hardware scrolling while blanked and fix VESA
 blanking
To: "Yu Peng" <pengyu@kylinos.cn>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261123101151.414436-1-pengyu@kylinos.cn>
References: <20261123101151.414436-1-pengyu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:30:38 +0000
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
- [Medium] vt: con_scroll() skips vgacon_scroll() while palette-blanked
  in VRAM
--

commit fd87e862e45bd2b98326c37c1251a1bf748045f6
Author: Yu Peng <pengyu@kylinos.cn>

vt: Skip hardware scrolling while blanked and fix VESA blanking

This commit uses con_should_update() in con_scroll() and
console_callback() to skip hardware scrolling and scrollback while the
console is blanked, and returns !vga_palette_blanked from vgacon_blank()
for VESA blanking.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7dbc0072a40a9..0e24e4ea99bf1 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -726,8 +726,8 @@ static void con_scroll(struct vc_data *vc, unsigned i=
nt top,
>  		return;
> =20
>  	vc_uniscr_scroll(vc, top, bottom, dir, nr);
> -	if (con_is_visible(vc) &&
> -			vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
> +	if (con_should_update(vc) &&
> +	    vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
>  		return;
> =20
>  	src =3D clear =3D (u16 *)(vc->vc_origin + vc->vc_size_row * top);

[Severity: Medium]
Does checking con_should_update(vc) here break vgacon_scroll() while
vgacon is palette-blanked?

On color VGA text consoles (vga_video_type =3D=3D VIDEO_TYPE_VGAC), normal
blanking in vgacon_blank() sets vga_palette_blanked =3D true and returns
false, leaving vc->vc_origin pointing to uncached VGA MMIO VRAM rather
than vc->vc_screenbuf.

Because con_should_update(vc) is false whenever console_blanked is
non-zero, con_scroll() skips vgacon_scroll() even when
vga_palette_blanked is true.  Every scroll while palette-blanked then
falls back to software scr_memmovew() directly over uncached VGA MMIO
VRAM and overwrites vc->vc_origin in place instead of advancing through
the 32KB VRAM scrollback buffer.

In addition, if the console was scrolled back when do_blank_screen() ran,
hide_cursor() -> vgacon_cursor() -> vgacon_restore_screen() ->
vgacon_scrolldelta(c, 0) resets c->vc_visible_origin =3D c->vc_origin and
returns early without calling vga_set_mem_top(c).  Skipping
vgacon_scroll() (which calls vga_set_mem_top(c)) and then unblanking via
vgacon_unblank() (which only restores the palette when
vga_palette_blanked is true) leaves the VGA CRTC start address register
stuck at the old scrolled-back VRAM offset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123101151.4144=
36-1-pengyu@kylinos.cn?part=3D1
