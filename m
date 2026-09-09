Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE5EC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E3410F04F;
	Wed,  9 Sep 2026 09:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PsvYEchr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0FF10F054
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:28:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9923B42A4E;
 Wed,  9 Sep 2026 09:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5135D1F00A3E;
 Wed,  9 Sep 2026 09:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788946085;
 bh=UJslZMvE0D8fC7ARJJgUEwtftWtwYY3YDTGuY3cLa5c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PsvYEchrUU7Kk3AnnnMeO+Pd8qCM0jhNHS9TmeT0oyb7p4VnH27zdeUCTmPjvbZ1N
 ZOcrQgET5tlKF/LMo18YHgw4IyjAC4+LX5Uxs1USBTOqT/OhXff+nE2Ia7EtsDor8A
 bVqXgKNLjwZ+d5aYabVQUU4sOOC/utwYlIEsdaYlMB6Z0b+9LxGakpoFIHV2t5wqZG
 0/Kj+R7qZsQDs7oQSzPIwPkKiI36+bcf4TXQOz0RG9tAU7E+5Jx+vaCTf+5E1JQk14
 3CNOulah4n9wv9Bv1LY7EW4wnDGpVzZXD0YnENH62+2ToIa/akohNQAj2KpKEJKIiC
 WTzKndl7RBYeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix NULL pointer dereference on fence
 allocation failure
To: "Peiyang He" <peiyang_he@smail.nju.edu.cn>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn>
References: <00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:28:04 +0000
Message-Id: <20260909092805.5135D1F00A3E@smtp.kernel.org>
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

Pre-existing issues:
- [High] Erroneous release of file descriptor 0 on early error returns due =
to 0-initialized out_fence_fd.
- [High] Leak of DRM event memory and event space quota on early submission=
 failure.
- [High] Premature reset of in_syncobjs on error paths breaks ioctl restart=
 and destroys dependencies.
--

commit 1f57c5e182bb2310a6b5538ff7f993fd7e45dee5
Author: Peiyang He <peiyang_he@smail.nju.edu.cn>
drm/virtio: fix NULL pointer dereference on fence allocation failure

This commit adds a missing NULL check after allocating a fence in
virtio_gpu_init_submit() to prevent a NULL pointer dereference under
memory pressure.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/vi=
rtio/virtgpu_submit.c
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -389,10 +389,13 @@ static int virtio_gpu_init_submit(struct virtio_gpu=
_submit *submit,
>  	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
>  	    exbuf->num_out_syncobjs ||
>  	    exbuf->num_bo_handles ||
> -	    drm_fence_event)
> +	    drm_fence_event) {
>  		out_fence =3D virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
> -	else
> +		if (!out_fence)
> +			return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but returning early here
exposes a pre-existing issue with file descriptor handling.

Because virtio_gpu_init_submit() initializes the submit struct using
memset(submit, 0, sizeof(*submit)), submit->out_fence_fd is left as 0.
If we return -ENOMEM here, the caller eventually invokes
virtio_gpu_cleanup_submit(), which checks:

    if (submit->out_fence_fd >=3D 0)
        put_unused_fd(submit->out_fence_fd);

Since 0 is >=3D 0, this will erroneously release file descriptor 0
(typically stdin) back to the kernel, potentially allowing subsequent
open() calls to hijack the file descriptor. Could out_fence_fd be
initialized to -1 before taking this early return?

[Severity: High]
This is a pre-existing issue, but does taking an error path (such as
this new -ENOMEM return) break system call restarts?

When the submission ioctl fails, the error path calls
virtio_gpu_cleanup_submit(). This function unconditionally calls
virtio_gpu_reset_syncobjs(), replacing all input syncobj fences with
NULL. When the kernel automatically restarts the ioctl (e.g. after
-ERESTARTSYS is returned during a signal interruption), the dependencies
are already destroyed, causing drm_syncobj_find_fence() to return
-EINVAL and breaking userspace synchronization state.

> +	} else {
>  		out_fence =3D NULL;
> +	}
> =20
>  	if (drm_fence_event) {
>  		err =3D virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);

[Severity: High]
This is a pre-existing issue, but how does the code handle event cleanup
if an error occurs later in the submission process?

If virtio_gpu_fence_event_create() succeeds, it allocates the event and
deducts from file_priv->event_space. If a subsequent initialization step
fails, virtio_gpu_cleanup_submit() drops the fence reference via
dma_fence_put(&submit->out_fence->f).

However, because virtio_gpu_fence_ops lacks a .release callback,
dma_fence_release() simply frees the fence without ever calling
drm_event_cancel_free(), leaking both the event memory and the client's
event space quota.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/00EFE4BA92889B14+20=
260909091114.2622550-1-peiyang_he@smail.nju.edu.cn?part=3D1
