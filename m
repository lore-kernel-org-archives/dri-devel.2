Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B9CC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 02:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0921510E7BD;
	Fri, 18 Sep 2026 02:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbLhuUIk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC8410E7BD
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 02:29:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7400C403CE;
 Fri, 18 Sep 2026 02:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166251F000FF;
 Fri, 18 Sep 2026 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789698556;
 bh=YeTRyMX3msQogvMnx08gdFpFGKpZvQJFgT9/pR2gkaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hbLhuUIkVc+C0Bd7/11qfDGpPJajRfaFXfZjKY5uCbPnEvTmGWvHGjgWWnNwAstui
 GL7qf0rqcsBC/leBIrpWAVME5yNNMegQ+bOSWYd3pgX3b6nM6emJsnDz4ZFBm/BK0W
 ZmeErouokSFze02fGwmhr1lnIb4lx93tx37Bp0590pXEoLkRv2sh2Altx7dYdhMJOh
 Zrz6s4ijKRiBQeu9qY0qghU3u8T6ZCQ82WDyuW17d+XgMTW0QTu5d1gmO5VMr4yfrL
 KCX3XmNbHVLSXr93O8dPbYbYOQh0K9gnUmDsEHfrf/G8S48aFyH6GYyyf8WApFWP0v
 mYdXf2azlOj/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918021154.1432154-4-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:29:15 +0000
Message-Id: <20260918022916.166251F000FF@smtp.kernel.org>
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
- [Critical] mm: silent data loss due to missing dirty tracking on unpin
- [Critical] virtgpu: privilege escalation via read-write PRIME export of r=
ead-only userptrs
- [High] virtgpu: missing DMA sync for userptr objects causes stale reads
--

commit 419406d5baa93528ec030b7b95cc7d5ada190751
Author: Honglei Huang <honghuan@amd.com>

drm/virtio: implement userptr support for zero-copy memory access

This commit implements userptr support for virtio-gpu by adding a new
virtio_gpu_object_userptr type. It pins user pages via pin_user_pages_fast()
and maps them via the DMA API when required.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/v=
irtio/virtgpu_userptr.c
> new file mode 100644
> index 0000000000000..009755489774c
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> @@ -0,0 +1,335 @@
[ ... ]
> +static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs =3D {
> +	.open =3D virtio_gpu_gem_object_open,
> +	.close =3D virtio_gpu_gem_object_close,
> +	.free =3D virtio_gpu_userptr_free,
> +	.export =3D virtgpu_gem_prime_export,
> +	.get_sg_table =3D virtio_gpu_userptr_get_sg_table,
> +};

[Severity: Critical]
Is it safe to expose these objects to the PRIME export subsystem without
verifying their read-only status?

If a userptr object is created with VIRTGPU_BLOB_FLAG_USERPTR_RDONLY to pin
read-only memory, userspace could potentially export it via PRIME with
O_RDWR permissions and import it into another device that performs DMA writ=
es.
Could this allow hardware to bypass CPU page table protections and overwrite
read-only system memory or files?

[ ... ]
> +static void
> +virtio_gpu_userptr_put_pages(struct virtio_gpu_object_userptr *userptr)
> +{
[ ... ]
> +	if (userptr->pages) {
> +		unpin_user_pages(userptr->pages, userptr->npages);
> +		kvfree(userptr->pages);
> +		userptr->pages =3D NULL;
> +	}

[Severity: Critical]
Are we missing dirty tracking when releasing these pages back to the OS?

If a userptr object is created without the read-only flag, pinned with
FOLL_WRITE, written to by the device, and then destroyed, we call
unpin_user_pages() here without explicitly marking the pages as dirty. If t=
he
pages are file-backed or swapped, could the kernel memory management subsys=
tem
silently discard the data written by the host or device?

[ ... ]
> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr)
> +{
[ ... ]
> +	/*
> +	 * Match shmem blobs: only DMA-map when the virtio DMA API is in
> +	 * use. Mapping unconditionally can create SWIOTLB bounce buffers
> +	 * that get copied back over guest pages on unmap even though the
> +	 * host was given sg_phys() addresses.
> +	 */
> +	if (virtio_gpu_use_dma_api(vgdev->vdev)) {
> +		enum dma_data_direction dir =3D
> +			(userptr->flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY) ?
> +			DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
> +
> +		ret =3D dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
> +				      dir, 0);

[Severity: High]
How does this DMA-mapped memory get synchronized to avoid stale reads?

When mapping with DMA_BIDIRECTIONAL and the guest modifies the userptr memo=
ry,
the host might read stale data from bounce buffers unless a DMA sync occurs=
.=20
However, in virtio_gpu_cmd_transfer_to_host_3d() and 2d transfers, the sync
check looks like this:

	if (virtio_gpu_is_shmem(bo) && use_dma_api)
		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
					    bo->base.sgt, DMA_TO_DEVICE);

Since virtio_gpu_is_shmem() evaluates to false for userptr objects, they
appear to be excluded from this synchronization. Will this skip cause the
host to read stale data during transfers?

> +		if (ret)
> +			goto err_cleanup;
> +
> +		userptr->dma_dir =3D dir;
> +		userptr->dma_mapped =3D true;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D3
