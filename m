Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3833AC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7D410E917;
	Fri, 18 Sep 2026 08:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fMe6pBZ+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5B910EEC2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:17:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D5F04189E;
 Fri, 18 Sep 2026 08:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDDE1F000FF;
 Fri, 18 Sep 2026 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789719424;
 bh=jitGweSkHGnVnLT9BPBrjH4NP3Ni1uOEHmSTdjg3ltM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fMe6pBZ+7AWCc+yWz35Yqt53QRFkQfOpMN8dZqMr4rAfvHdtpvtg0cJaOtduHc4ty
 s76+EkH+M4blDeqvyWZmZT7z7qL1r859fpSYMH9neFkbSyo13PoGJ4eKovz7piqgfI
 wF3wiHVU4u0gM63XC+ojodkxKDvm2advM7RhIvuSSJyy7XBgjrxjPafVwg+2kDL7FT
 ewYwGqiMIzM1NiYljpyVRfrt439ILqP0EUIHLQ/AHmuzbYn7QzQnFVkk0v71KRX4bm
 YISBqUsZsLyspceCs4jEaUm5eRLHDhdUtmZ2aljjWDaQQGYmgTeVWSjSpLGYFJS9Ii
 gL8i8DjwqOzCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918075600.2197253-4-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
 <20260918075600.2197253-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:17:03 +0000
Message-Id: <20260918081704.3CDDE1F000FF@smtp.kernel.org>
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
- [High] drm/virtio: suspend/resume broken for userptr blobs due to missing=
 restore_list insertion
--

commit fa2044a8302d0462020754a25069b6a6d031a3a7
Author: Honglei Huang <honghuan@amd.com>

drm/virtio: implement userptr support for zero-copy memory access

This commit adds support for userptr blob objects in the virtio-gpu driver.
It allows the guest kernel to pin existing userspace mappings and advertise
them to the host as CREATE_BLOB backing entries.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/v=
irtio/virtgpu_userptr.c
> new file mode 100644
> index 0000000000000..2f86a95ad2e65
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c

[ ... ]

> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr)
> +{

[ ... ]

> +	ret =3D virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, &nents);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
> +					    nents);
> +
> +	*bo_ptr =3D &userptr->base;
> +	return 0;

[Severity: High]
Does this code miss saving the creation parameters and adding the object to=
=20
the restore list?

If the guest suspends and resumes, virtio_gpu_object_restore_all() needs to=
=20
recreate resources on the host. Without saving params into the base object=
=20
(e.g., bo->params =3D *params) and calling=20
virtio_gpu_add_object_to_restore_list(), this userptr object might be skipp=
ed=20
during system resume.=20

This causes subsequent command submissions using this resource ID to be=20
rejected by the host when the guest userspace resumes and tries to access=20
the resource.

> +
> +err_cleanup:
> +	virtio_gpu_cleanup_object(&userptr->base);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918075600.2197=
253-1-honghuan@amd.com?part=3D3
