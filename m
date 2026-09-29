Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F2DCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B7510E21F;
	Tue, 29 Sep 2026 17:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QbTmwFwI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA4C10E21F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 17:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C539409B4;
 Tue, 29 Sep 2026 17:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F39E1F000FF;
 Tue, 29 Sep 2026 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790701430;
 bh=kOM7DeOoBIJZC8MESEarQt8iUouBLQ2I7o0pDrPBYN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QbTmwFwIFNfuVmcwdU2sLvlowkX532/MWTdw9YxJoFP1GRIdqBs96w9lQm+nMjur2
 gqPIgGEXOkQGibyMG+YgBh6Gf3nyRuRvqP6IApiblNPtrBbQpFw/56J3hmyWfo3ORc
 L2R0JaQNMwNm/YmHAmmYVMZvGfT5mzfdbyvEIkHxUGww3CnQ6r7TMd8MTP4OhD0jRl
 5FULY6U8u9WMl7iEYNoVIJ/K0yn5CU9ZaeXjT50rkf6gddvAo6qu+x/fPkvDSf1rhx
 Cnvho/4PvaUvcltn2Itxp01VdS7eopNa3pIiuFNu33WEjLnXJuaqQBbXICnKbg78ek
 G48wQ6CoyNZeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/vmwgfx: Add drm_panic support
To: "Ian Forbes" <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929165104.928415-1-ian.forbes@broadcom.com>
References: <20251107204620.1021749-1-ian.forbes@broadcom.com>
 <20260929165104.928415-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:03:49 +0000
Message-Id: <20260929170350.5F39E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/vmwgfx: invalid pointer dereference of ERR_PTR from devm_memre=
map
- [High] drm/vmwgfx: deadlock in panic handler due to spinlock acquisition =
on SVGA2
- [Medium] drm/vmwgfx: buffer overflow in drm_panic due to missing vram_siz=
e bounds check
--

commit a3fc842fd80e0209060a17de6e1213becdd10164
Author: Ian Forbes <ian.forbes@broadcom.com>

    drm/vmwgfx: Add drm_panic support
   =20
    Uses VRAM as the scanout buffer then switches the device to legacy mode.
    Restrict support to 64 Bit so we don't waste valuable VA space on the
    mostly unused VRAM mapping.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 0f101aedb49a0..e6e38b7a2d5b8 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -761,6 +761,12 @@ static int vmw_setup_pci_resources(struct vmw_privat=
e *dev,
>  		return -EINVAL;
>  	}
> =20
> +#if defined(CONFIG_64BIT)
> +	dev->vram_mem =3D devm_memremap(dev->drm.dev,
> +				      dev->vram_start,
> +				      dev->vram_size,
> +				      MEMREMAP_WB | MEMREMAP_DEC);

[Severity: High]
Does this code handle failures from devm_memremap() correctly?=20

If devm_memremap() fails during device initialization, it returns an ERR_PT=
R=20
value, but this value is assigned to dev->vram_mem without validation using=
=20
IS_ERR().

> +#endif
>  	/*
>  	 * This is approximate size of the vram, the exact size will only

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index a6c3304e1a67d..942176e2b3c69 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -2023,3 +2024,36 @@ bool vmw_user_object_is_null(struct vmw_user_objec=
t *uo)
>  {
>  	return !uo->buffer && !uo->surface;
>  }
> +
> +int
> +vmw_get_scanout_buffer(struct drm_plane *plane, struct drm_scanout_buffe=
r *sb)
> +{
> +	void  *vram;
> +	struct vmw_private *vmw_priv =3D container_of(plane->dev, struct vmw_pr=
ivate, drm);
> +
> +	// Only call on the primary display
> +	if (container_of(plane, struct vmw_display_unit, primary)->unit !=3D 0)
> +		return -EINVAL;
> +
> +	vram =3D vmw_priv->vram_mem;
> +	if (!vram)
> +		return -ENOMEM;

[Severity: High]
Can this code incorrectly forward an error pointer to iosys_map_set_vaddr()?

Because the previous devm_memremap() assignment was not checked for IS_ERR(=
),
this !vram check will not catch an ERR_PTR value.=20

The invalid pointer will then be passed along, causing a page fault and=20
recursive panic when the panic screen tries to render.

> +
> +	vmw_write(vmw_priv, SVGA_REG_CONFIG_DONE, false);

[Severity: High]
Is it safe to invoke vmw_write() here during a panic?

The panic handler runs in atomic context with interrupts disabled.
On SVGA2 hardware, vmw_write() acquires a spinlock:

vmw_write()
  spin_lock(&dev_priv->hw_lock);
  outl(offset, dev_priv->io_start + SVGA_INDEX_PORT);
  ...

If another CPU holds the lock, or if the panicking CPU was already holding =
it,
this will deadlock and permanently freeze the system instead of displaying =
the
panic screen.

> +
> +	iosys_map_set_vaddr(&sb->map[0], vram);
> +	sb->format =3D drm_format_info(DRM_FORMAT_RGB565);
> +	sb->width  =3D vmw_priv->initial_width;
> +	sb->height =3D vmw_priv->initial_height;
> +	sb->pitch[0] =3D drm_format_info_min_pitch(sb->format, 0, sb->width);

[Severity: Medium]
Could this result in a buffer overflow during panic rendering?

The vmw_priv->initial_width and initial_height dimensions are supplied by t=
he=20
host hypervisor and are copied directly to the drm_scanout_buffer without=20
verifying that the resulting buffer size fits within the mapped dev->vram_s=
ize.

If the hypervisor provides excessively large dimensions, the generic drm_pa=
nic=20
code will write out-of-bounds of the mapped PCI BAR region.

> +	return 0;
> +}
> +
> +void vmw_panic_flush(struct drm_plane *plane)
> +{
> +	struct vmw_private *vmw_priv =3D container_of(plane->dev, struct vmw_pr=
ivate, drm);
> +
> +	vmw_kms_write_svga(vmw_priv,
> +			   vmw_priv->initial_width, vmw_priv->initial_height,
> +			   vmw_priv->initial_width * 2, 16, 16);

[Severity: High]
Can this also cause a deadlock in the panic handler?

Similar to the vmw_write() call above, vmw_kms_write_svga() performs multip=
le
register reads and writes that invoke vmw_write() and acquire hw_lock on=20
SVGA2 hardware.=20

Since this runs in atomic panic context, acquiring a spinlock can deadlock=
=20
the system.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929165104.9284=
15-1-ian.forbes@broadcom.com?part=3D1
