Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FBECD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C775F10ED2A;
	Thu, 11 Jun 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NeJ06dWr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A50610ED2A
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D150560052;
 Thu, 11 Jun 2026 07:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3661F00893;
 Thu, 11 Jun 2026 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781163050;
 bh=mN5AUoJB73BNj0mQNwR9sSCep9Zf/+iRrw/5pQpsUzw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NeJ06dWru8vy1Tvpgm290W77BG2rbsQTFZvpwiyfCzR59A07GEXBzLZr0wqv8qGHb
 UjOKeLhJyQhcJtX8fBqvKd7vb282aioOKCN9eTnA/iEXPZ+Qd2DCWCR3l+rBVgKW8V
 1VmvVWmpY69588wAq0fAnEmQNdTk+lVqQSOgJMHJajQzSZsM4x2QESLNTU3J2KCunr
 DgoiONpTWlkJhkFd/g07SjtRemDKWfJ8qC2QYgDBQF/FvOY+EaTToyxupNj6qHz+6y
 A+nXpgsRnowr0Zpy08PLiN4N3VSyCWFLFjp7wsxOvjsdR8aS62x3himAirqxkxUmsi
 oEKKnd+xb4XlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/armada: fbdev: Calculate buffer geometry
 with format helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611072121.71492-2-tzimmermann@suse.de>
References: <20260611072121.71492-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:30:49 +0000
Message-Id: <20260611073049.DA3661F00893@smtp.kernel.org>
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
- [High] The newly added `check_mul_overflow` check is completely ineffecti=
ve because it stores the result in a `u64` variable. Since both operands (`=
pitch` and `sizes->surface_height`) are `u32`, their product can never over=
flow a 64-bit integer, meaning the check always passes. The `u64` size is t=
hen implicitly truncated to 32 bits when passed to `armada_gem_alloc_privat=
e_object()`, which expects a `size_t` argument. This completely bypasses th=
e intended overflow protection.
--

commit 9304c78ca806a472129099acb5c200bab2e752a0
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/armada: fbdev: Calculate buffer geometry with format helpers

This commit replaces the geometry and size calculation in armada's fbdev
emulation with DRM format helpers. It uses a 4CC lookup, pitch calculation,
and allocates the GEM buffer object for the framebuffer memory aligned to
PAGE_SIZE.

> diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/arma=
da/armada_fbdev.c
> index 8bbae94804f8b..f95658091acf2 100644
> --- a/drivers/gpu/drm/armada/armada_fbdev.c
> +++ b/drivers/gpu/drm/armada/armada_fbdev.c
> @@ -45,20 +45,30 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_hel=
per *fbh,
>  {
[ ... ]
> +	if (check_mul_overflow(pitch, sizes->surface_height, &size))
> +		return -EINVAL;
> +	size =3D ALIGN(size, PAGE_SIZE);
> +	if (size < PAGE_SIZE)
> +		return -EINVAL;
> =20
> -	size =3D mode.pitches[0] * mode.height;
>  	obj =3D armada_gem_alloc_private_object(dev, size);

[Severity: High]
This isn't a bug introduced by this patch, but does this check_mul_overflow=
()
actually prevent overflow here?

Since pitch and sizes->surface_height are 32-bit unsigned integers, and size
is a u64, the multiplication will never overflow the 64-bit target, so the
check will always pass.

However, when size is passed to armada_gem_alloc_private_object(), which
takes a size_t argument, couldn't this silently truncate to 32 bits since
the Armada DRM driver operates on a 32-bit architecture?

For example, if pitch * height evaluates to 0xFFFFFFFF, ALIGN() expands it
to 0x100000000. The check size < PAGE_SIZE evaluates to false on the u64,
but when passed to armada_gem_alloc_private_object(), the size truncates
to 0, resulting in an undersized buffer allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611072121.7149=
2-1-tzimmermann@suse.de?part=3D1
