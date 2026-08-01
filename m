Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB77C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 08:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE7710E2D8;
	Sat,  1 Aug 2026 08:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dniOXrcG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3F910E2C8
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 08:18:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13135600D8;
 Sat,  1 Aug 2026 08:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1D71F00ACF;
 Sat,  1 Aug 2026 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785572332;
 bh=XZqiP6mF3J2DOO08guXQLZ6Un42eebnCQaEe/TN5cAE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dniOXrcG4UiKKFTJzaq0/S8MvODbPBx01vIzi3sIemU6ZSwNccKKoiAnjTLs4gFpm
 CSPquEgyTs3ARGw2V4u69Gcu3hig7sH1kDL8nmo5cLSs3S5spOw+g0E/bdjagTHBeM
 d94Z9ntJTUIpa50S2tZ3YWPfhqzGW/BT8clAkBDPiRQcAT20j8n26tDAdDjN1dt66b
 nzROWK07Zx8l+NWr2ASJV4laaLFLFWeQRkjmvjulydBpQKT8Gch/NfuF43BntKBKct
 mSMXxbtBgk7DTl0+mKmranIUnphS7/tQjccM0RFkEOHpHzpZqSN/jx545Eegy7UH6d
 V7PLQdpZalOIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/virtio: free control buffer when scatterlist
 allocation fails
To: "Yao Kai" <yaokai34@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731092236.2262403-3-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
 <20260731092236.2262403-3-yaokai34@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:18:52 +0000
Message-Id: <20260801081852.9F1D71F00ACF@smtp.kernel.org>
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
- [High] Command submission functions swallow the return value of queueing =
functions, causing silent failures that lead to infinite hangs or WARN_ON t=
riggers.
- [High] Failure to check the return value of `virtio_gpu_fence_alloc()` le=
ads to a NULL pointer dereference or permanently leaked `dma_resv` locks on=
 GEM objects.
--

--- Patch [2]: [PATCH 2/2] drm/virtio: free control buffer when scatterlist=
 allocation fails ---
commit 3738e83e4c6bee348b73dcd2ccca201708bd9797
Author: Yao Kai <yaokai34@huawei.com>

drm/virtio: free control buffer when scatterlist allocation fails

This commit addresses a memory leak that occurs when vmalloc_to_sgt() fails
in virtio_gpu_queue_fenced_ctrl_buffer(). It correctly drops object array
references and frees the vbuffer on the error path before returning -ENOMEM.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index a470339b67474..7ccc487e33322 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -477,6 +477,8 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct=
 virtio_gpu_device *vgdev,
>  			if (!sgt) {
>  				if (fence && vbuf->objs)
>  					virtio_gpu_array_unlock_resv(vbuf->objs);

[Severity: High]
This is a pre-existing issue, but does checking the fence before unlocking
leave the GEM objects permanently locked if the fence is NULL?

If virtio_gpu_init_submit() fails to allocate a fence via
virtio_gpu_fence_alloc(), it could still lock the GEM objects and pass
fence =3D NULL into the queuing functions, which means we skip unlocking th=
em
here.

Additionally, missing the NULL check on the fence returned by
virtio_gpu_fence_alloc() can lead to a NULL pointer dereference in
virtio_gpu_fence_event_create():

drivers/gpu/drm/virtio/virtgpu_submit.c:virtio_gpu_init_submit() {
	...
	if (out_fence_fd)
		out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
	...
	if (drm_fence_event) {
		err =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
	...
}

drivers/gpu/drm/virtio/virtgpu_fence.c:virtio_gpu_fence_event_create() {
	...
	fence->e =3D e;
	...
}

Would it be better to decouple the unlocking of vbuf->objs from the presence
of a fence?

> +				virtio_gpu_array_put_free(vbuf->objs);
> +				free_vbuf(vgdev, vbuf);
>  				return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but because this function returns
an error here, are there callers that swallow this error?

For example, virtio_gpu_cmd_submit() ignores the return value:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_submit() {
	...
	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
}

Similarly, virtio_gpu_cmd_map() ignores the return value of
virtio_gpu_queue_ctrl_buffer():

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_map() {
	...
	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
	return 0;
}

If the queueing functions fail and return -ENOMEM, the callers return void
or 0, causing higher-level ioctls to proceed as if successful.

Can this cause infinite hangs? If the command is dropped,
virtio_gpu_vram_mmap() might hang indefinitely waiting for a response:

drivers/gpu/drm/virtio/virtgpu_vram.c:virtio_gpu_vram_mmap() {
	...
	wait_event(vgdev->resp_wq, vram->map_state !=3D STATE_INITIALIZING);
}

Also, VIRTGPU_EXECBUFFER might return a sync_file with an unsignaled fence,
which could cause a userspace poll to hang indefinitely.

>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731092236.2262=
403-1-yaokai34@huawei.com?part=3D2
