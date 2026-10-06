Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAB3CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 15:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890F310E0C7;
	Tue,  6 Oct 2026 15:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C25TW2CR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E485310E0C7
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 15:58:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3A9C601E4;
 Tue,  6 Oct 2026 15:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E92A1F0089B;
 Tue,  6 Oct 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791302332;
 bh=8y6kLm/9r36/kdchitA/wVasVsQZyBMPrWtVK3TeBa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C25TW2CR+Z1UkmiMJoUTQTubXxG0Vf/aYuzMLAqgnN+VylwXB56PUdqbTMBzFGllI
 LOrKUZBViSR4fvoXUWTZ8K0rJRTR/fRMyaLcz3cdBjcdwUoGKmMRzmHLcESe2M1Fpi
 imfA4pdc6hkx3GMnRAR1IOS6jy9rYJQFwIvTPP3kd9LgUK9j3akoOODa8oSBk34sJc
 LNHSGu1DGlO7bwvjQamGRFvxpKP+0mDvxshifoUp6CTEahQ6aHKwFpST5EMfSHbahb
 k0kNmUZHsVangptJLiZvsr7wwCCyRkdhZjNceOIuC0RVBFdxguOgwnu0AQYXgYzHhR
 Cq/NbFu46lPJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: "Val Packett" <val@invisiblethingslab.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261006154913.2689067-2-val@invisiblethingslab.com>
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:58:52 +0000
Message-Id: <20261006155852.5E92A1F0089B@smtp.kernel.org>
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
- [Medium] drm/virtio: blob size alignment check is bypassed for 2D devices
--

commit e9be6e8827fcf796e95413bb22d054eb21acf9b4
Author: Val Packett <val@invisiblethingslab.com>

drm/virtio: do not enforce blob_alignment in cross-domain contexts

This commit stops enforcing blob_alignment requirements in cross-domain
contexts. Resources created under these contexts are arbitrary shared system
memory files rather than GPU rendering contexts, so alignment is no longer
strictly enforced.

Link: https://lore.kernel.org/all/20261006004044.2242154-1-val@invisiblethi=
ngslab.com/

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 81e70a12b3569..c28534593b2f4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -539,7 +539,9 @@ static int verify_blob(struct virtio_gpu_device *vgde=
v,
>  	params->blob_flags =3D rc_blob->blob_flags;
>  	params->blob_hints =3D rc_blob->blob_hints;
> =20
> -	if (vgdev->has_blob_alignment &&
> +	if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
> +	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=3D
> +	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
>  	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>  		return -EINVAL;

[Severity: Medium]
Does adding the vgdev->has_virgl_3d check here completely bypass the size
alignment validation for 2D devices?

If has_virgl_3d is false, the condition short-circuits and skips the
IS_ALIGNED() check entirely. This seems to allow userspace to request
unaligned blob sizes on non-3D devices, which could potentially cause
host-side errors or command rejection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006154913.2689=
067-2-val@invisiblethingslab.com?part=3D1
