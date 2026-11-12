Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A1606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHrMsxdi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7303310EBD5;
	Thu, 12 Nov 2026 23:17:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7DD10EBD5
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:17:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8BBC41310;
 Thu, 12 Nov 2026 23:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FCC1F000C4;
 Thu, 12 Nov 2026 23:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525420;
 bh=EeoHMmMmLZ3LEUwmas8T2Mt4+xvcUDEQpSTvrZO7z8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CHrMsxdid4zhSu2UavxXyNCi4CYC/53l+JbQE8gur2TxK/BP025Ab/lqt4DiJ/knZ
 0Zz+JZTGmJGd11vEpMvL3Ua/oWRi66nINZzz5MgR/t1AuaHwina0ccjQde79gU2gjq
 aPA4LR+QToGfVEngOfyKlJoSz/XYxryJPQo58jbNYDzBULf3V+PxR4gwHPrueeyK7b
 eSv8fxSdAaaLS8dtX2bxyqPOwO/AMNtZ4v7UKYcz8ix7MTFG/5WlqAr3SQJ3Irk0NQ
 wMZs6t2MbjVMjlGhMtUZXXACN/VRv5u9wWRZfU78gd6GpEwPzFQotKV6w5D6aMMGBJ
 cm6ViyWkS07aA==
Message-ID: <sashiko-outbox-211938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/13] drm/gma500: Export GEM objects as dma-bufs
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-3-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-3-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:16:59 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/gma500: stale GTT PTEs on resume in
  psb_gem_mm_populate_resources()
- [Medium] drm/gma500: missing stolen check in psb_gem_prime_export()
- [Medium] drm/gma500: unchecked set_pages_array_wc() in
  psb_gem_get_pages_locked()
- [Low] drm/gma500: unused split of psb_gem_pin_locked() and
  psb_gem_unpin_locked()
--

commit 32b59ef191363e7eeb07c9ca33caea7c6e0ca7e5
Author: Joseph Telaak <joseph@telaak.dev>

drm/gma500: Export GEM objects as dma-bufs

This commit adds PRIME export, pin, unpin, get_sg_table, vmap and vunmap
hooks for psb_gem_object so companion GPUs can import gma500 scanout
buffers as dma-bufs.

> diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
> index 4a4ecfb7b299d..9eff7a739c98a 100644
> --- a/drivers/gpu/drm/gma500/gem.c
> +++ b/drivers/gpu/drm/gma500/gem.c
> @@ -26,71 +29,104 @@
>   * PSB GEM object
>   */
> =20
> -int psb_gem_pin(struct psb_gem_object *pobj)
> +/*
> + * The object's pages, write-combined, for a GART pin or a PRIME export:=
 an
> + * exported object needs them, not a slot in the small GTT aperture.
> + */
> +static int psb_gem_get_pages_locked(struct psb_gem_object *pobj)
> +{
> +	struct drm_gem_object *obj =3D &pobj->base;
> +	struct page **pages;
> +
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (pobj->pages_use++)
> +		return 0;
> +	pages =3D drm_gem_get_pages(obj);
> +	if (IS_ERR(pages)) {
> +		pobj->pages_use--;
> +		return PTR_ERR(pages);
> +	}
> +	set_pages_array_wc(pages, obj->size / PAGE_SIZE);
> +	pobj->pages =3D pages;
> +	return 0;
> +}

[Severity: Medium]
What happens if set_pages_array_wc() fails here?

On failure, _set_pages_array() rolls back its PAT reservations and leaves
the pages write-back in the direct map.  Ignoring the error allows
psb_gem_prime_vmap() to create a write-combined vmap() alias against those
write-back pages, and causes psb_gem_put_pages_locked() to later call
set_pages_array_wb() -> memtype_free() on ranges whose reservations were
already freed.

> +
> +static void psb_gem_put_pages_locked(struct psb_gem_object *pobj)
> +{
> +	struct drm_gem_object *obj =3D &pobj->base;
> +
> +	dma_resv_assert_held(obj->resv);
> +
> +	if (WARN_ON(!pobj->pages_use) || --pobj->pages_use)
> +		return;
> +	/* Reset caching flags */
> +	set_pages_array_wb(pobj->pages, obj->size / PAGE_SIZE);
> +	drm_gem_put_pages(obj, pobj->pages, true, false);
> +	pobj->pages =3D NULL;
> +}

[Severity: High]
Can this leave stale physical page mappings in the GTT after a resume?

psb_gem_get_pages_locked() sets pobj->pages for PRIME pins and vmaps while
pobj->in_gart remains 0.  On resume, psb_gem_mm_populate_resources()
checks pobj->pages rather than pobj->in_gart:

drivers/gpu/drm/gma500/gem.c:psb_gem_mm_populate_resources() {
	...
		pobj =3D container_of(r, struct psb_gem_object, resource);
		if (pobj->pages) {
			psb_gtt_insert_pages(pdev, &pobj->resource, pobj->pages);
			size +=3D resource_size(&pobj->resource);
			++restored;
		}
	...
}

When the PRIME pin or vmap is later released, psb_gem_put_pages_locked()
frees pobj->pages back to the page allocator without calling
psb_gtt_remove_pages(), leaving the hardware GTT entries pointing at freed
system RAM instead of the scratch page.

> +
> +static int psb_gem_pin_locked(struct psb_gem_object *pobj)
>  {
>  	struct drm_gem_object *obj =3D &pobj->base;
>  	struct drm_device *dev =3D obj->dev;
>  	struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);
>  	u32 gpu_base =3D dev_priv->gtt.gatt_start;
> -	struct page **pages;
>  	unsigned int npages;
>  	int ret;
> =20
> -	ret =3D dma_resv_lock(obj->resv, NULL);
> -	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=3D%d\n", ret))
> -		return ret;
> +	dma_resv_assert_held(obj->resv);

[ ... ]

> -void psb_gem_unpin(struct psb_gem_object *pobj)
> +static void psb_gem_unpin_locked(struct psb_gem_object *pobj)
>  {
>  	struct drm_gem_object *obj =3D &pobj->base;
>  	struct drm_device *dev =3D obj->dev;
>  	struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);
>  	u32 gpu_base =3D dev_priv->gtt.gatt_start;
>  	unsigned long npages;
> -	int ret;
> =20
> -	ret =3D dma_resv_lock(obj->resv, NULL);
> -	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=3D%d\n", ret))
> -		return;
> +	dma_resv_assert_held(obj->resv);

[Severity: Low]
This isn't a bug, but the commit message says psb_gem_pin() and
psb_gem_unpin() are split into locked variants for the PRIME helpers.
psb_gem_prime_pin() and psb_gem_prime_unpin() call
psb_gem_get_pages_locked() and psb_gem_put_pages_locked() instead, leaving
psb_gem_pin_locked() and psb_gem_unpin_locked() with no callers other than
psb_gem_pin() and psb_gem_unpin().

[ ... ]

> +/*
> + * dma_buf_mmap() maps through the object's fake offset (drm_gem_prime_m=
map()),
> + * which a dumb buffer only gets from MAP_DUMB: make sure it has one.
> + */
> +static struct dma_buf *psb_gem_prime_export(struct drm_gem_object *obj, =
int flags)
> +{
> +	int ret;
> +
> +	ret =3D drm_gem_create_mmap_offset(obj);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	return drm_gem_prime_export(obj, flags);
> +}

[Severity: Medium]
Should psb_gem_prime_export() reject stolen-memory objects with
ERR_PTR(-EINVAL) before creating the mmap offset and exporting the
dma-buf?

A client that obtains a GEM handle to the stolen-memory fbdev framebuffer
via DRM_IOCTL_MODE_GETFB can otherwise export it through
DRM_IOCTL_PRIME_HANDLE_TO_FD, allocating a fake mmap offset and returning
a dma-buf whose attach and vmap callbacks fail with -EINVAL (triggering
WARN_ON_ONCE(ret) in dma_buf_vmap()) and whose dma_buf_mmap() faults
through the broken stolen-memory path in psb_gem_fault().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D3
