Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF22C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B8910EBBA;
	Tue,  8 Sep 2026 12:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XZeobfDA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B2E10EBBA
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:34:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C127340530;
 Tue,  8 Sep 2026 12:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D501F00A3D;
 Tue,  8 Sep 2026 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788870880;
 bh=yC4xYT527oTGQZB4g2jK0lR+JmBCgyt8ytQktlvZKyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XZeobfDA1ncVHM3anBumCxKQ64ZM86M/WvXZePUpLhe1R/J6vXebVE98Zufsy4IfA
 7mQ9CkCIc0POe9Gtqjd1n2HTUN6pzPv4e9hHUwOu/TKWfmkoQaXSSKRWDseR6VVkpz
 5LZumituHDI7tZo3a+9hPe752oXtrN2oDUOtcRACG46hl8uI2/TxIbn320h930vNH5
 jQdRLn00v6Ef5wVLjcTwrmMkbI75Y/qVLdM/sidk2p3rNGTpY3HDo1DhRPsdGWER8M
 2qilVEI6/uEhF+B9rzz3tqaD4c52euWQBVRKTa9hKAYSjbsMaR8JvpigDZr5MbgeoV
 25Mbbt4269H5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix memory leak of fence event on
 execbuffer failure
To: "Peiyang He" <peiyang_he@smail.nju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <D320EAB5680C1411+20260908121323.2405044-1-peiyang_he@smail.nju.edu.cn>
References: <D320EAB5680C1411+20260908121323.2405044-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:34:40 +0000
Message-Id: <20260908123440.84D501F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of virtio_gpu_fence_alloc() is not checked for NU=
LL, leading to a NULL pointer dereference on memory allocation failure.
- [High] Silent command submission failures ignore error returns, bypassing=
 error cleanup and leaking memory, GEM object references, and the fence eve=
nt.
--

commit 93a0baf42622f4c32d5d66c718e042ee250da557
Author: Peiyang He <peiyang_he@smail.nju.edu.cn>
drm/virtio: fix memory leak of fence event on execbuffer failure

This patch fixes a memory leak in the virtio GPU driver by cancelling
and freeing the DRM event on the execbuffer error path before dropping
the out-fence. It ensures the fence's event pointer is cleared after
cancellation to prevent dangling pointers.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/vi=
rtio/virtgpu_submit.c
> index 32cb1e4aa4258..734b1e976a75c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -538,6 +538,10 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *d=
ev, void *data,
>  	virtio_gpu_process_post_deps(&submit);
>  	virtio_gpu_complete_submit(&submit);

[Severity: High]
This isn't a bug introduced by this patch, but does this code silently abso=
rb
submission errors and leak resources?

In the current code just above this hunk, we have:

    virtio_gpu_submit(&submit);
    ...
    virtio_gpu_complete_submit(&submit);
cleanup:

If the underlying queue functions fail (e.g., vmalloc_to_sgt() returning
-ENOMEM in virtio_gpu_queue_fenced_ctrl_buffer()), they return an error cod=
e:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_queue_fenced_ctrl_buffer() {
    ...
        sgt =3D vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size, &sg_ents);
        if (!sgt) {
            if (fence && vbuf->objs)
                virtio_gpu_array_unlock_resv(vbuf->objs);
            return -ENOMEM;
        }
    ...
}

However, the wrapper functions like virtio_gpu_cmd_submit() return void,
dropping this error:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_submit() {
    ...
    virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
}

Because the error is dropped, virtio_gpu_execbuffer_ioctl() proceeds as if
successful, calls virtio_gpu_complete_submit() to clear pointers, and
skips the error cleanup path.

Does this permanently leak GEM object references, memory buffers, and the
fence event when command submission fails under memory pressure?


[Severity: High]
This is another pre-existing issue, but is it possible for
virtio_gpu_fence_alloc() to fail and cause a NULL pointer dereference
earlier in the submission path?

Looking at virtio_gpu_init_submit() called earlier in this ioctl, it does
not check the return value of virtio_gpu_fence_alloc():

drivers/gpu/drm/virtio/virtgpu_submit.c:virtio_gpu_init_submit() {
    ...
        out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
    else
        out_fence =3D NULL;

    if (drm_fence_event) {
        err =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_id=
x);
    ...
}

And in virtio_gpu_fence_event_create():

drivers/gpu/drm/virtio/virtgpu_submit.c:virtio_gpu_fence_event_create() {
    ...
    fence->e =3D e;
    ...
}

If kzalloc_obj() inside virtio_gpu_fence_alloc() fails due to memory pressu=
re,
it returns NULL, which is then unconditionally dereferenced.

Can unprivileged userspace trigger this by invoking the execbuffer ioctl
under constrained memory conditions?

>  cleanup:
> +	if (ret && submit.out_fence && submit.out_fence->e) {
> +		drm_event_cancel_free(dev, &submit.out_fence->e->base);
> +		submit.out_fence->e =3D NULL;
> +	}
>  	virtio_gpu_cleanup_submit(&submit);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/D320EAB5680C1411+20=
260908121323.2405044-1-peiyang_he@smail.nju.edu.cn?part=3D1
