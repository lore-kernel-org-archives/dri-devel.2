Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF69606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etmLAPMK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FC610EA07;
	Thu, 26 Nov 2026 16:36:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5462A10EA07
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:36:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F30162527;
 Thu, 26 Nov 2026 16:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25951F000CA;
 Thu, 26 Nov 2026 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795710961;
 bh=XCHTek6MzXd87bfx8DziwseqJoZ/rGjJl66jteBEW2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=etmLAPMKg3wSxSPaCE74UHd0CRn90WOabgOhH7pfoOcDr+sAiEpcuNGvYf1tqwa9v
 ot5XKWGEhh3hwmaGFnKfSSkMK/RqNy0Y3pQtT3j3nU1iF27QVssNU2U2DXzHHh8gav
 T4meCWmLolKICWeA7fgqDcKb5eAwxJjgH4EdRQL30hzJjiUJG6gmPr+PcjBwvjqlpQ
 K6+GgvN6nRVtWlh9B+IQdQUTNYDT280U4h1aEla9dYEYu6ByG/hbCVnVe4677A4HW/
 /+0S9iz2U8VnlDcJ65i6JfbVdbk92Gs2jN1iaQg+9NvsyWxLMmO0aQxUHNhBfZGiGi
 irsp1XVUTCbwg==
Message-ID: <sashiko-outbox-235924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] fbcon: Provide a single implementation of
 fbcon_set_rotation()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126163150.91355-3-tzimmermann@suse.de>
References: <20261126163150.91355-1-tzimmermann@suse.de>
 <20261126163150.91355-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:36:00 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] fbcon: unrotated mode fallback clobbered by set_blitting_type()
  [1]
--

commit b31c406a9ea618e6fff12f41e21bd7c311a16303
Author: Thomas Zimmermann <tzimmermann@suse.de>

fbcon: Provide a single implementation of fbcon_set_rotation()

This commit merges the CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy and =3Dn
implementations of fbcon_set_rotation() into a single function calling
fbcon_display_rotation().

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/=
fbcon.c
> index 7bd51b9f4fe13..fd89465b0754e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
[ ... ]
> @@ -281,6 +267,13 @@ static void fbcon_rotate_all(struct fb_info *info, u=
32 rotate)
>  }
>  #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
> =20
> +static void fbcon_set_rotation(struct fb_info *info)
> +{
> +	struct fbcon_par *par =3D info->fbcon_par;
> +
> +	par->rotate =3D fbcon_display_rotation(info, par->p);
> +}
> +

[Severity: High]
This problem wasn't introduced by this patch, but doesn't
fbcon_set_rotation() clobber the unrotated fallback when font rotation
allocation fails [1]?

When par->bitops->rotate_font() fails in fbcon_switch(), fbcon_init() or
fbcon_modechanged(), the caller falls back to unrotated mode by setting
par->rotate =3D FB_ROTATE_UR and calling set_blitting_type():

drivers/video/fbdev/core/fbcon.c:fbcon_switch() {
    ...
	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
		par->rotate =3D FB_ROTATE_UR;
		set_blitting_type(vc, info);
	}
    ...
}

set_blitting_type() then calls fbcon_set_rotation(info) followed by
fbcon_set_bitops(par), which overwrites par->rotate with
fbcon_display_rotation(info, par->p) (derived from par->p->con_rotate)
and reinstalls the rotated bitops without an allocated rotated font
buffer, leaving the console blank.

[1] https://sashiko.dev/#/bug/linux-752875af-5863-44fb-8a6c-f76bb439e2f3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126163150.9135=
5-1-tzimmermann@suse.de?part=3D2
