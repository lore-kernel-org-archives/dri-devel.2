Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4D60AF7B7
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq/+p+Zo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD43910E9BD;
	Mon, 19 Oct 2026 15:25:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB27310E9BD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:24:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63CE260261;
 Mon, 19 Oct 2026 15:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6261F000C4;
 Mon, 19 Oct 2026 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423495;
 bh=X905O/sVCuXAq8YUKXHLGTHNISrV2dMn60BYlnfftOU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pq/+p+ZoHtVY6nX5mtDvjZ+6vwwSo9kP1Nq50S/x2YfA5Au+aj0fgbXW5rUJkC/Um
 VP7eAQAQSpcMR7uVn4zJmrB6XrIo9h3Mdvzjqi262lS/AjecL57xkoeGedDvyLKOT5
 qubBLQQMeO4uczcRUqHb/8Zr9y+040jiSnGHwGBlVwKXPqjATT/KQks4s1qftDZioM
 Ujxc7du/q4kCxvcTj4DJRHigCYla/oz7Ka4gWlDE6u2g7SAjCRh2GwhbT5Ax0y0r1K
 rQhY2yadoyWPno1IFYGy93/GZ6N7dV5ANxEgnfWHlaKgvIIQGTO9WWB7NTkEmaizEm
 o7x2yvKd70lPA==
Message-ID: <sashiko-outbox-177715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/virtio: abort virtqueue wait on device
 removal to avoid hung task
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-417-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-417-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:24:54 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/virtio: un-emitted fence on abort in virtio_gpu_queue_ctrl_sgs=
()
- [Medium] drm/virtio: leak of vbuf->objs on abort in virtio_gpu_queue_ctrl=
_sgs()
- [Medium] drm/virtio: unreclaimed vbufs in virtio_gpu_deinit() on device r=
emoval
--

commit 81841bb63e995940f01c6fe877305de441ff0e80
Author: Ryosuke Yasuoka <ryasuoka@redhat.com>

drm/virtio: abort virtqueue wait on device removal to avoid hung task

This commit adds a vqs_released flag to struct virtio_gpu_device and wakes
up the control and cursor virtqueue wait queues during virtio_gpu_remove()
and virtio_gpu_shutdown() so that threads waiting for virtqueue space exit
their drm_dev_enter() critical sections and unblock drm_dev_unplug().

Link: https://patch.msgid.link/20260601-virtio-gpu_wait_event-v3-1-89530517=
a98a@redhat.com

> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virti=
o/virtgpu_drv.c
> index d9556e1b67b10..78cc388b434d9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -118,10 +118,24 @@ static int virtio_gpu_probe(struct virtio_device *v=
dev)
>  	return ret;
>  }
> =20
> +/*
> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu(=
).
> + */
> +static void virtio_gpu_release_vqs(struct drm_device *dev)
> +{
> +	struct virtio_gpu_device *vgdev =3D dev->dev_private;
> +
> +	vgdev->vqs_released =3D true;
> +	wake_up_all(&vgdev->ctrlq.ack_queue);
> +	wake_up_all(&vgdev->cursorq.ack_queue);
> +}
> +
>  static void virtio_gpu_remove(struct virtio_device *vdev)
>  {
>  	struct drm_device *dev =3D vdev->priv;
> =20
> +	virtio_gpu_release_vqs(dev);
>  	drm_dev_unplug(dev);
> =20
>  	if (drm_core_check_feature(dev, DRIVER_ATOMIC))

[Severity: Medium]
When virtio_gpu_release_vqs() wakes a thread blocked on a full virtqueue,
the virtqueue itself still contains all of the previously queued
struct virtio_gpu_vbuffer entries that the host stopped processing.

Once drm_dev_unplug() unblocks, virtio_gpu_remove() proceeds to
virtio_gpu_deinit() and drm_dev_put() -> virtio_gpu_release():

drivers/gpu/drm/virtio/virtgpu_kms.c:virtio_gpu_deinit() {
	flush_work(&vgdev->obj_free_work);
	flush_work(&vgdev->ctrlq.dequeue_work);
	flush_work(&vgdev->cursorq.dequeue_work);
	flush_work(&vgdev->config_changed_work);
	virtio_reset_device(vgdev->vdev);
	vgdev->vdev->config->del_vqs(vgdev->vdev);
}

drivers/gpu/drm/virtio/virtgpu_kms.c:virtio_gpu_release() {
	...
	virtio_gpu_modeset_fini(vgdev);
	virtio_gpu_free_vbufs(vgdev);
	...
}

Because flush_work() on dequeue_work only reclaims buffers that the host
placed into the used ring via virtqueue_get_buf(), the unconsumed vbufs
left in ctrlq.vq and cursorq.vq are never detached via
virtqueue_detach_unused_buf() and freed before del_vqs() and
virtio_gpu_free_vbufs() -> kmem_cache_destroy(vgdev->vbufs).

Will this leak those in-flight vbufs (along with their resp_buf, data_buf,
and vbuf->objs references) and trigger a "Objects remaining on
__kmem_cache_shutdown()" warning in kmem_cache_destroy()?

[ ... ]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index 592ad4f9b100d..244a791ab915e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -422,7 +422,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_g=
pu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >=3D elemcnt);
> +		wait_event(vgdev->ctrlq.ack_queue,
> +			   vq->num_free >=3D elemcnt || vgdev->vqs_released);
> +		/*
> +		 * Set by virtio_gpu_release_vqs() to unblock
> +		 * synchronize_srcu() wait in drm_dev_unplug().
> +		 */
> +		if (vgdev->vqs_released) {
> +			if (fence && vbuf->objs)
> +				virtio_gpu_array_unlock_resv(vbuf->objs);
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return -ENODEV;
> +		}
>  		goto again;
>  	}

[Severity: Medium]
Does this abort path leak vbuf->objs and the GEM object references it
holds?

Callers that attach a struct virtio_gpu_object_array to vbuf->objs (such
as virtio_gpu_cmd_submit(), virtio_gpu_cmd_transfer_to_host_2d(),
virtio_gpu_cmd_transfer_to_host_3d(), virtio_gpu_cmd_resource_flush(), and
virtio_gpu_cmd_create_resource()) transfer ownership of objs to the vbuf
and ignore the return value of virtio_gpu_queue_fenced_ctrl_buffer() and
virtio_gpu_queue_ctrl_buffer().

On normal completion in virtio_gpu_dequeue_ctrl_func(), vbuf->objs is
released before free_vbuf():

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_dequeue_ctrl_func() {
	...
	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
		if (entry->objs)
			virtio_gpu_array_put_free_delayed(vgdev, entry->objs);
		list_del(&entry->list);
		free_vbuf(vgdev, entry);
	}
	...
}

However, free_vbuf() only frees vbuf->resp_buf, vbuf->data_buf, and vbuf:

drivers/gpu/drm/virtio/virtgpu_vq.c:free_vbuf() {
	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
		kfree(vbuf->resp_buf);
	kvfree(vbuf->data_buf);
	kmem_cache_free(vgdev->vbufs, vbuf);
}

When vgdev->vqs_released is true, virtio_gpu_queue_ctrl_sgs() unlocks the
reservations on vbuf->objs when fenced, but never calls
virtio_gpu_array_put_free() or virtio_gpu_array_put_free_delayed() on
vbuf->objs.

[Severity: High]
What happens to callers that pass a non-NULL fence when
virtio_gpu_queue_ctrl_sgs() aborts here before calling
virtio_gpu_fence_emit()?

Because virtio_gpu_queue_fenced_ctrl_buffer() and its callers (such as
virtio_gpu_cmd_resource_detach_backing(),
virtio_gpu_cmd_transfer_to_host_2d(), and virtio_gpu_cmd_submit()) have
void return types and drop the -ENODEV error, the caller is not aware that
virtio_gpu_fence_emit() was skipped, leaving fence->f.seqno =3D=3D 0 and the
fence unqueued in vgdev->fence_drv.fences.

In virtio_gpu_detach_object_fenced(), the caller immediately waits
uninterruptibly on the fence:

drivers/gpu/drm/virtio/virtgpu_object.c:virtio_gpu_detach_object_fenced() {
	...
	virtio_gpu_object_detach(vgdev, bo, fence);
	virtio_gpu_notify(vgdev);

	dma_fence_wait(&fence->f, false);
	dma_fence_put(&fence->f);
}

Similarly, virtio_gpu_cursor_plane_update() calls
dma_fence_wait(&vgplane_st->fence->f, true) right after
virtio_gpu_cmd_transfer_to_host_2d(). Since the fence was never emitted
and will never be signaled, won't dma_fence_wait() in
virtio_gpu_detach_object_fenced() sleep forever in TASK_UNINTERRUPTIBLE
and cause another hung task?

In addition, in virtio_gpu_execbuffer_ioctl():

drivers/gpu/drm/virtio/virtgpu_submit.c:virtio_gpu_execbuffer_ioctl() {
	...
	virtio_gpu_submit(&submit);

	virtio_gpu_install_out_fence_fd(&submit);
	virtio_gpu_process_post_deps(&submit);
	virtio_gpu_complete_submit(&submit);
cleanup:
	if (ret && submit.out_fence && submit.out_fence->e) {
		drm_event_cancel_free(dev, &submit.out_fence->e->base);
		submit.out_fence->e =3D NULL;
	}

	virtio_gpu_cleanup_submit(&submit);
	return ret;
}

Because virtio_gpu_submit() does not propagate the abort error to ret:
1. submit.out_fence (with f.seqno =3D=3D 0) is exported to userspace sync_f=
ile
   or syncobjs, which triggers WARN_ON_ONCE(f->seqno =3D=3D 0) in
   virtio_gpu_fence_signaled() when queried.
2. drm_event_cancel_free() at cleanup is skipped because ret is 0, and
   because submit.out_fence is not in vgdev->fence_drv.fences,
   submit.out_fence->e is never sent or freed.
3. virtio_gpu_complete_submit() clears submit.buflist =3D NULL, so
   virtio_gpu_cleanup_submit() skips freeing submit.buflist (vbuf->objs).

[ ... ]

>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-417-sashal@kernel.org?part=3D1
