Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4EEC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3147B10ED37;
	Thu, 17 Sep 2026 10:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hna2aaPI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735B410ED37
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:38:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CDA0600D4;
 Thu, 17 Sep 2026 10:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83911F000FF;
 Thu, 17 Sep 2026 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789641489;
 bh=9qTsxEj3Um15bf5hTLhvTnNr14o866YJtkfn25RWeOc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hna2aaPIjQzAuM3nCq4Cu5DB9cZOxA8BMRawRE09KaE8qRPG9Nj4Bwmo6NkoAuQxR
 cAr+OFOrXhgkCUti8aPtbYnoD/QvvIig9t1GNLlukJRxIGGpPgE2T7+U5i26GaacJK
 FsgqHf6+ifz5LctuaHzhW0yQAdAB3NGF7ztp3Agqmu5mwkOqVRVeItgu7E5NOM+U93
 KmjYnlr6KWZcSS8jheKsBqI5KSQVyMsUy3SkeA8vVrm4KkXWa632Y6n+t8CjFF1ki7
 lSbZXyNsBVP4XZncdQS3PQrnTglW9HFyeMwIAOTiETmyAbolK/8mI5DXQBxKzTyEVt
 PUo07sLzCP7ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260917102540.1312102-4-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:38:08 +0000
Message-Id: <20260917103808.E83911F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] drm/virtio: missing pointer clear in virtio_gpu_userptr_get_pa=
ges()
- [Critical] drm/virtio: unconditional dma_map_sgtable() causes data corrup=
tion
--

commit 6e836cf8f7dd384050e500d6dbf47a69c2767c26
Author: Honglei Huang <Honglei1.Huang@amd.com>
Subject: drm/virtio: implement userptr support for zero-copy memory access

This commit adds userptr blob objects so the guest kernel can pin an existi=
ng
userspace mapping and advertise it as CREATE_BLOB backing entries. It pins
pages using pin_user_pages_fast() and maps the scatterlist for the device.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/v=
irtio/virtgpu_userptr.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> @@ -0,0 +1,323 @@
[ ... ]
> +static int
> +virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
> +{
[ ... ]
> +		ret =3D pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
> +					  num_pages, flag,
> +					  userptr->pages + pinned);
> +
> +		if (ret < 0) {
> +			if (pinned)
> +				unpin_user_pages(userptr->pages, pinned);
> +			kvfree(userptr->pages);
> +			return ret;
> +		}

[Severity: Critical]
Does this error path leave a dangling pointer? The userptr->pages array is
freed here but not set to NULL.

If pin_user_pages_fast() fails, this bubbles up to virtio_gpu_userptr_creat=
e()=20
which jumps to err_cleanup and calls virtio_gpu_cleanup_object(). That
function ultimately invokes virtio_gpu_userptr_put_pages():

	if (userptr->pages) {
		unpin_user_pages(userptr->pages, userptr->npages);
		kvfree(userptr->pages);
		userptr->pages =3D NULL;
	}

Because userptr->pages wasn't cleared, won't this result in a use-after-free
and double-free when the cleanup function executes?

[ ... ]
> +static int
> +virtio_gpu_userptr_get_entries(struct virtio_gpu_device *vgdev,
> +			       struct virtio_gpu_object_userptr *userptr,
> +			       struct virtio_gpu_mem_entry **ents,
> +			       unsigned int *nents)
> +{
> +	bool use_dma_api =3D virtio_gpu_use_dma_api(vgdev->vdev);
[ ... ]
> +	if (use_dma_api) {
> +		for_each_sgtable_dma_sg(userptr->sgt, sg, si) {
> +			(*ents)[si].addr =3D cpu_to_le64(sg_dma_address(sg));
> +			(*ents)[si].length =3D cpu_to_le32(sg_dma_len(sg));
> +			(*ents)[si].padding =3D 0;
> +		}
> +	} else {
> +		for_each_sgtable_sg(userptr->sgt, sg, si) {
> +			(*ents)[si].addr =3D cpu_to_le64(sg_phys(sg));
> +			(*ents)[si].length =3D cpu_to_le32(sg->length);
> +			(*ents)[si].padding =3D 0;
> +		}
> +	}
[ ... ]
> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr)
> +{
[ ... ]
> +	sgt =3D drm_prime_pages_to_sg(vgdev->ddev, userptr->pages,
> +				    userptr->npages);
> +	if (IS_ERR(sgt)) {
> +		ret =3D PTR_ERR(sgt);
> +		goto err_cleanup;
> +	}
> +
> +	ret =3D dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
> +			      DMA_BIDIRECTIONAL, 0);

[Severity: Critical]
Can this unconditional DMA mapping cause silent data corruption?

If the system uses SWIOTLB bounce buffers and the device is configured to
bypass the DMA API, the dma_map_sgtable() call will allocate a bounce buffe=
r.

Later in virtio_gpu_userptr_get_entries(), the code branches based on
virtio_gpu_use_dma_api(), and if false it ignores the DMA address and passes
the raw physical address (sg_phys) to the device.

Since the raw physical address is passed to the device when DMA is bypassed,
the device will write directly to the original physical memory. However,
during cleanup, dma_unmap_sgtable() with DMA_BIDIRECTIONAL will copy the
unmodified bounce buffer back over the original memory. Will this overwrite
and destroy the data written by the device?

> +	if (ret) {
> +		sg_free_table(sgt);
> +		kfree(sgt);
> +		goto err_cleanup;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102540.1312=
102-1-honghuan@amd.com?part=3D3
