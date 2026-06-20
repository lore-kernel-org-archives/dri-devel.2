Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22840CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A26A10E279;
	Sat, 20 Jun 2026 19:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q+7j0J44";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA5F10E279
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:12:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC5AE601E1;
 Sat, 20 Jun 2026 19:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCD1F000E9;
 Sat, 20 Jun 2026 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982771;
 bh=hhKA4CDpxYPgmMlqLwVVtHql0UZ3NFgnB8M8TNv/OCY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q+7j0J44HDKQFcy9SrLmHQUnvxJmz+U9iUu4TVjsNd+E42QdQS+HopDVrL072Oaro
 X4J+ZLtUK4pXRFFWyDSrSy3gVBVQ12/kRWGRQ7XW5jIzN8dz2MvnMVN5oKOzlXTXHH
 tZYtfX10BUFhfg0pUcDbTQS2vMdGX2hZpxSFZ79ZVehpTKyA9mrBhBiOh9+/k+In1h
 g4qdxIL/dFcP91M0mbvRPZ43yLQJyGwjUoobhSMRBwwMzJwjW45qxOPfBVekyRbiEm
 7UcsEHEI4UTZl0CkLmFrLbJTg5QZO7uJ+jkQbkvK6ZNkW1A5Bt6iC1F3WQMVD/11Mb
 6RWfBOjZ5ktcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Fix an error handling path in
 amdgpu_amdkfd_get_dmabuf_info()
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <44cbc1d12fc00121d40ce793074bc5e1d497c932.1781982199.git.christophe.jaillet@wanadoo.fr>
References: <44cbc1d12fc00121d40ce793074bc5e1d497c932.1781982199.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:12:50 +0000
Message-Id: <20260620191251.5AFCD1F000E9@smtp.kernel.org>
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
- [High] Missing buffer object reservation lock in `amdgpu_amdkfd_get_dmabu=
f_info()` leads to a Use-After-Free or Data Race when accessing BO metadata.
- [High] Dereferencing dmabuf_adev->kfd.dev can cause a kernel panic if the=
 imported DMA buffer was exported from an AMDGPU device without KFD initial=
ized.
--

commit b918bf448d8c4caa5149dad7e3a094a3b15f65eb
Author: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

drm/amdkfd: Fix an error handling path in amdgpu_amdkfd_get_dmabuf_info()

This commit fixes an error handling path in amdgpu_amdkfd_get_dmabuf_info()
by properly releasing the reference on 'dma_buf' when memory allocation fai=
ls.
This aligns with the error handling in other paths of the function.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index d516d504ae4c8..8e7212a03475c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -603,8 +603,10 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_devi=
ce *adev, int dma_buf_fd,
>  		if (*metadata_size <=3D buffer_size) {
>  			*metadata_buffer =3D kzalloc(*metadata_size, GFP_KERNEL);
> =20
> -			if (!*metadata_buffer)
> -				return -ENOMEM;
> +			if (!*metadata_buffer) {
> +				r =3D -ENOMEM;
> +				goto out_put;
> +			}
> =20
>  			r =3D amdgpu_bo_get_metadata(bo, *metadata_buffer, *metadata_size,
>  						   NULL, &metadata_flags);

[Severity: High]
This isn't a bug introduced by this patch, but does amdgpu_amdkfd_get_dmabu=
f_info()
need to acquire the buffer object's reservation lock before calling
amdgpu_bo_get_metadata()?

Concurrently, a userspace process can trigger the AMDGPU_GEM_METADATA_OP_SE=
T_METADATA
ioctl, which acquires the lock and calls amdgpu_bo_set_metadata(). This set=
ter
unconditionally calls kfree(ubo->metadata) and reallocates it. The lockless
reader path in amdgpu_bo_get_metadata() will then execute a memcpy using the
freed pointer:

drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:amdgpu_bo_get_metadata() {
    ...
		if (ubo->metadata_size)
			memcpy(buffer, ubo->metadata, ubo->metadata_size);
    ...
}

Could this lead to a use-after-free or out-of-bounds read if ubo->metadata =
is
freed concurrently?

[Severity: High]
This is a pre-existing issue, but could the dmabuf_adev resolved in
amdgpu_amdkfd_get_dmabuf_info() cause a NULL pointer dereference in its cal=
ler?

In kfd_ioctl_get_dmabuf_info() located in drivers/gpu/drm/amd/amdkfd/kfd_ch=
ardev.c,
amdgpu_amdkfd_get_dmabuf_info() successfully resolves dmabuf_adev to the
exporting AMDGPU device. However, if KFD is not initialized on the exporting
device, dmabuf_adev->kfd.dev will be NULL.

Since xcp_id is typically initialized to 0, the check passes and leads to a
dereference:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_ioctl_get_dmabuf_info() {
    ...
	if (xcp_id >=3D 0)
		args->gpu_id =3D dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
    ...
}

Would it be possible for a local user to trigger this by passing a valid
DMA buffer FD from a non-compute AMDGPU device to the KFD ioctl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/44cbc1d12fc00121d40=
ce793074bc5e1d497c932.1781982199.git.christophe.jaillet@wanadoo.fr?part=3D1
