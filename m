Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED08606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fyw54Sg+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7922910E9B3;
	Fri,  6 Nov 2026 08:45:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EB411281F
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:45:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 831CA40DEB;
 Fri,  6 Nov 2026 08:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE4B1F0089F;
 Fri,  6 Nov 2026 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793954727;
 bh=3fGx44LK8Xg2h7S66g4T2ycdSwPn484L7XRsxFEgyzY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fyw54Sg+HE3Xi4SsVKT17zACIpgdZqV99SlELnEwSe5P2FkEhU3/XTa5OHVhF/c/I
 TspXfA9Ioyz5pAKPZZWZqtHM+EOC0XZ7kuJ4XX99qvGpV5s6m6dWk0kB7Vc0L113SQ
 69b4Lgt7aAWj5i1I4INbPGOvC8TW5WrYGq/6+E677fcPCjcBpIFDqZt/1ENPMVhYfU
 1Y9lvNjZWdWdwTl8C3zSrvDbOoCwJpj1viwtdLFKYdZ8HR2brtGmXdHDG+HgUprqrG
 8tdvHm+rk98/B1SZVjpQqKII2miBD+WFnttOKZdKl9jyNhbMrzP69Nv7FzlQ+K0zZe
 NgPRF3k68yWVw==
Message-ID: <sashiko-outbox-201087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v10 3/4] drm/virtio: implement userptr resource support
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261106082625.812860-4-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:45:26 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/virtio: virtio_gpu_userptr_restore() skips DMA remap
  after failed map
- [Low] drm/virtio: duplicated virtio_gpu_userptr_free() and dead
  userptr struct fields
--

commit a322ca4c583b559738cbbb3a5e62c08918a07dd8
Author: Honglei Huang <honghuan@amd.com>

drm/virtio: implement userptr resource support

This commit adds virtio_gpu_object_userptr so the guest kernel can pin an
existing userspace mapping with FOLL_LONGTERM and pass its backing pages to
the host via VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB, including hibernation
restore support.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virti=
o/virtgpu_drv.h
> index 9df4c7117341e..a29429b41561f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
[ ... ]
> @@ -138,12 +139,42 @@ struct virtio_gpu_object_vram {
>  	struct drm_mm_node vram_node;
>  };
> =20
> +struct virtio_gpu_object_userptr;
> +
> +struct virtio_gpu_object_userptr_ops {
> +	int (*get_pages)(struct virtio_gpu_object_userptr *userptr);
> +	void (*put_pages)(struct virtio_gpu_object_userptr *userptr);
> +};
> +
> +struct virtio_gpu_object_userptr {
> +	struct virtio_gpu_object base;
> +	const struct virtio_gpu_object_userptr_ops *ops;
> +	/* Protects @pages, @sgt and @dma_mapped. */
> +	struct mutex lock;
> +
> +	uint64_t start;
> +	uint32_t npages;
> +	uint32_t bo_handle;
> +	uint32_t flags;
> +
> +	struct virtio_gpu_device *vgdev;
> +	struct drm_file *file;
> +	struct page **pages;
> +	struct sg_table *sgt;
> +	bool dma_mapped;
> +	enum dma_data_direction dma_dir;
> +	struct mm_struct *mm;
> +};
[ ... ]
> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/v=
irtio/virtgpu_userptr.c
> new file mode 100644
> index 0000000000000..b8606932550eb
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> @@ -0,0 +1,350 @@
[ ... ]
> +static void virtio_gpu_userptr_free(struct drm_gem_object *obj)
> +{
> +	struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(obj);
> +	struct virtio_gpu_device *vgdev =3D obj->dev->dev_private;
> +
> +	/*
> +	 * Pages stay pinned until RESOURCE_UNREF finishes. Its callback
> +	 * calls virtio_gpu_cleanup_object to drop them.
> +	 */
> +	if (bo->created) {
> +		virtio_gpu_remove_from_restore_list(bo);
> +		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
> +		virtio_gpu_notify(vgdev);
> +		return;
> +	}
> +
> +	virtio_gpu_cleanup_object(bo);
> +}

[Severity: Low]
This isn't a bug, but virtio_gpu_userptr_free() is identical to
virtio_gpu_free_object() in drivers/gpu/drm/virtio/virtgpu_object.c and
could reuse it directly if exported.

In struct virtio_gpu_object_userptr, bo_handle is never used and file is
only written in virtio_gpu_userptr_init() and never read (leaving an
unreferenced struct drm_file pointer on an object that can outlive the file
descriptor until RESOURCE_UNREF finishes).  Also,
struct virtio_gpu_object_userptr_ops has only one static implementation, so
virtio_gpu_userptr_get_pages() and virtio_gpu_userptr_put_pages() can be
called directly without the ops vtable.

[ ... ]

> +static int
> +virtio_gpu_userptr_get_entries(struct virtio_gpu_device *vgdev,
> +			       struct virtio_gpu_object_userptr *userptr,
> +			       struct virtio_gpu_mem_entry **ents,
> +			       unsigned int *nents)
> +{
> +	bool use_dma_api =3D virtio_gpu_use_dma_api(vgdev->vdev);
> +	struct scatterlist *sg;
> +	unsigned int count;
> +	int si;
> +
> +	count =3D use_dma_api ? userptr->sgt->nents : userptr->sgt->orig_nents;
> +	if (!count)
> +		return -EINVAL;
> +
> +	*ents =3D kvmalloc_array(count, sizeof(**ents), GFP_KERNEL);
> +	if (!*ents)
> +		return -ENOMEM;
> +
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
> +
> +	*nents =3D count;
> +	return 0;
> +}
> +
> +int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
> +			       struct virtio_gpu_object *bo,
> +			       struct virtio_gpu_mem_entry **ents,
> +			       unsigned int *nents)
> +{
> +	struct virtio_gpu_object_userptr *userptr =3D to_virtio_gpu_userptr(bo);
> +	int ret;
> +
> +	mutex_lock(&userptr->lock);
> +	if (!userptr->sgt || !userptr->pages) {
> +		mutex_unlock(&userptr->lock);
> +		return -EINVAL;
> +	}
> +
> +	if (userptr->dma_mapped) {
> +		struct device *dev =3D drm_dev_dma_dev(vgdev->ddev);
> +
> +		dma_unmap_sgtable(dev, userptr->sgt, userptr->dma_dir,
> +				  DMA_ATTR_REQUIRE_COHERENT);
> +		userptr->dma_mapped =3D false;
> +
> +		ret =3D dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir,
> +				      DMA_ATTR_REQUIRE_COHERENT);
> +		if (ret) {
> +			mutex_unlock(&userptr->lock);
> +			return ret;
> +		}
> +		userptr->dma_mapped =3D true;
> +	}
> +
> +	ret =3D virtio_gpu_userptr_get_entries(vgdev, userptr, ents, nents);
> +	mutex_unlock(&userptr->lock);
> +	return ret;
> +}

[Severity: Medium]
If dma_map_sgtable() fails in virtio_gpu_userptr_restore(), will a later
restore attempt send unmapped DMA addresses to the host?

When dma_map_sgtable() fails after dma_unmap_sgtable(), userptr->dma_mapped
is left false while userptr->sgt->nents remains non-zero and the object
stays on vgdev->obj_restore_list.  A subsequent virtio_gpu_userptr_restore()
call then skips remapping because userptr->dma_mapped is false, but
virtio_gpu_userptr_get_entries() checks virtio_gpu_use_dma_api(vgdev->vdev)
and reads the unmapped sg_dma_address(sg) entries anyway.

Checking virtio_gpu_use_dma_api(vgdev->vdev) to decide whether
dma_map_sgtable() is needed, and only checking userptr->dma_mapped before
calling dma_unmap_sgtable(), would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106082625.8128=
60-1-honghuan@amd.com?part=3D3
