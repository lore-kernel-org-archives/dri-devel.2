Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22E9C982D0
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 02:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF5110EFD7;
	Fri, 18 Sep 2026 02:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QspJ+00T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E750310EFD7
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 02:23:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02885600AA;
 Fri, 18 Sep 2026 02:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795CC1F000FF;
 Fri, 18 Sep 2026 02:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789698196;
 bh=YXQQEglBcmDSGfULyIbPQqx4CfZaXxvf3ss4t2PKInk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QspJ+00TiNecc6F6Sve16b9EAkanL37NDdn4uhX96MyIlTO4W+/7r0ayZ/WF6+lPY
 cahDnmDI7b6+BbRG5y9M8sVecoiGWRRrfgPwg3aHvDQPr2KvcjvZGnOMwOPJEL5kIO
 Bkrlbrd2LXUwMQRhd1ETx4bV4Mp9xGWPG1kQJKn4ibmSCze3P0h5hO7Zyfq8D9eeTo
 gzyuCeiBt9wKmnu5qL9Swve+bkxI7b0wVNFFVTs9EGTE2xxs6CL0SRAeG3Udo2iAFD
 51RmSr7rZDvM+vIksKqS4eyNI8Ug4spTlVQ2mZcXVXtqObt+A8SFNVhsP/tBtC61lt
 TqBLKEo75mL5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260918021154.1432154-5-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:23:16 +0000
Message-Id: <20260918022316.795CC1F000FF@smtp.kernel.org>
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
- [Critical] drm/virtio: PRIME export of RDONLY userptr allows writable DMA=
 mapping
--

commit 5d368a790c7066062061e9164c64d6e00b653f96
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr support into the virtio GPU blob resource
creation ioctl. It adds userptr flags to the allowed mask, handles userptr
verification, and calls virtio_gpu_userptr_create() when requested.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..6d38483f5fd61 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -36,7 +36,9 @@
> =20
>  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>  				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> -				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> +				    VIRTGPU_BLOB_FLAG_USE_USERPTR | \
> +				    VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)

[Severity: Critical]
By exposing VIRTGPU_BLOB_FLAG_USERPTR_RDONLY to userspace, does this allow =
an
unprivileged local user to bypass write protection on read-only pages via
PRIME export?

Looking at virtio_gpu_userptr_funcs in
drivers/gpu/drm/virtio/virtgpu_userptr.c, .export is exposed for userptr
objects:

drivers/gpu/drm/virtio/virtgpu_userptr.c:
static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs =3D {
	.open =3D virtio_gpu_gem_object_open,
	.close =3D virtio_gpu_gem_object_close,
	.free =3D virtio_gpu_userptr_free,
	.export =3D virtgpu_gem_prime_export,
	.get_sg_table =3D virtio_gpu_userptr_get_sg_table,
};

And in virtio_gpu_userptr_get_pages() within the same file, it only pins wi=
th
FOLL_WRITE if read-only is not set:

drivers/gpu/drm/virtio/virtgpu_userptr.c:virtio_gpu_userptr_get_pages()
	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY))
		flag |=3D FOLL_WRITE;

If a user maps a read-only file into memory, creates a virtgpu blob resource
using VIRTGPU_BLOB_FLAG_USE_USERPTR and VIRTGPU_BLOB_FLAG_USERPTR_RDONLY, a=
nd
then exports it via DRM_IOCTL_PRIME_HANDLE_TO_FD while requesting DRM_RDWR,
does this allow the user to import this dma-buf into another device and
perform DMA writes to it?

This appears to circumvent the read-only pinning constraints when the resul=
ting
sg_table is shared via PRIME and modified by an unaware importer, potential=
ly
leading to arbitrary code execution or local privilege escalation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D4
