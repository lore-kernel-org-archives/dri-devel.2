Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F460C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2895C10E36D;
	Mon, 14 Sep 2026 05:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rgslhp5g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7340610E36D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:59:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 057AE43474;
 Mon, 14 Sep 2026 05:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885E1F000FF;
 Mon, 14 Sep 2026 05:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789365592;
 bh=1BXuloBroCCKBaG85VPPRFgCCxFuJDmf+/b9Lh3bEEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rgslhp5gxwTfTLuNwiZjXcWwBpuNycSgMb8vKCN25puiC9O9BB73bEi4URblm7vER
 famzNqJqtVlT+nAHYnTfc9dzqbAS0B1IF8jpzFGibRh2dSpgoaqsqE+zi9qFLlTvis
 5mYn/mX/c9ePSjnyDEXkchnxGyT32yibBFwJJMp61hQRMWKMSjTpDGfEtRHD+8vjGH
 6lXhF0ALYnPpRQvUStvnjDBzQlWROCuFPYcf/6jKAe58HKupWy+4jdFmVv5TqhVwV1
 lOO6zBgBVPCeBTIkxXmfFL0qGZMrNRqAivb5G4j4PLBF1lkcJqarZbBSpS0le47nTX
 GY7VWMH9VrOTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH next] drm/amdgpu: Initialize UALink handle uniqueness state
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914054604.12850-1-kmehltretter@gmail.com>
References: <20260914054604.12850-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 05:59:52 +0000
Message-Id: <20260914055952.C885E1F000FF@smtp.kernel.org>
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
- [Critical] Unchecked dereference of `adev->ualink.info` in `amdgpu_gem_ua=
link_handle_ioctl` when UALink is unsupported.
- [High] Lockless read and write of `robj->ualink_handle_lo` allows a TOCTO=
U race condition that permanently leaks BO references and XArray nodes.
- [High] Missing `amdgpu_bo_unref()` on error path in `amdgpu_ualink_export=
_handle()` leads to GPU memory leak.
--

commit ca49d768520fb1865985555b2647fee616d8460f
Author: Karl Mehltretter <kmehltretter@gmail.com>

drm/amdgpu: Initialize UALink handle uniqueness state
   =20
amdgpu_generate_ualink_handle() continues when handle_lo is zero. For
accelerator ID 0, the random value can become zero after the low 10 bits
are cleared. This path reaches while (!unique) without assigning unique.

[ ... ]

Initialize unique to false so the zero-handle path repeats the loop.
   =20
Fixes: c67cb19811ec ("drm/amdgpu: Implement UALink handle export")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ualink.c
> index ab564202f550a..c6b7122301f92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -1819,7 +1819,7 @@ static void amdgpu_ualink_npa_mm_fini(struct amdgpu=
_device *adev)
>  static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
>  				   struct amdgpu_ualink_handle *handle)
>  {
> -	bool unique;
> +	bool unique =3D false;
> =20
>  	do {
>  		handle->handle_lo =3D get_random_u64();

While reviewing this patch, I noticed a few pre-existing issues in the same
file:

[Severity: Critical]
This is a pre-existing issue, but does amdgpu_gem_ualink_handle_ioctl() pan=
ic
on GPUs lacking UALink support?

drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c:amdgpu_gem_ualink_handle_ioctl()=
 {
	...
	if (adev->ualink.info->accel_state !=3D
	    AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
		dev_err(adev->dev,
			"ualink device is not in active state in vpod\n");
		return -EOPNOTSUPP;
	}
	...
}

adev->ualink.info is only allocated if the GPU supports UALink. Since the
DRM_IOCTL_AMDGPU_UALINK_HANDLE ioctl is registered unconditionally for the
whole driver, can unprivileged userspace trigger an immediate kernel crash
(NULL pointer dereference) by calling this ioctl on an unsupported GPU?


[Severity: High]
This isn't a bug introduced by this patch, but does
amdgpu_ualink_export_handle() leak a BO and an exp_xa_node?

drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c:amdgpu_ualink_export_handle() {
	...
	if (!robj->ualink_handle_lo) {
		...
		amdgpu_bo_ref(robj);
		...
		xa_lock(&adev->ualink.exp_xa);
		amdgpu_generate_ualink_handle(adev, &handle);
		exp_xa_node->handle =3D handle;
		r =3D __xa_insert(&adev->ualink.exp_xa, handle.handle_lo,
				exp_xa_node, GFP_KERNEL);
		xa_unlock(&adev->ualink.exp_xa);
		...
		robj->ualink_handle_lo =3D handle.handle_lo;
		...
	}
	...
}

Because robj->ualink_handle_lo is checked and overwritten locklessly (witho=
ut
holding a lock like the BO's reservation lock), could a TOCTOU race occur if
two threads from the same process concurrently call the export ioctl for the
same GEM handle?

It seems both threads would observe robj->ualink_handle_lo =3D=3D 0, alloca=
te an
exp_xa_node, call amdgpu_bo_ref(robj), insert their node into the exp_xa
array, and locklessly overwrite robj->ualink_handle_lo. Since cleanup only
removes the handle stored in ualink_handle_lo, one node remains permanently
in the XArray and its BO reference is never released, leaking VRAM.


[Severity: High]
This is a pre-existing issue, but does amdgpu_ualink_export_handle() leak
the BO reference on the DMABuf error path?

drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c:amdgpu_ualink_export_handle() {
	...
		amdgpu_bo_ref(robj);
		...
		exp_xa_node->dmabuf =3D drm_gem_prime_handle_to_dmabuf(&adev->ddev, filp,
						gem_handle, DRM_CLOEXEC | DRM_RDWR);
		if (IS_ERR(exp_xa_node->dmabuf)) {
			r =3D PTR_ERR(exp_xa_node->dmabuf);
			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
			kfree(exp_xa_node);
			goto out;
		}
	...
out:
	drm_gem_object_put(gobj);
	return r;
}

The out label drops the GEM object reference via drm_gem_object_put(), but
fails to balance the explicit amdgpu_bo_ref(robj) taken earlier. If
drm_gem_prime_handle_to_dmabuf() fails (for example, due to file descriptor
exhaustion resulting in -EMFILE), won't this permanently leak the BO
reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914054604.1285=
0-1-kmehltretter@gmail.com?part=3D1
