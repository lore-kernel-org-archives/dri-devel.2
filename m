Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65C1C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 15:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BFC10E110;
	Sun,  2 Aug 2026 15:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JUipDZ6N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390B910E110
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 15:56:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB85840B42;
 Sun,  2 Aug 2026 15:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF7B1F000E9;
 Sun,  2 Aug 2026 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785686184;
 bh=PD/W91IpcvCDrLDTD5fmEnCm8uy1LEEE1V1o0m607G0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JUipDZ6N66uAG4Zk1HgZoWPE4oNKcjx+2Ae8NVUp5URvCzDWBXoDikuxWal2+HrG8
 zp9KKFUnJihYzeAnbodt9GOaQ7PqzbZOW1FHVI5nyj25BEHzqD+8g/qrLe7vRbuTtW
 +JQKaHHpF0w3hEpObAnqzq11KVzOSDfAhJ+TdqhKT+vO8oTqUtWWgPuoyUT58OlrT+
 NeaZKa6tZC78Wr/RtAHemAJhvdkwGVr42MQwNw0IANgZXHYzHTsg+HwLFr2KubEHmc
 ADBhwTKMs+DG3+4hLGRB6ya7yrSfYRaPcqKOCm0X8VM3XIb51dF5eRc2hsTTl/2pZD
 jilcoYZkzRY7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: reclaim pending vbufs before tearing down vqs
To: "Anuj Bolewar" <bolewara@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260802-virtio-gpu-reclaim-vbufs-v1-1-9947f18b20e2@gmail.com>
References: <20260802-virtio-gpu-reclaim-vbufs-v1-1-9947f18b20e2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:56:23 +0000
Message-Id: <20260802155624.ADF7B1F000E9@smtp.kernel.org>
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

New issues:
- [High] Data race and potential Use-After-Free between `dequeue_work` and =
`virtio_gpu_reclaim_vbufs` / `del_vqs`.

Pre-existing issues:
- [High] Memory leak of GEM objects (bo) due to missing cleanup of `vbuf->r=
esp_cb_data` in `virtio_gpu_reclaim_vbufs`.
- [High] Permanent leak of `dma_fence` objects and potential infinite wait =
for stranded commands.
--

--- Patch [1]: [PATCH] drm/virtio: reclaim pending vbufs before tearing dow=
n vqs ---
commit 9dfeaad280a2a9a1d77041d3cd3a7b47ba0d4e3a
Author: Anuj Bolewar <bolewara@gmail.com>

drm/virtio: reclaim pending vbufs before tearing down vqs

This commit attempts to drain any buffers still sitting in the control and
cursor virtqueues in virtio_gpu_deinit() after the device has been reset
and before the virtqueues are deleted to prevent a cache shutdown warning.

Link: https://syzkaller.appspot.com/bug?extid=3D06f9b2a53ba4a5a47644

> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virti=
o/virtgpu_kms.c
> index b4329f28e9766..e5a6ae679f363 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -298,6 +298,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  	flush_work(&vgdev->cursorq.dequeue_work);
>  	flush_work(&vgdev->config_changed_work);
>  	virtio_reset_device(vgdev->vdev);
> +	virtio_gpu_reclaim_vbufs(vgdev);

[Severity: High]
Could a late interrupt re-queue the work after it has been flushed?

Since flush_work() is called before virtio_reset_device(), if an interrupt
arrives just after flush_work() completes but before virtio_reset_device()
is called, the worker could be re-queued.

Because virtio_reset_device() stops new interrupts but doesn't cancel
pending asynchronous work, could the rescheduled worker execute concurrently
with the newly added virtio_gpu_reclaim_vbufs() and access the virtqueue?

>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
>  }
> =20
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index e5e1af8b8e8a0..95d7a9ef0d99d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c

[ ... ]

> @@ -208,6 +208,19 @@ static void free_vbuf(struct virtio_gpu_device *vgde=
v,
>  	kmem_cache_free(vgdev->vbufs, vbuf);
>  }
> =20
> +void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
> +{
> +	struct virtio_gpu_vbuffer *vbuf;
> +
> +	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->ctrlq.vq))) {

[Severity: High]
If the dequeue_work worker is still running as mentioned above, could it
race with this lockless manipulation of the virtqueue?

The worker uses virtqueue_get_buf() under vgdev->ctrlq.qlock, but
virtqueue_detach_unused_buf() is called here without acquiring the lock.
This might lead to concurrent modification of the virtqueue internal state
or a use-after-free if the worker accesses it after the queues are deleted.

> +		if (vbuf->objs)
> +			virtio_gpu_array_put_free(vbuf->objs);

[Severity: High]
This isn't a bug introduced by this patch, but does this loop overlook
vbuf->resp_cb_data?

When the device is reset, pending VIRTIO_GPU_CMD_RESOURCE_UNREF commands are
left in the virtqueue. If they are detached and freed here without executing
their resp_cb callbacks (like virtio_gpu_cmd_unref_cb) or manually cleaning
up vbuf->resp_cb_data, does it permanently leak the underlying GEM objects
and their associated IDAs?

[Severity: High]
This is a pre-existing issue, but does this loop also silently discard
command buffers without signaling their associated fences?

When commands are queued with a fence via
virtio_gpu_queue_fenced_ctrl_buffer(), a reference to the dma_fence is added
to the vgdev->fence_drv.fences list. If virtio_gpu_reclaim_vbufs() detaches
and frees the vbufs without extracting or signaling these fences, could any
waiters hang indefinitely?

> +		free_vbuf(vgdev, vbuf);
> +	}
> +	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->cursorq.vq)))
> +		free_vbuf(vgdev, vbuf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-virtio-gpu=
-reclaim-vbufs-v1-1-9947f18b20e2@gmail.com?part=3D1
