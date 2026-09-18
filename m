Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75AAC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4512B10F198;
	Fri, 18 Sep 2026 06:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VXev+GgA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033F310F198
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:12:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B452140170;
 Fri, 18 Sep 2026 06:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F11F000FF;
 Fri, 18 Sep 2026 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789711977;
 bh=jG4sd/kZjI59FKa4nokJHQfKl7x2bYtkVxMEDhRaFFU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VXev+GgANtfVD5e0mw5F/pER4v1Vt7Jacn8Gd15TKl284fSpppLvdLPg3TNtjir4L
 /GsjxkVGUD+RTWzMX8Tq8R4XI+5j1pbYlWUPDXoibrgSPi3q9w59OwKd9Nza6bPNG8
 ZM4y+EOdhnfFU0nHLOutRiDnB8v4NoFf67hzz5SnDB3DyARzdcisrBE+qcPacD94Ju
 zckdafr2Kf+sBUjrAWD+tpQopQCawuu0mJM9O1BypQwcDAktyBTOSgn4xj2+wvmzWT
 CkhL5k0+jmuqa9BkXC2+4ZjldQJcw6B1Wn+WeutPNh6b11nUsrNHJF5GTuwAJgIFqT
 QpQfEV3zG2gJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260918055917.2133574-5-honghuan@amd.com>
References: <20260918055917.2133574-1-honghuan@amd.com>
 <20260918055917.2133574-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:12:57 +0000
Message-Id: <20260918061257.793F11F000FF@smtp.kernel.org>
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
- [Critical] drm/virtio: host GPU can overwrite guest read-only memory via =
userptr
--

commit c5dbb2382bf8fa9c29656a9b3e8e517c49a15783
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr into the blob resource creation ioctl. It
accepts the userptr hints, validates them against the blob memory type,
and delegates creation to virtio_gpu_userptr_create().

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..225a550be00ca 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
[ ... ]
> @@ -538,7 +562,10 @@ static int virtio_gpu_resource_create_blob_ioctl(str=
uct drm_device *dev,
>  				      vfpriv->ctx_id, NULL, NULL);
>  	}
> =20
> -	if (guest_blob)
> +	if (guest_blob &&
> +	    (params.blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR))
> +		ret =3D virtio_gpu_userptr_create(vgdev, file, &params, &bo);

[Severity: Critical]
Does this code path allow the host GPU to overwrite guest read-only memory?

When the DRM_VIRTGPU_BLOB_FLAG_HINT_USERPTR_RDONLY hint is used, the guest
pins read-only physical pages (like shared libraries) by omitting FOLL_WRITE
in virtio_gpu_userptr_get_pages().

However, when virtio_gpu_userptr_create() delegates to the host:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_resource_create_blob() {
        ...
        cmd_p->blob_mem =3D cpu_to_le32(params->blob_mem);
        cmd_p->blob_flags =3D cpu_to_le32(params->blob_flags);
        ...
}

The blob_hints containing the RDONLY flag are never serialized to the host
in the virtio-gpu protocol. Since the host is unaware of the read-only
restriction, it treats the physical pages as writable. Can guest userspace
then submit 3D rendering commands to the host GPU to modify this read-only
memory, bypassing guest protections?

> +	else if (guest_blob)
>  		ret =3D virtio_gpu_object_create(vgdev, &params, &bo, NULL);
>  	else if (!guest_blob && host3d_blob)
>  		ret =3D virtio_gpu_vram_create(vgdev, &params, &bo);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918055917.2133=
574-1-honghuan@amd.com?part=3D4
