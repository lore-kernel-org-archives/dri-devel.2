Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF4CC54FCD
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 08:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E301210E2AC;
	Sat,  1 Aug 2026 08:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wzt0wIRk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33BA10E2AC
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 08:14:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 934CC40AE5;
 Sat,  1 Aug 2026 08:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591191F00AC4;
 Sat,  1 Aug 2026 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785572084;
 bh=LhTwou3j4r+mnN6DafBKkTCizm//YFUTcr2PaCK2Yfw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wzt0wIRkBsh5gxf+nURRBXp4+VqGK/bVilJYrZgUe5FJ+rLSIKckNQ/X6Iqhdr/BK
 8DcXRH8UqttMtmwJoIARbdGdSi3Ro5MDP/CwR5zT5Bg1JeL8qKKgHCD8MEDIez7TG9
 UI6upE7SUHpaEe5byjsgwRGUwD8hqJe56Cps0DGjpnZtZFhjZwvBW1culJv0zUag6w
 z8M/Cu1G8gHJf1q0Dgi1WWQIRj4N5iZ63bZnbc2Gr3ui9W3J6tXhEMEIrfes6qPkcc
 RqCRLavvxZOow3MR2dvvRwrrAnVT1LpFnpzKnSS4CjMTTcrdQBV2rpElVLQydue5h9
 6Hoe4qS5u7oeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/virtio: release object array when device is
 unplugged
To: "Yao Kai" <yaokai34@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731092236.2262403-2-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
 <20260731092236.2262403-2-yaokai34@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:14:44 +0000
Message-Id: <20260801081444.591191F00AC4@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When `vmalloc_to_sgt()` fails in `virtio_gpu_queue_fenced_ctrl_buf=
fer()`, it returns `-ENOMEM` but leaks `vbuf`, `vbuf->data_buf`, `vbuf->obj=
s`, and leaves the `fence` unsignaled.
- [High] If `virtqueue_add_sgs()` fails in `virtio_gpu_queue_ctrl_sgs()`, t=
he error is ignored, leaving the driver in an inconsistent state and perman=
ently leaking resources.
- [High] Missing NULL check for `virtio_gpu_fence_alloc()` in `virtio_gpu_i=
nit_submit()` leads to NULL pointer dereference or permanent GEM object loc=
king.
- [High] Unsignaled `dma_fence` on the `drm_dev_enter` error path causes us=
erspace deadlock.
--

--- Patch [1]: [PATCH 1/2] drm/virtio: release object array when device is =
unplugged ---
commit 4de920e41f6ad59b54950dfcf4081b64911d0f82
Author: Yao Kai <yaokai34@huawei.com>

drm/virtio: release object array when device is unplugged

This commit addresses a memory manager warning that occurs when unbinding
virtio-gpu while fbdev damage work is active. It ensures the object array
is released before freeing a control buffer rejected by drm_dev_enter(),
preventing the GEM object from remaining alive during device release.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index e5e1af8b8e8a0..a470339b67474 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -383,6 +383,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gp=
u_device *vgdev,
>  	if (!drm_dev_enter(vgdev->ddev, &idx)) {
>  		if (fence && vbuf->objs)
>  			virtio_gpu_array_unlock_resv(vbuf->objs);
> +		virtio_gpu_array_put_free(vbuf->objs);
>  		free_vbuf(vgdev, vbuf);
>  		return -ENODEV;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but returning -ENODEV here
without signaling the fence causes issues. Since callers like
virtio_gpu_cmd_submit() return void and ignore this error, the ioctl
completes successfully and returns a sync_file fd to userspace.

Because the fence is never added to the driver's list or signaled, does
this cause userspace to hang forever waiting on it? Should we signal the
fence with an error before returning?

This is a pre-existing issue, but further down in virtio_gpu_queue_ctrl_sgs=
()
there is an unchecked error:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_queue_ctrl_sgs() {
[ ... ]
	ret =3D virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
	WARN_ON(ret);

	vbuf->seqno =3D ++vgdev->ctrlq.seqno;
[ ... ]
}

[Severity: High]
If virtqueue_add_sgs() fails (for example, due to -ENOMEM during GFP_ATOMIC
allocation), the error is warned upon but otherwise ignored. The function
proceeds to increment the sequence number and pending_commands.

Since the command is never placed in the virtqueue, does this leave the
driver in an inconsistent state and permanently leak the vbuf and GEM object
references?

This is also a pre-existing issue, but I noticed a similar problem in
virtio_gpu_queue_fenced_ctrl_buffer():

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_queue_fenced_ctrl_buffer() {
[ ... ]
			sgt =3D vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
					     &sg_ents);
			if (!sgt) {
				if (fence && vbuf->objs)
					virtio_gpu_array_unlock_resv(vbuf->objs);
				return -ENOMEM;
			}
[ ... ]
}

[Severity: High]
When vmalloc_to_sgt() fails, it returns -ENOMEM. Does this leak vbuf,
vbuf->data_buf, and vbuf->objs since free_vbuf() and
virtio_gpu_array_put_free() are not called?

Additionally, since the caller virtio_gpu_cmd_submit() ignores the return
value, the fence remains unsignaled. Can this cause userspace processes
waiting on the fence to deadlock?

Lastly, this is a pre-existing issue, but looking at virtio_gpu_init_submit=
():

drivers/gpu/drm/virtio/virtgpu_submit.c:virtio_gpu_init_submit() {
[ ... ]
	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
	    exbuf->num_out_syncobjs ||
	    exbuf->num_bo_handles ||
	    drm_fence_event)
		out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
	else
		out_fence =3D NULL;

	if (drm_fence_event) {
		err =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
[ ... ]
}

[Severity: High]
virtio_gpu_fence_alloc() can return NULL under memory pressure. If
drm_fence_event is true, out_fence is passed to
virtio_gpu_fence_event_create() which unconditionally dereferences it:

drivers/gpu/drm/virtio/virtgpu_submit.c:virtio_gpu_fence_event_create() {
[ ... ]
	ret =3D drm_event_reserve_init(dev, file, &e->base, &e->event);
	if (ret) {
		kfree(e);
		return ret;
	}

	fence->e =3D e;
[ ... ]
}

Does this cause a NULL pointer dereference?

Alternatively, if drm_fence_event is false but num_bo_handles > 0, the code
proceeds with a NULL out_fence. When submitted, virtio_gpu_queue_ctrl_sgs()
skips unlocking vbuf->objs because fence is NULL, which appears to leave the
GEM objects locked indefinitely. Should virtio_gpu_init_submit() check for
allocation failure here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731092236.2262=
403-1-yaokai34@huawei.com?part=3D1
