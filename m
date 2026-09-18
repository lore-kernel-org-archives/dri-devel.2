Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB93C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DA010E853;
	Fri, 18 Sep 2026 08:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZdEJWX7m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC5D10E853
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:12:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D5CB4180B;
 Fri, 18 Sep 2026 08:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CE81F000FF;
 Fri, 18 Sep 2026 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789719162;
 bh=aIPW8WfKc38jQ9iNWqvKFmWor+qHm5BVyZIaNWOdm/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZdEJWX7mNx8OCAc6LHRks2lRhX8DjtOYqYNwqeKw4eC30/tE5joAwLDQWCZMeYx5O
 4tWFtCudCHmtK5PxeUfNMlT/0po/CQplCCeeQyGQHAhgMrAVDgFarVqhLXIj6Aq+Ks
 WA/s5Wnkflo6GmWAf+T0DQQexHj+MILalb0KOO89YXRzUw0WyfEylzBP1hHF3qJa6M
 PzEay+MwNcAdZMk3zeoLewR7anXm2jWhx5dPcpgcfHLUo/X20WfRkD0tNUKRiuMdSH
 dXqgcDV25QiiwbcyDaK9Xu88j0/fS67Tfsh00cD4JYpyipQSZjynLqcxWMIOIT5vPi
 ovutGRIRRVe+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918075600.2197253-5-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
 <20260918075600.2197253-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:12:41 +0000
Message-Id: <20260918081241.E5CE81F000FF@smtp.kernel.org>
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
- [High] drm/virtio: resource loss on resume for userptr blobs
--

commit 260e023045965d09441bfc27b3e47cf7b409d5b4
Author: Honglei Huang <honghuan@amd.com>

drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr into the blob resource creation ioctl.
It adds validation and wires up virtio_gpu_userptr_create() for guest
blob allocations.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
[ ... ]
> @@ -538,7 +561,9 @@ static int virtio_gpu_resource_create_blob_ioctl(stru=
ct drm_device *dev,
>  				      vfpriv->ctx_id, NULL, NULL);
>  	}
> =20
> -	if (guest_blob)
> +	if (guest_blob && params.userptr)
> +		ret =3D virtio_gpu_userptr_create(vgdev, file, &params, &bo);

[Severity: High]
Does this code handle system hibernation properly for userptr objects?

When virtio_gpu_userptr_create() in drivers/gpu/drm/virtio/virtgpu_userptr.c
successfully allocates the object, it returns without saving bo->params or
calling virtio_gpu_add_object_to_restore_list():

	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
					    nents);

	*bo_ptr =3D &userptr->base;
	return 0;

Consequently, these objects are permanently lost when the system resumes fr=
om
hibernation because their host-side resources are not re-created. Subsequent
GPU commands referencing these resources will fail.

Additionally, if these userptr objects were added to the obj_restore_list, =
it
seems virtio_gpu_object_restore_all() in drivers/gpu/drm/virtio/virtgpu_obj=
ect.c
would crash:

	if (bo->params.blob || bo->attached) {
		ret =3D virtio_gpu_object_shmem_init(vgdev, bo, &ents,
						   &nents);
		if (ret)
			break;
	}

This logic assumes all non-imported blobs are backed by drm_gem_shmem_objec=
t,
but userptr blobs are not.

> +	else if (guest_blob)
>  		ret =3D virtio_gpu_object_create(vgdev, &params, &bo, NULL);
>  	else if (!guest_blob && host3d_blob)
>  		ret =3D virtio_gpu_vram_create(vgdev, &params, &bo);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918075600.2197=
253-1-honghuan@amd.com?part=3D4
