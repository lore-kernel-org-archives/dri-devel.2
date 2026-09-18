Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C38C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5653F10F191;
	Fri, 18 Sep 2026 06:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BqP6dFFK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E6810F191
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:16:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E4FA601EF;
 Fri, 18 Sep 2026 06:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2581F000FF;
 Fri, 18 Sep 2026 06:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789712175;
 bh=NC4MKgOXSOXLvcJNq54W3NpHgxlxE/yver/k3uh1wBA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BqP6dFFKIQHOSImWi2JX1kXw4ZV7XEf600F1+7Xeb82ness4d6fME8Q7RDINVf8mV
 BWgqrJzDNdkdHcBoNekrlAdEbZS0tGWAJE9gtOqO6Z3nzH58Pm2P6OvKhutNT5Cqzj
 DV4sjgD5DoTvgj2w24w/f3YsbnjMYnLHk4YijaID/FP4zdK9FqHfVuyAhxErHycCAX
 cI/yGXsWQiOd7XJ16zl2Ur8CpIlhSsLOtmvcBQQEk4oVg5/2c4RlsjTvfjfdfzwfjZ
 nlFD6Y6SUZgAAx4ZYvO5VOjiFwpblDcKDY/CV5n2H81HJxDVAPyt3XsjqlHfZCgcee
 +0xNbFSbUzk6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918055917.2133574-4-honghuan@amd.com>
References: <20260918055917.2133574-1-honghuan@amd.com>
 <20260918055917.2133574-4-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:16:14 +0000
Message-Id: <20260918061614.EC2581F000FF@smtp.kernel.org>
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
- [Critical] drm/virtio: privilege escalation via HINT_USERPTR_RDONLY
--

commit 20ea6ca5af258a43b1dc12cab535283738613d35
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/virtio: implement userptr support for zero-copy memory access

This commit adds userptr blob object support to virtio-gpu, allowing the
guest kernel to pin existing userspace mappings and use them as CREATE_BLOB
backing entries. It handles page pinning, DMA mapping if required, and
syncing the scatterlist for the device.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/v=
irtio/virtgpu_userptr.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
[ ... ]
> +static int
> +virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
> +{
> +	unsigned int flag =3D FOLL_LONGTERM;
> +	unsigned int num_pages, pinned =3D 0;
> +	int ret =3D 0;
[ ... ]
> +	if (!(userptr->flags & DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY))
> +		flag |=3D FOLL_WRITE;
> +
> +	do {
> +		num_pages =3D userptr->npages - pinned;
> +
> +		ret =3D pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
> +					  num_pages, flag,
> +					  userptr->pages + pinned);

[Severity: Critical]
Does this allow unprivileged userspace to bypass guest page protections?

If a malicious guest userspace maps read-only memory (such as executable
pages like libc.so) and passes it with
DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY, the code omits FOLL_WRITE when
calling pin_user_pages_fast.=20

The pinned physical addresses are then sent to the host. If the guest has no
vIOMMU (where virtio_gpu_use_dma_api() is false), these addresses are passed
directly to the host without DMA_TO_DEVICE IOMMU protection. The userspace
process could then submit a command stream via VIRTGPU_EXECBUFFER instructi=
ng
the host GPU to write to this resource, causing the host hypervisor to write
directly into the guest's read-only physical memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918055917.2133=
574-1-honghuan@amd.com?part=3D3
