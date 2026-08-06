Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11BCC5AC7A
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 23:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35DD10E3A7;
	Thu,  6 Aug 2026 23:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G/i27jAz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A271E10E39B
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 23:10:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A5DF600B0;
 Thu,  6 Aug 2026 23:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B4D1F000E9;
 Thu,  6 Aug 2026 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786057802;
 bh=SACzGqjHKYeCjSoe/GcL4vbB6sVgQfHsc1oubzr765k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G/i27jAzHIIdEdZUmF1qnRpiSUfvTZDfnabE/cvc8TB8RpXQy7RMAAx27/fCwMBNA
 sNT8omiovSNr/GfWWnZihUydMlGofnoGvwYE5xVHgODA+FfB+heZGP0d1Ov8bc6hAF
 eCkRQdT4jRcX7aygZmdIB2FS9ydbaQLqIBjOlIZH4odghWYD7RHO5F4ajPSOZVyD8E
 V713vD7DKKGLmIZV9fMdrXCGV942STHPIQKHQ5w2dYAURyzB5FzvQwIGMO41tOmF1/
 R6A//ufAJzNBLjY7h0QF8XsjGAJz7SSCIcAuYH9lWMsZtMvQheCNTLeQ6PFOuIAdYv
 pvZEqL7JlRlnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
To: "Benjamin Leggett" <benjamin@edera.io>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 23:10:01 +0000
Message-Id: <20260806231002.27B4D1F000E9@smtp.kernel.org>
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
- [High] Missing dma_sync_sgtable_for_cpu() in guest-bound transfer paths c=
auses data corruption with SWIOTLB bounce buffers.
--

--- Patch [1]: [PATCH] drm/virtio: use the DMA API for resource backing on =
Xen ---
commit 5102ee1180b3819921a73a9ff7e4e18ce5a910f1
Author: Benjamin Leggett <benjamin@edera.io>

drm/virtio: use the DMA API for resource backing on Xen

This commit enables the use of the DMA API for virtio-gpu resource backing
on Xen PV domains, regardless of the VIRTIO_F_ACCESS_PLATFORM feature bit.
It introduces virtio_gpu_use_dma_api() and updates the resource
initialization and transfer paths to use it. This ensures that the host
receives correct DMA addresses instead of guest-physical addresses when
swiotlb is active.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index 905b1f42cd983..568fefd713e0f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c

[ ... ]

> @@ -1231,7 +1231,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virt=
io_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo =3D gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_host_3d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api =3D !virtio_has_dma_quirk(vgdev->vdev);
> +	bool use_dma_api =3D virtio_gpu_use_dma_api(vgdev->vdev);
> =20
>  	if (virtio_gpu_is_shmem(bo) && use_dma_api)
>  		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>  					    bo->base.sgt, DMA_TO_DEVICE);

[Severity: High]
This is a pre-existing issue, but while enabling the DMA API for Xen PV
domains, does this leave guest-bound transfers vulnerable to data corruption
with SWIOTLB bounce buffers?

While this patch ensures dma_sync_sgtable_for_device() is called for
host-bound transfers (DMA_TO_DEVICE), it appears that guest-bound transfers
are missing the corresponding CPU synchronization:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_transfer_from_host_3d() {
    ...
    // Missing dma_sync_sgtable_for_cpu() or
    // dma_sync_sgtable_for_device(..., DMA_FROM_DEVICE)
}

If a user-space application maps a virtio-gpu SHMEM buffer and triggers a
VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D via
DRM_IOCTL_VIRTGPU_TRANSFER_FROM_HOST, will the CPU read stale data from
the original backing pages?

Because the driver never calls dma_sync_sgtable_for_cpu() when the transfer
completes, it looks like the SWIOTLB will never copy the bounce buffer
contents back to the original physical pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-virtgpu-xe=
n-dma-v1-1-e499b345bbad@edera.io?part=3D1
