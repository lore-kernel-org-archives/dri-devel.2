Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC9C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 17:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB8310E0AC;
	Sun,  2 Aug 2026 17:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqqsqdS8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D1710E0AC
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 17:08:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02AE5407D9;
 Sun,  2 Aug 2026 17:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEEA1F000E9;
 Sun,  2 Aug 2026 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785690520;
 bh=2HSn8jOuqhJ/2UQ49YdSmDw0Kcz0ojAzIGa6qLfgCQQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fqqsqdS8gI5VSYlHQHcHRS8pvqb4GzqtPyVDEOYuvwDSB56FJM12NLD7TFWnlJdX4
 A6JOBc9D1gM2tn8RjA0Qn38j7eBQCbWjI1gXz5Xvq0AKXX+rLVNenttWEWysouPfKM
 87QX8MdpqLuZ8oQW2tT5+uF8WlPTROjJc8mL+Zb2pT0TDky2wPccEi2cRiYQFTVUQ/
 1XEh59xvOATBjNJ8WRp81jZp0FU0mUz42p6EfRjgY7yvxTpjJe5RbsOTCht/pne/2k
 MWsAK3rNRPkpYFi/hFm9bZhOufkHyKEHPWtwWvwYu17TM3czggHK3FdPhB7+TPt9Bl
 q0R+Td8LcGYfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: reclaim pending vbufs before tearing
 down vqs
To: "Anuj Bolewar" <bolewara@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260802-virtio-gpu-reclaim-vbufs-v2-1-5767fb860691@gmail.com>
References: <20260802-virtio-gpu-reclaim-vbufs-v2-1-5767fb860691@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 17:08:40 +0000
Message-Id: <20260802170840.AFEEA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Concurrent execution of workqueue and virtio_gpu_reclaim_vbufs cau=
ses data races and potential use-after-free.

Pre-existing issues:
- [High] Tasks waiting on vgdev->resp_wq hang forever because stranded vbuf=
s are not responded to.
- [High] Incorrect flush order in virtio_gpu_deinit() can cause vgdev->obj_=
free_work to execute after driver unload.
- [High] Fences associated with pending commands are never signaled or remo=
ved from the fence_drv.fences list on teardown.
- [High] OOM during fence allocation or SG table mapping leaves BOs locked =
indefinitely and leaks command buffers.
--

--- Patch [1]: [PATCH v2] drm/virtio: reclaim pending vbufs before tearing =
down vqs ---
commit deb7b9f45646f92497e6f83adda8ac1c7224985d
Author: Anuj Bolewar <bolewara@gmail.com>

drm/virtio: reclaim pending vbufs before tearing down vqs

virtio_gpu_free_vbufs() destroys the vbufs kmem_cache after the virtqueues
have already been released. Commands that were queued but never completed
by the device leave their vbuffers stranded in the virtqueue, so the cache
still holds live objects when virtio_gpu_deinit() tears everything down.

Link: https://syzkaller.appspot.com/bug?extid=3D06f9b2a53ba4a5a47644

> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -292,10 +292,11 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  {
>  	struct virtio_gpu_device *vgdev =3D dev->dev_private;
> =20
>  	flush_work(&vgdev->obj_free_work);
>  	flush_work(&vgdev->ctrlq.dequeue_work);

[Severity: High]
This is a pre-existing issue, but does this flush order allow
obj_free_work to execute after driver unload?

If dequeue_work runs and processes command completions, it calls
virtio_gpu_array_put_free_delayed() which can schedule new obj_free_work.

Since obj_free_work is flushed first, any new work queued during the
dequeue_work flush will never be waited upon. This delayed work can then
execute after the device is freed, potentially causing a use-after-free on
vgdev->obj_free_lock.

>  	flush_work(&vgdev->cursorq.dequeue_work);
>  	flush_work(&vgdev->config_changed_work);
>  	virtio_reset_device(vgdev->vdev);
> +	virtio_gpu_reclaim_vbufs(vgdev);

[Severity: High]
Could this lead to concurrent execution of dequeue_work and
virtio_gpu_reclaim_vbufs()?

Because flush_work() is called before virtio_reset_device(), if a device
interrupt fires in the window after the flush but before the reset,
dequeue_work could be rescheduled.=20

virtio_gpu_reclaim_vbufs() then executes and locklessly calls
virtqueue_detach_unused_buf(). If dequeue_work executes concurrently, it
takes vgdev->ctrlq.qlock and operates on the same virtqueue. This might
cause a data race corrupting the virtqueue or a use-after-free if it
accesses it after del_vqs().

>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
>  }

> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
[ ... ]
> +void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
> +{
> +	struct virtio_gpu_vbuffer *vbuf;
> +
> +	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->ctrlq.vq))) {
> +		if (vbuf->objs)
> +			virtio_gpu_array_put_free(vbuf->objs);
> +		if (vbuf->resp_cb_data)
> +			virtio_gpu_cleanup_object(vbuf->resp_cb_data);
> +		free_vbuf(vgdev, vbuf);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but could tasks waiting on
vgdev->resp_wq hang forever because stranded vbufs are not responded to?

The loop manually cleans up objs and resp_cb_data but does not invoke
vbuf->resp_cb or wake up vgdev->resp_wq.

For example, in virtgpu_virtio_get_uuid():

    wait_event(vgdev->resp_wq, bo->uuid_state !=3D STATE_INITIALIZING);

A task waiting here will never be woken up if the device is removed and
the stranded UUID command is reclaimed without calling the response callbac=
k.

[Severity: High]
This is also a pre-existing issue, but are fences associated with pending
commands left unsignaled and leaked on teardown?

When commands are queued, virtio_gpu_fence_emit() adds the fence:

    list_add_tail(&fence->node, &drv->fences);

This reclaim loop frees the command buffers but completely ignores the fenc=
es.
Does this leave the fences permanently in the driver's list, causing
memory leaks and indefinite hangs for any userspace tasks waiting on them?

> +	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->cursorq.vq)))
> +		free_vbuf(vgdev, vbuf);
> +}

> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
[ ... ]
>  		out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
>  	else
>  		out_fence =3D NULL;
> =20
>  	if (drm_fence_event) {
>  		err =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);

[Severity: High]
This is a pre-existing issue, but can an OOM during fence allocation leave
buffer objects locked indefinitely?

If virtio_gpu_fence_alloc() fails and returns NULL, it proceeds without
checking the error. If drm_fence_event is true, it passes the NULL out_fence
to virtio_gpu_fence_event_create(), causing a NULL pointer dereference.

Otherwise, it locks BOs but later in virtio_gpu_queue_ctrl_sgs():

    if (fence) {
        virtio_gpu_fence_emit(vgdev, virtio_gpu_vbuf_ctrl_hdr(vbuf),
                              fence);
        if (vbuf->objs) {
            virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
            virtio_gpu_array_unlock_resv(vbuf->objs);
        }
    }

Because the fence allocation failed and fence is NULL, the BOs are never
unlocked, causing a permanent deadlock on the next access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-virtio-gpu=
-reclaim-vbufs-v2-1-5767fb860691@gmail.com?part=3D1
