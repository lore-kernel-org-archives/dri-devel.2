Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA538606A68C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqUfqy9F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0672E10E95A;
	Thu, 26 Nov 2026 08:33:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78B110E95A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:32:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A71A241E5D;
 Thu, 26 Nov 2026 08:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFC21F000CA;
 Thu, 26 Nov 2026 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795681975;
 bh=9spVlpQpBeZDDKuvLbp+p3LPVgIfIlVOOz6oo/4W0qQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WqUfqy9FPdEJJ7BJf7cdH3N9Qhg1uS9RUkoPleQWqilROXIvSpU+BmkVZuTt8sxw8
 gjeKyhfoSj/2OouujMIXhW8kXAxnGz+MvOV9MBTJO/hxcNRVlsKjY+w/RdcFO7d9Bk
 un+B4dKIKHz55bO4ScnMhlAccLC3OJ7Z0A1rOegkbjrx5IjX3vuOfiwS8FO9vyd7f3
 HuHXnVqznJce5uLqCYKdgoymQGPRVmOBQ2x9aAq0kESfb28xUboLmYuzTj5nLsjhuY
 p7thnX2lE5hDKOtTGVSPRK81XrLOz0rP7UGXUwhnxTxyjxRl/Ywlzr/kQyAtqnxINI
 1jW7RE3KpsngA==
Message-ID: <sashiko-outbox-235027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/sti: cursor: do not resize the pixmap from
 .atomic_check()
To: "Minseo Park" <hiyoukou@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261126024710.33401-2-hiyoukou@gmail.com>
References: <20261126024710.33401-1-hiyoukou@gmail.com>
 <20261126024710.33401-2-hiyoukou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:32:55 +0000
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
- [Medium] drm/sti: leak of managed pixmap DMA buffer on error in
  sti_cursor_create()
--

commit e56d841601d0e4ed868b107dc1847844ca728b69
Author: Minseo Park <hiyoukou@gmail.com>

drm/sti: cursor: do not resize the pixmap from .atomic_check()

This commit allocates the cursor pixmap DMA buffer once at plane creation
time instead of reallocating it inside sti_cursor_atomic_check().

> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_c=
ursor.c
> index 66f56355309f9..7295b6edb8ef9 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
[ ... ]
> @@ -377,6 +353,22 @@ struct drm_plane *sti_cursor_create(struct drm_devic=
e *drm_dev,
>  		return NULL;
>  	}
> =20
> +	/*
> +	 * Allocate the pixmap once, for the largest cursor the hardware
> +	 * supports.  It used to be reallocated from .atomic_check(), which
> +	 * freed a buffer the display engine could still be scanning out.
> +	 * Use the managed helper so it is released with the device.
> +	 */
> +	cursor->pixmap.size =3D STI_CURS_MAX_SIZE * STI_CURS_MAX_SIZE;
> +	cursor->pixmap.base =3D dmam_alloc_attrs(dev, cursor->pixmap.size,
> +					       &cursor->pixmap.paddr,
> +					       GFP_KERNEL,
> +					       DMA_ATTR_WRITE_COMBINE);
> +	if (!cursor->pixmap.base) {
> +		drm_err(drm_dev, "Failed to allocate memory for pixmap\n");
> +		goto err_clut;
> +	}
> +
>  	/* Allocate clut buffer */
>  	size =3D 0x100 * sizeof(unsigned short);
>  	cursor->clut =3D dma_alloc_wc(dev, size, &cursor->clut_paddr,
> @@ -387,7 +379,6 @@ struct drm_plane *sti_cursor_create(struct drm_device=
 *drm_dev,
>  		goto err_clut;
>  	}
> =20
> -	cursor->dev =3D dev;
>  	cursor->regs =3D baseaddr;
>  	cursor->plane.desc =3D desc;
>  	cursor->plane.status =3D STI_PLANE_DISABLED;

[Severity: Medium]
Does sti_cursor_create() leak cursor->pixmap.base when allocating
cursor->clut or calling drm_universal_plane_init() fails?

The err_plane and err_clut paths free cursor->clut and cursor, without
releasing cursor->pixmap.base.  Because sti_compositor_bind() treats a
NULL return from sti_cursor_create() as non-fatal and still returns 0,
devres on compo->dev is not released on failure and the 16 KiB DMA buffer
stays allocated while the compositor remains bound.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126024710.3340=
1-1-hiyoukou@gmail.com?part=3D1
