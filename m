Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EA607351C
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBef+ldf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC9A10F6A9;
	Tue, 27 Oct 2026 15:48:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBA510F5CD
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:47:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D021E60A8C;
 Tue, 27 Oct 2026 15:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6973B1F01147;
 Tue, 27 Oct 2026 15:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793116077;
 bh=kdztsirRHY2cmeIGfuJBYbtzmLZFIzGx9YQE2NB+KFs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gBef+ldfmctw4TXpJ9L3Pe9f76uBjHCHLkzIxx6I32i43+v8cOvTEMtKYkWC21prH
 cWif/0ln4XbTryx5mKi9bgQgvwb3c2CkfpfxLMZAjUWKpbVQaZXqQx3gFMoDNsQXQc
 Q4jLtnsAHGl4rmsOS6hz9cUR5TqXMjbUrUk7ufPFuewByQFHZG+NsUPOLd5t8J9ByW
 kKPurBI0p4p94xqatrmBhrF/sy/pcexLT+t/VRSeRTBX2r4pXpBdQvOP9R1t4Q0IyV
 hWGfF1lUiGtgDeirrt8axkR9st6YtVAPnBFuNdu7X+B1IDYXGn5JC7Rc4rAnnHj2Km
 pVd3vllYFaRFA==
Message-ID: <sashiko-outbox-186868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/msm/gem: dma_map/unmap_sgtable()
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027152821.51144-3-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
 <20261027152821.51144-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:47:57 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm: NULL deref in get_pages() error path via drm_prime_gem_de=
stroy()
- [High] drm/msm: double dma_map/unmap_sgtable() in get_pages() and put_pag=
es()
--

commit 5b4a3d83276519e9cb8831bdfa37a513b1d334a3
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: dma_map/unmap_sgtable()

This commit adds dma_map_sgtable() and dma_unmap_sgtable() calls in
get_pages() and put_pages() to populate the sgtable's dma_address and
dma_len fields for setting up pagetable mappings.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 181b9ad326729..72e3cd8bb1e7c 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -219,6 +219,15 @@ static struct page **get_pages(struct drm_gem_object=
 *obj)
>  			goto error;
>  		}
> =20
> +		ret =3D dma_map_sgtable(drm_dev_dma_dev(obj->dev),
> +				      msm_obj->sgt,
> +				      DMA_BIDIRECTIONAL,
> +				      DMA_ATTR_SKIP_CPU_SYNC);
> +		if (ret) {
> +			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
> +			goto error;
> +		}
> +
>  		update_device_mem(dev->dev_private, obj->size);
> =20
>  		/* For non-cached buffers, ensure the new pages are clean
> @@ -233,6 +242,8 @@ static struct page **get_pages(struct drm_gem_object =
*obj)
>  	return msm_obj->pages;
> =20
>  error:
> +	if (!IS_ERR(msm_obj->sgt))
> +		drm_prime_gem_destroy(obj, msm_obj->sgt);

[Severity: High]
Will calling drm_prime_gem_destroy() here dereference a NULL pointer and
leak msm_obj->sgt when dma_map_sgtable() fails?

At the start of get_pages(), imported DMA-BUF objects are rejected:

drivers/gpu/drm/msm/msm_gem.c:get_pages()
	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
		return ERR_PTR(-EINVAL);

Because get_pages() only runs on native GEM objects, obj->import_attach is
always NULL and msm_obj->sgt is allocated via drm_prime_pages_to_sg().

If dma_map_sgtable() fails and jumps to error, drm_prime_gem_destroy() is
called with a valid msm_obj->sgt, which then dereferences attach (NULL) at
attach->dmabuf while obj->resv is held, and fails to free msm_obj->sgt:

drivers/gpu/drm/drm_prime.c:drm_prime_gem_destroy()
	attach =3D obj->import_attach;
	if (sg)
		dma_buf_unmap_attachment_unlocked(attach, sg, DMA_BIDIRECTIONAL);
	dma_buf =3D attach->dmabuf;

Should the error path instead free msm_obj->sgt with
sg_free_table(msm_obj->sgt) and kfree(msm_obj->sgt) to match put_pages()?

>  	msm_obj->sgt =3D NULL;
> =20
>  	drm_gem_put_pages(obj, msm_obj->pages, false, false);
> @@ -260,6 +271,11 @@ static void put_pages(struct drm_gem_object *obj)
>  		if (msm_obj->flags & MSM_BO_WC)
>  			sync_for_cpu(msm_obj);
> =20
> +		dma_unmap_sgtable(drm_dev_dma_dev(obj->dev),
> +				  msm_obj->sgt,
> +				  DMA_BIDIRECTIONAL,
> +				  DMA_ATTR_SKIP_CPU_SYNC);

[Severity: High]
Does this map and unmap msm_obj->sgt twice whenever MSM_BO_WC is set?

In get_pages(), right after dma_map_sgtable() maps msm_obj->sgt with
DMA_ATTR_SKIP_CPU_SYNC, objects with MSM_BO_WC call sync_for_device():

drivers/gpu/drm/msm/msm_gem.c:get_pages()
		if (msm_obj->flags & MSM_BO_WC)
			sync_for_device(msm_obj);

And in put_pages(), before the new dma_unmap_sgtable() call, MSM_BO_WC
objects call sync_for_cpu(). However, sync_for_device() and sync_for_cpu()
themselves call dma_map_sgtable() and dma_unmap_sgtable() on the same
msm_obj->sgt and device:

drivers/gpu/drm/msm/msm_gem.c:
static void sync_for_device(struct msm_gem_object *msm_obj)
{
	struct device *dev =3D msm_obj->base.dev->dev;

	dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
}

static void sync_for_cpu(struct msm_gem_object *msm_obj)
{
	struct device *dev =3D msm_obj->base.dev->dev;

	dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
}

On platforms where the top-level DRM device uses IOMMU DMA ops or SWIOTLB,
the second dma_map_sgtable() call in sync_for_device() overwrites
sg_dma_address and sg_dma_len, leaking the first IOVA or bounce mapping,
while put_pages() unmaps and frees the second range twice. With
CONFIG_DMA_API_DEBUG enabled, this also triggers overlapping mapping and
double unmap warnings.

Should sync_for_device() and sync_for_cpu() use dma_sync_sgtable_for_device=
()
and dma_sync_sgtable_for_cpu() (or fold the CPU sync attribute into the map
and unmap calls in get_pages() and put_pages()) instead of mapping and
unmapping msm_obj->sgt a second time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027152821.5114=
4-1-robin.clark@oss.qualcomm.com?part=3D2
