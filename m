Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A85606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTJk+ArN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328EA10F8AB;
	Tue, 27 Oct 2026 23:24:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2529F10F8C5
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:24:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68DC9600C8;
 Tue, 27 Oct 2026 23:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0163D1F01825;
 Tue, 27 Oct 2026 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793143472;
 bh=CZKIw0dojf3t3xPnWe1cEhW2hshBITFEjzke6gVN4MY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=iTJk+ArNJDUXTLpId66G7/nAvSOwm9lHIFsqk5yLbsP6rBovOVStls4iiRIC0tpTU
 nU2PHT/uZZzUto/OUgR40fMm20SJtDIvNQ1frm0z6dkYYHHGTegs4d5m3tuj8LMT3V
 2qzKnHqbf3BRbdLNL3lfIqu1ZmbbJcwH3ssHtxTCeTMQWOIumxK+DEZqgyo9WnhdPG
 i1sgzz3M+nfNMn85fVmnqR02xlb0yD/ho+icxazjdBzrhaKWw8K7ZMxr8J0noQHqRk
 MCF9wWh7b2GcczUdf6zrEX1LplLLObfrKh3R82uTqScG3kS4qycBPekuOthKTCTWXB
 69eM+gZX/M8uQ==
Message-ID: <sashiko-outbox-187205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] drm/msm/gem: dma_map/unmap_sgtable()
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261027230452.130031-3-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:24:31 +0000
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
- [High] drm/msm: NULL pointer dereference in get_pages() on dma_map_sgtabl=
e() error
- [High] drm/msm/gem: dma_map_sgtable() maps via iommu-dma when ddev->dev h=
as iommus
--

commit 4102c003f615c93e1ee62bff745ef3edfcbebd16
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: dma_map/unmap_sgtable()

This commit replaces the cache sync helpers in msm_gem with unconditional
dma_map_sgtable() and dma_unmap_sgtable() calls in get_pages() and
put_pages() to populate scatterlist dma addresses and lengths. It also adds
sgtable cleanup to the error path in get_pages().

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 181b9ad326729..c97395e4ea2be 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c

[ ... ]

> @@ -219,13 +192,20 @@ static struct page **get_pages(struct drm_gem_objec=
t *obj)
>  			goto error;
>  		}
> =20
> -		update_device_mem(dev->dev_private, obj->size);
> -
> -		/* For non-cached buffers, ensure the new pages are clean
> -		 * because display controller, GPU, etc. are not coherent:
> -		 */
> +		/* For non-cached buffers, ensure the new pages are clean. */
>  		if (msm_obj->flags & MSM_BO_WC)
> -			sync_for_device(msm_obj);
> +			map_attrs =3D 0;
> +
> +		ret =3D dma_map_sgtable(drm_dev_dma_dev(obj->dev),
> +				      msm_obj->sgt,
> +				      DMA_BIDIRECTIONAL,
> +				      map_attrs);

[Severity: High]
Does calling dma_map_sgtable() on drm_dev_dma_dev(obj->dev) always take the
dma-direct path when dma_map_ops is null?

In kernel/dma/mapping.c:dma_go_direct(), use_dma_iommu(dev) is checked befo=
re
testing whether ops is null:

kernel/dma/mapping.c:dma_go_direct() {
	if (use_dma_iommu(dev))
		return false;

	if (likely(!ops))
		return true;
    ...
}

On platforms where the iommus property in device tree is attached directly =
to
the mdp device (obj->dev->dev) rather than the parent mdss node (as handled
in drivers/gpu/drm/msm/msm_kms.c:msm_kms_init_vm() when checking
device_iommu_mapped(mdp_dev)), such as qcom_iommu platforms (msm8916,
msm8939, msm8953, etc.) and qcom,mdp5 arm-smmu-qcom platforms (msm8996,
sdm630, sdm660) that are not matched in qcom_smmu_client_of_match[], the
iommu core allocates a default dma domain and sets DEV_FLAG_DMA_IOMMU on
obj->dev->dev.

When msm_iommu_new() later attaches an unmanaged domain via
iommu_attach_device(), DEV_FLAG_DMA_IOMMU and group->default_domain remain =
on
the device. As a result, get_pages() -> dma_map_sgtable() ->
__dma_map_sg_attrs() -> iommu_dma_map_sg() maps every buffer into the unused
default_domain and populates sg_dma_address(sg) with default_domain dma
addresses instead of physical addresses.

When paired with the subsequent change in this series ("drm/msm: Convert map
helper to use dma-address") where __do_map() passes sg_dma_address(sg) as t=
he
physical address to pgtable->map(), won't this program the gpu and display
page tables with default_domain dma addresses instead of cpu physical
addresses on those platforms?

> +		if (ret) {
> +			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
> +			goto error;
> +		}
> +
> +		update_device_mem(dev->dev_private, obj->size);
> =20
>  		update_lru(obj);
>  	}
> @@ -233,6 +213,8 @@ static struct page **get_pages(struct drm_gem_object =
*obj)
>  	return msm_obj->pages;
> =20
>  error:
> +	if (!IS_ERR(msm_obj->sgt))
> +		drm_prime_gem_destroy(obj, msm_obj->sgt);

[Severity: High]
Will calling drm_prime_gem_destroy() in the get_pages() error path cause a
null pointer dereference and leak msm_obj->sgt when dma_map_sgtable() fails?

At the start of drivers/gpu/drm/msm/msm_gem.c:get_pages(), imported objects
are rejected:

	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
		return ERR_PTR(-EINVAL);

so obj->import_attach is always null here, and msm_obj->sgt is allocated via
drm_prime_pages_to_sg().

If dma_map_sgtable() fails and jumps to error, drm_prime_gem_destroy() is
called with a valid msm_obj->sgt pointer on a non-imported object:

drivers/gpu/drm/drm_prime.c:drm_prime_gem_destroy() {
	struct dma_buf_attachment *attach;
	struct dma_buf *dma_buf;

	attach =3D obj->import_attach;
	if (sg)
		dma_buf_unmap_attachment_unlocked(attach, sg, DMA_BIDIRECTIONAL);
	dma_buf =3D attach->dmabuf;
    ...
}

Since attach is null, dma_buf_unmap_attachment_unlocked() triggers a warning
and attach->dmabuf dereferences a null pointer while leaving msm_obj->sgt
unfreed. Should this error path free msm_obj->sgt using sg_free_table() and
kfree() as done in put_pages()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027230452.1300=
31-1-robin.clark@oss.qualcomm.com?part=3D2
