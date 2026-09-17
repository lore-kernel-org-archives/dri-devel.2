Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65D5C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0DA10ED4D;
	Thu, 17 Sep 2026 10:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h5SUOKBQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692F910ED4D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:38:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23D3B43ACC;
 Thu, 17 Sep 2026 10:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B978E1F000FF;
 Thu, 17 Sep 2026 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789641500;
 bh=u74oRtiWCXv3HgSYW+QJ4HuHIn93ZY7JgW79VbwRUfE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h5SUOKBQspg8kB+hI0vWVKTfZf3Am6onWuFZ8MBcG36WXhXlwhM0GstMOKcFrJF8p
 LbFaxqoA1GqfOXw71fbwaiVGnWv8gon+R5w7Jww9qGHS2KnYcViJ8Ztb6Ov650D5WA
 RUuu8FZiYPYaNauZaKjBYyHHJXNWyzkE4mm5UvlVzTjhqplPktqEvClmoA5mqIru64
 8mYwPzvHYY8zxr3FQXheHMNCCy6RHy9ndArJ9zc99IZGFPddxSgrFTF3WnlMkTZLr3
 8wWdKRu6iKSmLyDVC/dn64sL4tshVj6HdHDNVsbjf9BRavGKBk5toCuSsH7+GMvktE
 fCsO/Yq0ol7YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260917102540.1312102-5-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:38:19 +0000
Message-Id: <20260917103819.B978E1F000FF@smtp.kernel.org>
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
- [Critical] drm/virtio: double-free and UAF in virtio_gpu_userptr_get_page=
s error path
- [High] drm/virtio: read-only userptr memory mapped as DMA_BIDIRECTIONAL
- [Medium] drm/virtio: silent fallback to VRAM if userptr is combined with =
HOST3D
--

commit 357076bf581ca76e53fbe71d8c16da04e304d01c
Author: Honglei Huang <Honglei1.Huang@amd.com>

drm/virtio: wire blob ioctl creation to userptr objects

Integrate userptr into the blob resource creation ioctl.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
[ ... ]
> @@ -458,6 +460,17 @@ static int verify_blob(struct virtio_gpu_device *vgd=
ev,
>  			return -EINVAL;
>  	}
> =20
> +	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_USERPTR) {
> +		if (!rc_blob->userptr)
> +			return -EINVAL;
> +	} else {
> +		if (rc_blob->userptr)
> +			return -EINVAL;
> +
> +		if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)
> +			return -EINVAL;
> +	}
> +

[Severity: Medium]
Will this silently fall back to VRAM if the user requests a userptr blob but
sets the memory type to VIRTGPU_BLOB_MEM_HOST3D?

If guest_blob is false and host3d_blob is true, the userptr flag is validat=
ed
here but it doesn't ensure a guest memory type was requested.

This could allow the execution to fall through into:

virtio_gpu_resource_create_blob_ioctl() {
    ...
    else if (!guest_blob && host3d_blob)
        ret =3D virtio_gpu_vram_create(vgdev, &params, &bo);
    ...
}

which would silently ignore params.userptr and allocate standard VRAM inste=
ad
of returning -EINVAL.

>  	switch (rc_blob->blob_mem) {
>  	case VIRTGPU_BLOB_MEM_GUEST:
[ ... ]
> @@ -538,8 +552,10 @@ static int virtio_gpu_resource_create_blob_ioctl(str=
uct drm_device *dev,
>  				      vfpriv->ctx_id, NULL, NULL);
>  	}
> =20
> -	if (guest_blob)
> +	if (guest_blob && !params.userptr)
>  		ret =3D virtio_gpu_object_create(vgdev, &params, &bo, NULL);
> +	else if (guest_blob && params.userptr)
> +		ret =3D virtio_gpu_userptr_create(vgdev, file, &params, &bo);

[Severity: Critical]
Does the error path in virtio_gpu_userptr_get_pages() lead to a use-after-f=
ree
and double-free when this is called?

If virtio_gpu_userptr_get_pages() enters the error path, it frees the pages
array but leaves a dangling pointer:

virtio_gpu_userptr_get_pages() {
    ...
    if (pinned)
        unpin_user_pages(userptr->pages, pinned);
    kvfree(userptr->pages);
    return ret;
}

The error returned to virtio_gpu_userptr_create() triggers a jump to
err_cleanup and calls virtio_gpu_cleanup_object(), which eventually calls
virtio_gpu_userptr_put_pages():

virtio_gpu_userptr_put_pages() {
    if (userptr->pages) {
        unpin_user_pages(userptr->pages, userptr->npages);
        kvfree(userptr->pages);
        userptr->pages =3D NULL;
    }
}

Because the pointer is not NULL, this would unpin and free the already freed
array, potentially corrupting page refcounts and memory.


[Severity: High]
Can a read-only userptr be overwritten by the host device?

When VIRTGPU_BLOB_FLAG_USERPTR_RDONLY is specified, the userptr memory is
pinned without FOLL_WRITE, allowing read-only memory to be pinned. However,
the DMA mapping in virtio_gpu_userptr_create() appears to be hardcoded to
bidirectional:

virtio_gpu_userptr_create() {
    ...
    ret =3D dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
                          DMA_BIDIRECTIONAL, 0);
    ...
}

Because it is mapped bidirectionally, the IOMMU allows device writes to the=
se
physical pages. Can unprivileged userspace submit command buffers that
instruct the host device to write into the blob, overwriting the read-only
guest memory? Should this use DMA_TO_DEVICE when USERPTR_RDONLY is set?

> +	else if (!guest_blob && host3d_blob)
> +		ret =3D virtio_gpu_vram_create(vgdev, &params, &bo);
>  	else
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102540.1312=
102-1-honghuan@amd.com?part=3D4
