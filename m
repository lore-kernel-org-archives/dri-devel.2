Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5117AC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DB610EF75;
	Wed,  9 Sep 2026 07:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ciYnLxaG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EE910EF75
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:44:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0A45601FD;
 Wed,  9 Sep 2026 07:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658241F00A3A;
 Wed,  9 Sep 2026 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788939878;
 bh=tixwgiWwREE+e/O+XQzoT2C82NYobPgNbFeLqiM0sjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ciYnLxaGp3aO4UD5fLXeNL0fOiiO/AOgzouPf2HJ/wQUowsaovGKMY6XFFuL43Ob7
 o9xC2R+xVa4sXg4ISf/yWQta+Vpqtd2J4l4too9g86odZry/9p3ZhfGg2KMQxpn9Zi
 jKcGwgKrbDD9PXO/t5UKJf22EXhBdUoOCZ5abD1e+Z8UOFKYWTwO37hE9vRSLsqaPs
 ZbxYvOIgKZH+jexfUuiO4JDJJDX2S/MY9DSYyMFWhfaVNGfAzN1Pc46hbU4Rsa1/uD
 Eqfu/O/AwPodNgJSsLbRjDb6ZcO/3ialglSt7C4NP+G1GfVdXyLfB0MN41Pv52c39h
 Y2CDLw1SDgVSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Replace deprecated drm_simple_encoder_init()
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909073440.52641-1-bonatto.davide@gmail.com>
References: <20260909073440.52641-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 07:44:37 +0000
Message-Id: <20260909074438.658241F00A3A@smtp.kernel.org>
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
- [Medium] Missing error check for drm_encoder_init return value.
--

commit 731688e34b570f6cb070588f1d74f9b42481123c
Author: Davide Bonatto <bonatto.davide@gmail.com>

drm/virtio: Replace deprecated drm_simple_encoder_init()

This patch replaces the deprecated drm_simple_encoder_init() with a direct
call to drm_encoder_init(), defining a default cleanup callback directly in=
=20
virtio_gpu_encoder_funcs.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/v=
irtio/virtgpu_display.c
> index a1a875a0c706a..85986578001fe 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c

[ ... ]

> @@ -306,7 +310,9 @@ static int vgdev_output_init(struct virtio_gpu_device=
 *vgdev, int index)
>  	if (vgdev->has_edid)
>  		drm_connector_attach_edid_property(connector);
> =20
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
> +	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
> +		DRM_MODE_ENCODER_VIRTUAL, NULL);

[Severity: Medium]
Does this code need to check the return value of drm_encoder_init()?

If drm_encoder_init() fails (for example, due to a memory allocation failur=
e=20
for the encoder name), it returns a negative error code like -ENOMEM and=20
cleans up the partially initialized object.

Since this return value is not validated in vgdev_output_init(), the functi=
on=20
will proceed to use the uninitialized encoder, attaching it to a connector =
and=20
registering the connector with userspace. Could this lead to a NULL pointer=
=20
dereference or corrupted state when the DRM subsystem interacts with it?

> +
>  	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
>  	encoder->possible_crtcs =3D 1 << index;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909073440.5264=
1-1-bonatto.davide@gmail.com?part=3D1
