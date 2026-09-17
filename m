Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE2CC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3482010ED64;
	Thu, 17 Sep 2026 10:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OsQ7N44W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C9A10ED4A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:34:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3180A6022E;
 Thu, 17 Sep 2026 10:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F271F000FF;
 Thu, 17 Sep 2026 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789641277;
 bh=A5vZJgu6y0sFszhGK8CduL/HbXSIZ/z1c/boerVDM2M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OsQ7N44Wkcxo01qpGvDlqi5QGTlzb1ttT2HN2hJ3kWJlZWs4EZCUMMgG7xdEcj7HR
 5V2/PYnObXYH3tCY1jsiDS6WPcvcPj2760OpsCKb6sYFqUhowAbtKS6WrSBPu/Zf46
 qMVjFlKDCM3owrnduoroh8A+pWo+ML7TouJBNns7YfZsqPDgNE7K134N1B4XyE6VBi
 sTVp+MhM1TO4MElm/OgYpdysH6jp7EXzvuX6HQUIh61v8ma3Z3iScPfWRTHTvVNQbF
 KGB19gBp3Ejqk2Gfgzb/Gi3XpnLcp6TxjSdgOF3IjqgRvoTlWdFApv0MSXxKcO+wre
 B9izSKiq0p8yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] drm/virtgpu api: add blob userptr resource
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260917102540.1312102-3-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:34:37 +0000
Message-Id: <20260917103437.92F271F000FF@smtp.kernel.org>
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
- [High] virtio-gpu: guest-only blob flags leaked to host breaking wire ABI
--

commit ce150cb1a68528e491d40b28c03376311a653c0c
Author: Honglei Huang <Honglei1.Huang@amd.com>

drm/virtgpu api: add blob userptr resource

This commit adds DRM ioctl flags and a userptr field to allow userspace
to request a blob backed by an existing process mapping. It introduces
guest-only flags VIRTGPU_BLOB_FLAG_USE_USERPTR and
VIRTGPU_BLOB_FLAG_USERPTR_RDONLY for guest pin behavior.

> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_dr=
m.h
> index 95587e12aed57..6171b4e2300b1 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -186,6 +186,9 @@ struct drm_virtgpu_resource_create_blob {
>  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +/* Guest-only flags */
> +#define VIRTGPU_BLOB_FLAG_USE_USERPTR      0x0008
> +#define VIRTGPU_BLOB_FLAG_USERPTR_RDONLY   0x0010

[Severity: High]
Do these guest-only flags leak to the host and break the virtio wire ABI?

When userspace calls the DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB ioctl,
verify_blob() assigns rc_blob->blob_flags directly to params->blob_flags.
This struct is passed to virtio_gpu_userptr_create(), which calls
virtio_gpu_cmd_resource_create_blob().

In virtio_gpu_cmd_resource_create_blob(), the flags are written directly to
the command without masking:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_resource_create_blob() {
    ...
    cmd_p->blob_flags =3D cpu_to_le32(params->blob_flags);
    ...
}

If these guest-only flags are not masked out before being sent to the host,
will strict hosts reject the command with an error, making the userptr
feature unusable?=20

I noticed this wire ABI violation appears to remain unfixed at the end of
the patch series (commit 357076bf581c).

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102540.1312=
102-1-honghuan@amd.com?part=3D2
