Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B6606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIBWRAAi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CD410E124;
	Thu, 26 Nov 2026 08:22:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D29B10E124
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:22:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D4264581C;
 Thu, 26 Nov 2026 08:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591301F000CA;
 Thu, 26 Nov 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795681354;
 bh=+vd+KshxWWgTitCR1RPrscHfNBdG0sGxLBtrNM87KOQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aIBWRAAiLIjc5X+hMOwgC3TghZDULlrsEd/9GhNGZ9/caqs9mTdrUA9pxmhXoUt+I
 ZSyq/tFuSh9ieaIK2Ka4YthsROneBZnIjITLxIM97WCpVToDqxyAKPZ0/qETTR1AP7
 opA9dGvraNGf6Vu33FlU/BSP7pzMLg+OA/fLnf1R5YpcuR8xIHBXy0NwLSjUVvm3DY
 ft1SslfqTwoRsn3rWj2hNKGcUOjiVEegSmtz3rkAllS0/qgvkXwro0YhldWrcX511S
 Gi+1GhOI8YpAldBgPIY92zUcNkl5fvZf9kisI9meoKqutCdccKn1xSwB+NaPYp4sjS
 nBge+vgO2nrTA==
Message-ID: <sashiko-outbox-235004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: bound execbuffer commands to control queue
 size
To: "Seojin An" <love09010224@uos.ac.kr>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261126080044.2898223-1-love09010224@uos.ac.kr>
References: <20261126080044.2898223-1-love09010224@uos.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:22:33 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/virtio: UAF of ctrlq.vq in virtio_gpu_execbuffer_ioctl()
  on unplug
--

commit 03e41369bd07f481a8b25bccdf4ab65b96d730a3
Author: Seojin An <love09010224@uos.ac.kr>

drm/virtio: bound execbuffer commands to control queue size

This commit rejects execbuffer commands whose page count plus the request a=
nd
response descriptors exceeds the control virtqueue size.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/vi=
rtio/virtgpu_submit.c
> index 6580ece658704..9aff7f8d5195f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -482,6 +482,8 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *de=
v, void *data,
>  	u64 fence_ctx =3D vgdev->fence_drv.context;
>  	struct drm_virtgpu_execbuffer *exbuf =3D data;
>  	struct virtio_gpu_submit submit;
> +	u64 command_sgs;
> +	unsigned int max_sgs;
>  	u32 ring_idx =3D 0;
>  	int ret =3D -EINVAL;
> =20
> @@ -491,6 +493,17 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *d=
ev, void *data,
>  	if (exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS)
>  		return ret;
> =20
> +	/*
> +	 * The command contributes one SG entry per vmalloc page in addition
> +	 * to the fixed request and response entries.  Virtio requires both
> +	 * direct and indirect descriptor chains to fit the device queue.
> +	 * Reject oversized commands before copying or queueing them.
> +	 */
> +	max_sgs =3D virtqueue_get_vring_size(vgdev->ctrlq.vq);
> +	command_sgs =3D DIV_ROUND_UP((u64)exbuf->size, PAGE_SIZE);
> +	if (max_sgs < 2 || command_sgs > max_sgs - 2)
> +		return -E2BIG;
> +
>  	if (exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) {
>  		if (exbuf->ring_idx >=3D vfpriv->num_rings)
>  			return ret;

[Severity: Medium]
Can virtqueue_get_vring_size() dereference vgdev->ctrlq.vq after it has been
freed on device unplug?

drm_ioctl_kernel() checks drm_dev_is_unplugged(), which enters and immediat=
ely
exits its SRCU section before calling virtio_gpu_execbuffer_ioctl().  Becau=
se
other virtqueue paths such as virtio_gpu_queue_ctrl_sgs() guard vgdev->ctrl=
q.vq
with drm_dev_enter(), an in-flight ioctl can race with virtio_gpu_remove():

CPU0                                  CPU1
drm_ioctl_kernel()
  drm_dev_is_unplugged()
                                      virtio_gpu_remove()
                                        drm_dev_unplug()
                                        virtio_gpu_deinit()
                                          del_vqs()
                                            kfree(vq)
  virtio_gpu_execbuffer_ioctl()
    virtqueue_get_vring_size(ctrlq.vq)  <-- use-after-free

Guarding the virtqueue_get_vring_size() call with drm_dev_enter() and
drm_dev_exit() would prevent this race.

[Severity: High]
This problem wasn't introduced by this patch, but virtio_gpu_cmd_submit() h=
as
a void return type and drops errors from [1]
virtio_gpu_queue_fenced_ctrl_buffer().

When queueing fails due to memory pressure or device unplug,
virtio_gpu_fence_emit() is never called and the fence stays at seqno 0, yet
virtio_gpu_execbuffer_ioctl() continues to virtio_gpu_install_out_fence_fd()
and exports the uninitialized fence to userspace.  Any client waiting on th=
at
fence file descriptor hangs indefinitely, and checking the fence triggers
WARN_ON_ONCE(f->seqno =3D=3D 0) in virtio_gpu_fence_signaled().

[1] https://sashiko.dev/#/bug/linux-c280d0dd-d017-4ef7-a36a-c0606306f02c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126080044.2898=
223-1-love09010224@uos.ac.kr?part=3D1
