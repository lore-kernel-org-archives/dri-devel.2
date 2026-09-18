Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D84CC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FB310E405;
	Fri, 18 Sep 2026 07:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mh9nBd+2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA1410E405
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:07:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E33C16053E;
 Fri, 18 Sep 2026 07:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B7E1F000FF;
 Fri, 18 Sep 2026 07:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789715242;
 bh=oqcbT3JJup7pGVZk81gKL6jgTLhiTQXHaidtQVQG+1s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mh9nBd+2UWEVEJGM+1ui8d/V3dCClPKcG/bYSvQhTvj/O5vzAPxZ3+9aa/rVsfn07
 HHPze9t8bVzJ1wyDaHFmBiVMzN0nRcIrMnvYEmBcQUaSuLlQBGzBLDch4eGXdjRAMM
 xk17+hGlbqewAkn9EoUgVk4N6bHMo4yZe4L9iR/C4RhxJBXVtmVpivsvexda6oF/b6
 T0UOYR2B7ef28xCiU/y2mosAsPiirVBZ3UDY+4GYybHoXdIhkIXOxhNUcGEAKYXJS6
 DN3Q5OtGrW++Iz4mbISYjHs7GGeycTwIk/34zvnlkP1MeDQqCd9puiTPxyQ2Zb3xAD
 iXkdTlQwOKi2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918065653.2170828-5-honghuan@amd.com>
References: <20260918065653.2170828-1-honghuan@amd.com>
 <20260918065653.2170828-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 07:07:21 +0000
Message-Id: <20260918070722.71B7E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm/virtio: privilege escalation via unnegotiated VIRTGPU_BLOB=
_FLAG_USE_READONLY
--

commit b371f8bf32b2c925d61457787ca19851334b0963
Author: Honglei Huang <honghuan@amd.com>
drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr into the blob resource creation ioctl.
It selects virtio_gpu_userptr_create for non-zero userptrs and
accepts the VIRTGPU_BLOB_FLAG_USE_READONLY flag.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..d42ca3898d4ed 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -36,7 +36,10 @@
> =20
>  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>  				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> -				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> +				    VIRTGPU_BLOB_FLAG_USE_READONLY)
> +
> +#define VIRTGPU_BLOB_HINT_MASK DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING

[ ... ]

> @@ -453,11 +459,18 @@ static int verify_blob(struct virtio_gpu_device *vg=
dev,
>  	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
>  		return -EINVAL;

[Severity: Critical]
Does verify_blob() unconditionally allow VIRTGPU_BLOB_FLAG_USE_READONLY=20
without verifying if the host emulator actually supports enforcing it?

Other flags, such as VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE, have explicit host=
=20
capability checks (such as vgdev->has_resource_assign_uuid) further down in=
=20
this function.=20

If a guest userspace calls DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB with=20
VIRTGPU_BLOB_FLAG_USE_READONLY set and a user pointer to read-only memory,=
=20
the guest pins the memory without FOLL_WRITE. If the hypervisor does not=20
understand the READONLY flag, it might ignore it and map the memory as=20
read-write.=20

Could this allow unprivileged guest users to submit virtio-gpu rendering=20
commands that write to the buffer, bypassing the guest's page protections=20
and modifying arbitrary read-only memory in the guest?

> +	if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
> +		return -EINVAL;
> +
>  	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
>  		if (!vgdev->has_resource_assign_uuid)
>  			return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918065653.2170=
828-1-honghuan@amd.com?part=3D4
