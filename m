Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFB8C61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 15:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1729A10E1F3;
	Sun, 30 Aug 2026 15:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H+YilxmH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9851E10E1F3
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 15:26:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A5A1414CA;
 Sun, 30 Aug 2026 15:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D47D1F000E9;
 Sun, 30 Aug 2026 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788103613;
 bh=0xaN7z8V2+eTet5Tau98hfUI0JAk4VrQ+3m+iGFUjU4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H+YilxmHDAzZj5hoTgGsDomMcyHq4jUuNband6+q2sSN9uJrBsXMqA+/BndxMw9Hg
 pmQuJNXk9t+DOoqXWkr01DKnx1JCkJT+XPwqPNVNJiMOPJDXDg5iCZJVGL0+txnsyY
 1E7jIjF1kUDFi7YuW8tMtPoENZdC+8eMKOvqBIFrtfefKPwILt0AqWICNBH7U10Lue
 SPrqbZyJoNRGe5cFYNUevwdUFRWXNhhqwbQR8R0UxTKtUEYUfd0iWfNOrdM67m12P5
 9rOOlCoRAaF+U/TpOvmvqoKXUKSWtVVOXNpGOUJXnBYIqLfudlDqNEbNWgPr2mKfBH
 p/ScBRT2ksltA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
To: fausten <yunfeng.li.nb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260830151619.2452307-1-yunfeng.li.nb@gmail.com>
References: <ef11cc4a-fbaa-415a-bda1-2ac491f3b5e2@broadcom.com>
 <20260830151619.2452307-1-yunfeng.li.nb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:26:52 +0000
Message-Id: <20260830152653.0D47D1F000E9@smtp.kernel.org>
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
- [Low] The patch incorrectly groups the `mob_max_size` validation under th=
e `cursor_max_dim > 0` condition in `vmw_cursor_mob_get()`.
--

commit 4e542ce85fcba71b4d6d0cd77e13a02898b305c1
Author: fausten <yunfeng.li.nb@gmail.com>
Date:   Sun Aug 30 15:16:19 2026 +0000

drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as unset

This commit modifies the cursor plane validation to treat a reported
SVGA_REG_CURSOR_MAX_DIMENSION of 0 as "not implemented". This restores
the hardware cursor visibility on older SVGA version 2 guests.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -237,8 +237,10 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plan=
e *vcp,
>  	mob_max_size =3D vmw_read(dev_priv, SVGA_REG_MOB_MAX_SIZE);
>  	cursor_max_dim =3D vmw_read(dev_priv, SVGA_REG_CURSOR_MAX_DIMENSION);
> =20
> -	if (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
> -	    vps->base.crtc_h > cursor_max_dim)
> +	/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
> +	if (cursor_max_dim > 0 &&
> +	    (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
> +	     vps->base.crtc_h > cursor_max_dim))

[Severity: Low]
Does this incorrectly bypass the mob_max_size check when cursor_max_dim
evaluates to 0?

The parentheses group size > mob_max_size with the cursor dimension
checks. If cursor_max_dim is 0, the logical AND fails early, which
completely skips checking if the size exceeds mob_max_size in
vmw_cursor_mob_get().

While this shouldn't cause an immediate out-of-bounds update since
vmw_cursor_plane_atomic_check() independently validates mob_max_size,
should the mob_max_size check remain separate from the cursor_max_dim
validation to ensure it is always evaluated here?

>  		return -EINVAL;
> =20
>  	if (vps->cursor.mob) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830151619.2452=
307-1-yunfeng.li.nb@gmail.com?part=3D1
