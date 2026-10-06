Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8255ECA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B1F10E1D5;
	Tue,  6 Oct 2026 00:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QdLv2lDk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77A810E1D5
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 00:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03918601F1;
 Tue,  6 Oct 2026 00:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E821F000FF;
 Tue,  6 Oct 2026 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791248032;
 bh=nZyWsuZ29X2XjD5qUL3PY1cLlVg7igHjAZzuJpMN4rU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QdLv2lDk/b4OVrPWre/WwQ+NPyhC1mAgJJjxNUsce5T61RC9G/rT7yfTsBasaFTfX
 LqTG9iZdyPdPZzrgMX5Pnx9nacRQCBz7J+n3GhItqB2aPH2KFrfsxn91wgM6tA+dbT
 i62Klv6xYIJrYSVo+QSbvkTvpzAMIqn3xMSG4OnB3sCRdiFubx1XHP4ud9LnaZ8Lvc
 KxcKqSt/yzRrGAgFA6HLVQjHnz0ZuH9OHJlDbYQDHZl1BVowxPu26kyn2i6GiQR1/w
 lCSDLSzbEoDTwZT7ruypdExqtVqbZk/HVwl4bizP8v+0cDlANsgQL3LUaDPNMXoGzg
 doepAKHknnSPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: "Val Packett" <val@invisiblethingslab.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261006004044.2242154-1-val@invisiblethingslab.com>
References: <20261006004044.2242154-1-val@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:53:52 +0000
Message-Id: <20261006005352.77E821F000FF@smtp.kernel.org>
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
- [Critical] drm/virtio: NULL pointer dereference in verify_blob() when 3D =
features are disabled
- [Medium] drm/virtio: data race when reading vfpriv->context_init in verif=
y_blob()
--

commit e614dba4f51f24b9effac7458783e310e89be777
Author: Val Packett <val@invisiblethingslab.com>
drm/virtio: do not enforce blob_alignment in cross-domain contexts

The commit prevents enforcing blob_alignment requirements in cross-domain
contexts, as resources created there are arbitrary shared system memory fil=
es
like Wayland keymaps.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -540,6 +540,8 @@ static int verify_blob(struct virtio_gpu_device *vgde=
v,
>  	params->blob_hints =3D rc_blob->blob_hints;
> =20
>  	if (vgdev->has_blob_alignment &&
> +	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=3D
> +	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&

[Severity: Critical]
If a virtio-gpu device advertises VIRTIO_GPU_F_RESOURCE_BLOB and
VIRTIO_GPU_F_BLOB_ALIGNMENT but not VIRTIO_GPU_F_VIRGL, could this cause a
NULL pointer dereference?

In this scenario, virtio_gpu_driver_open() returns successfully but leaves
file->driver_priv (which is passed as vfpriv) as NULL. When userspace then
calls DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB with VIRTGPU_BLOB_MEM_GUEST,
verify_blob() is reached without aborting on the has_virgl_3d check.

This newly added code will then unconditionally dereference
vfpriv->context_init because vgdev->has_blob_alignment is true, causing a
kernel panic. Is there a way to verify vfpriv is not NULL before accessing
context_init?

[Severity: Medium]
Does this introduce a data race when reading context_init?

This accesses the lock-protected context_init field without acquiring
vfpriv->context_lock. A lockless read of context_init could read a partially
written bitmask if updated concurrently, leading to incorrectly enforcing or
bypassing blob alignment checks and returning spurious -EINVAL to userspace.

This could happen if userspace calls DRM_IOCTL_VIRTGPU_CONTEXT_INIT and
DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB concurrently on the same file
descriptor.

>  	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006004044.2242=
154-1-val@invisiblethingslab.com?part=3D1
