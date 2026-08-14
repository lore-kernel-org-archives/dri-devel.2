Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0375FC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D38B10E5BE;
	Fri, 14 Aug 2026 21:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VCLWUbb4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417AB10E5BE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 21:37:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DECDD41923;
 Fri, 14 Aug 2026 21:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EB71F000E9;
 Fri, 14 Aug 2026 21:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786743439;
 bh=gIfa8JM3G4aEsJIzqggnjW58OlBgoTzfl70Ue6quMGo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VCLWUbb4o95ch3OAatThlaKLWt/4Zgud4js/nSht2zLQsCgPRnjjTfwM67zVOumaz
 Vw4nsG1gd184dWrDU3z3i/R3AeyNXt1YivuVaOfOksXbh8wni/QJ6pW3EI7BrOmsi/
 3+nyJg6j4FauJunid0kvk2fK5eNX4rs7990nYsiZmw1/lg9WY863ty/8QuO7j/JhPf
 qyGEBUin1uJg/lZb6ZGghX9TVpfnq+TqrtQUPsUCn7OS1dWqXUnBMgbQI4zvEsIu3K
 ysPl4F2Dcft2JcC2LblNbOJbbD3GWZCQmEKOgqmiBPMuSErOtNw+QD6+GngPlFpsnj
 gqZp1khRlUIGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: sync shmem backing on guest-bound transfers
To: "Benjamin Leggett" <benjamin@edera.io>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-virtgpu-from-host-sync-v2-1-fa3910caf3e5@edera.io>
References: <20260814-virtgpu-from-host-sync-v2-1-fa3910caf3e5@edera.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 21:37:19 +0000
Message-Id: <20260814213719.A1EB71F000E9@smtp.kernel.org>
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
- [High] Missing memory barriers around `from_host_pending` flag can cause =
`transfer_to_host` to copy stale CPU memory to the device.
--

--- Patch [1]: [PATCH v2] drm/virtio: sync shmem backing on guest-bound tra=
nsfers ---
commit 8bd4a9f3d04bef678178a45f1200ae1d1b2c8a45
Author: Benjamin Leggett <benjamin@edera.io>
Subject: drm/virtio: sync shmem backing on guest-bound transfers

This commit addresses a bug where guest-bound transfers lack CPU synchroniz=
ation,
leaving stale data in the cache or bounce buffer. It fixes this by priming =
the
mapping before queuing and syncing for the CPU upon completion.

Closes: https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.=
kernel.org/

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..a041b8e336e97 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
[ ... ]
> @@ -320,6 +339,27 @@ static int virtio_gpu_transfer_to_host_ioctl(struct =
drm_device *dev, void *data,
>  		if (ret !=3D 0)
>  			goto err_put_free;
> =20
> +		if (READ_ONCE(bo->from_host_pending)) {
[Severity: High]
Could this READ_ONCE() lead to stale data being read on weakly-ordered
architectures like ARM64?

If a weakly-ordered CPU reorders the reads from the bounce buffer or shared
memory before this flag check, it might copy stale CPU memory to the device
and destroy the data just transferred from the host.

Should this use smp_load_acquire() to ensure the CPU reads from the backing
pages only happen after observing the flag update?

> +			/*
> +			 * A transfer the other way has queued but not yet
> +			 * synced its mapping. Pushing the guest pages into it
> +			 * now would discard what the device wrote there, so
> +			 * wait for that sync: it runs before the fence it
> +			 * belongs to is signalled. The flag is only set under
> +			 * this reservation, so it cannot appear behind our
> +			 * back; a stale read merely waits for nothing.
> +			 */
> +			long wait =3D dma_resv_wait_timeout(objs->objs[0]->resv,
> +							  DMA_RESV_USAGE_WRITE,
> +							  true,
> +							  MAX_SCHEDULE_TIMEOUT);
> +
> +			if (wait < 0) {
> +				ret =3D wait;
> +				goto err_unlock;
> +			}
> +		}
> +
>  		ret =3D -ENOMEM;
>  		fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
>  					       0);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index 5e9b7b192db0f..0f5317f3da8a7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
[ ... ]
> @@ -256,6 +256,24 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct=
 *work)
>  	} while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
>  	spin_unlock(&vgdev->ctrlq.qlock);
> =20
> +	/*
> +	 * Sync guest-bound transfers before signalling anything, so that a
> +	 * waiter cannot read the backing pages while what the device wrote is
> +	 * still in a bounce buffer. This cannot be folded into the loop below:
> +	 * virtio_gpu_fence_event_process() also signals every earlier fence in
> +	 * the same context, so any entry there may signal this entry's fence.
> +	 */
> +	list_for_each_entry(entry, &reclaim_list, list) {
> +		if (entry->sync_for_cpu) {
> +			struct virtio_gpu_object *bo =3D
> +				gem_to_virtio_gpu_obj(entry->objs->objs[0]);
> +
> +			dma_sync_sgtable_for_cpu(vgdev->vdev->dev.parent,
> +						 bo->base.sgt, DMA_FROM_DEVICE);
> +			WRITE_ONCE(bo->from_host_pending, false);
[Severity: High]
Does WRITE_ONCE() properly order the flag update against the memory writes
from dma_sync_sgtable_for_cpu()?

Since dma_sync_sgtable_for_cpu() and WRITE_ONCE() do not inherently provide
CPU memory barriers, the CPU might reorder the flag store before the memory
updates are globally visible.

This would allow virtio_gpu_transfer_to_host_ioctl() in another thread to s=
ee
the flag as false, skip the wait, and push stale data to the device.

Should this be an smp_store_release() to guarantee the memory writes are
visible before the flag is cleared?

> +		}
> +	}
> +
>  	list_for_each_entry(entry, &reclaim_list, list) {
>  		resp =3D (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-virtgpu-fr=
om-host-sync-v2-1-fa3910caf3e5@edera.io?part=3D1
