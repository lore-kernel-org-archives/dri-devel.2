Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B7C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC5010E157;
	Thu, 10 Sep 2026 17:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mn79syXj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF3D10E157
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:44:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB53F4098E;
 Thu, 10 Sep 2026 17:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8901F000FF;
 Thu, 10 Sep 2026 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789062290;
 bh=1B0ADC7ykjmubpDrIeQepy7LjT/pLSJgcaypvw7JlVk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mn79syXjaU7Zeq8Sc3EyES+Iu/2y3droDRqllfvBlLPq98qPSRruEgFkD+tEm8pt3
 UqCbzegjFwaXyR72GmPkLqwfEmPgDegnagV+u384+fE4r5q7SoqdNao3lWqRr2jMuy
 3HDVxRjSZMXKoFKb47mpXDtjY61/WOozxW2Eqc+g2I5wt8+V9itJwygVjoQby1zeN9
 vAczCSx0KmG47XdAilpYwusBk2DKC4E8nmZMem0SwwuSmut+Y8bThXA/P7Fty0iLKO
 FlLgBphiPOFMZkDdb/odkizHVK18tEqaneH4V4cBy/DTeSYjZNW3RNMXoe5zooAC5l
 LZAkVdHsltOPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/vmwgfx: Release PRIME import in the BO
 destroy path
To: "Michal TOMA" <michaltoma@sicoop.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910165221.7558-3-michaltoma@sicoop.com>
References: <20260910165221.7558-1-michaltoma@sicoop.com>
 <20260910165221.7558-3-michaltoma@sicoop.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:44:50 +0000
Message-Id: <20260910174450.6A8901F000FF@smtp.kernel.org>
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
- [High] NULL pointer dereference when dma_buf import fails.
--

commit 200f36633d8d14d0ae43912ea8f089cba49bace3
Author: Michal TOMA <michaltoma@sicoop.com>

drm/vmwgfx: Release PRIME import in the BO destroy path

This patch fixes a resource leak in the vmwgfx driver where PRIME imported
dma-bufs are not properly torn down when the buffer object is destroyed. It
adds a call to drm_prime_gem_destroy() in vmw_bo_free() to ensure the
attachment and sg mapping are released.

> drm_gem_prime_import_dev() attaches to a foreign dma-buf, takes a
> reference with get_dma_buf(), maps the attachment and, once
> vmw_prime_import_sg_table() has created the TTM buffer object, stores
> the attachment in obj->import_attach. Drivers that import this way have
> to undo it by calling drm_prime_gem_destroy() when the object is freed.

[Severity: High]
This is a pre-existing issue, but since we are looking at the dma_buf import
path, could a failed import trigger a NULL pointer dereference here?

When a process imports a dma_buf via DRM_IOCTL_PRIME_FD_TO_HANDLE on the
vmwgfx device, the DRM core calls vmw_prime_import_sg_table(). If BO creati=
on
fails, the function returns NULL instead of an ERR_PTR:

drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:vmw_prime_import_sg_table() {
    ...
out_no_bo:
	dma_resv_unlock(params.resv);
	return gem;
}

In the DRM core, drm_gem_prime_import_dev() only checks for IS_ERR(),
which is false for NULL:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_import_dev() {
    ...
	obj =3D dev->driver->gem_prime_import_sg_table(dev, attach, sgt);
	if (IS_ERR(obj)) {
		ret =3D PTR_ERR(obj);
		goto fail_unmap;
	}

	obj->import_attach =3D attach;
    ...
}

Does this mean an unprivileged user could crash the kernel by forcing an
import failure (e.g. by exhausting memory or providing an excessive size)?

Should vmw_prime_import_sg_table() return ERR_PTR(-ENOMEM) instead of NULL
on failure?

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc3..56bc94edc30b7 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c

[ ... ]

> @@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
>  		vmw_surface_unreference(&vbo->dumb_surface);
>  	}
>  	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
> +	if (drm_gem_is_imported(&vbo->tbo.base))
> +		drm_prime_gem_destroy(&vbo->tbo.base, vbo->tbo.sg);
>  	drm_gem_object_release(&vbo->tbo.base);
>  	WARN_ON(vbo->dirty);
>  	kfree(vbo);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910165221.7558=
-1-michaltoma@sicoop.com?part=3D2
