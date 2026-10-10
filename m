Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5B4CA6017
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E1A10E848;
	Sat, 10 Oct 2026 08:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GdhVJcB8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6302910E848
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:25:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19F81413AA;
 Sat, 10 Oct 2026 08:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7A81F000FF;
 Sat, 10 Oct 2026 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791620738;
 bh=x+4satxCSpiRaEjVG+1jUwCcdCWkA6udaR3PPJ5co4E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GdhVJcB8X99tCAdmMJ/PPvO94Z4fM19jVvATvTL3tvzz1W+2NY5cqLQBeYgLDK4od
 CBCGSdWgOKtU1Yey0bikwV/pzDWhqs2nY7WUl+YHMz7C6tViSEvhFXtRUh5ja6uSr2
 GJWYOXeQWuBEtfU2B98LQDjuSjcBAnPU9JT2LP1MzYiMjqZWKuFRD4H6WbzJMb/RPA
 wj8WSnsgi7NyKOnZzf8u8C733WmFFvZ/whHZjQvyZzkqw6qEmxXGFNrqu6MGyxvQ+T
 aIcpnCkqlh5T7hImziGAGAEHQJsZwzsisdKENjS3DUD6rooummJ6VaE7aAccJB2Zni
 ZmqiObM+4fU8w==
Message-ID: <sashiko-outbox-166346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: reject mappable HOST3D blobs without
 host-visible memory
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
References: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 08:25:37 +0000
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

> virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
> blob flags, memory type, context and alignment, but never checks
> VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.
>=20
> For blob_mem =3D=3D VIRTGPU_BLOB_MEM_HOST3D the blob is created via
> virtio_gpu_vram_create(), and on a device without host-visible
> memory (plain virtio-gpu-pci,blob=3Don with no hostmem) the failure
> comes too late: the GEM object has been allocated, a host resource
> id taken and the create_blob command issued when
> virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
> virtio_gpu_vram_free(), which is a no-op while bo->created is still
> false (the host response has not been processed yet).  Every such
> blob creation permanently leaks the vram object and its resource
> id; /dev/dri/renderD* is reachable by unprivileged users.
>=20
> Guest-backed blobs (VIRTGPU_BLOB_MEM_GUEST and
> VIRTGPU_BLOB_MEM_HOST3D_GUEST) mmap through the shmem path and do
> not need host-visible memory, so only the HOST3D case is rejected.
>=20
> Commit 036d28db1818a ("drm/virtio: release the GEM object on
> virtio_gpu_vram_create() errors") fixed the sibling error paths but
> missed this one.  Reject the impossible combination at ioctl entry,
> making the failure mode unreachable.
>=20
> This issue was discovered by Tencent CodeBuddy Security.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vra=
m object")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010081059.3096=
312-1-bsdhenrymartin@gmail.com?part=3D1

