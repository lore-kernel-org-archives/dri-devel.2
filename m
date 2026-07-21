Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D83C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108A210EA82;
	Tue, 21 Jul 2026 15:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYDr7RAp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B0F10EA64
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:16:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8BE5600D8;
 Tue, 21 Jul 2026 15:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467FB1F00A3A;
 Tue, 21 Jul 2026 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784646975;
 bh=kUeHdoFi5d37CX8YFNFwEXcBDYUB3952afpr3sB+tBQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eYDr7RApalGwMqHPvKJJwM/iijEdvSqGQ3sp4NXH87hiAdG3XKaTBj6+OD2ghVLA7
 2MtJLaEqlqErVT3bx5T+ZlLrKQi/I+3ge5ac87MhxGiJ4V/D7YM5G4csTuq8zEuVKs
 f4BzvcIaHeP4qhvwVR+e3LWT7SW+DgPvIf0Dh5uDePBGqZAZH1CM99x5jczYcaV2fZ
 UqMfkg1pz+xkvCC4i6CVwfULPzyoHG+E3EB1ptpJp8jeWJP7bSQNIhI55qZpyUuVkv
 jPMVYjExUg8WaSnW+Y/wVFBkBUAyAqMBrt2UPnHfxoz9YbvDoLIjSQrMBM/x06ShL1
 ep2NWNlWFM41A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Remove usage of drm_simple_encoder_init()
To: liutianyi2211@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721162114.471692-1-liutianyi2211@gmail.com>
References: <20260721162114.471692-1-liutianyi2211@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 15:16:14 +0000
Message-Id: <20260721151615.467FB1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the return value=
s from DRM object initialization functions (`drm_connector_init` and `drm_e=
ncoder_init`) are ignored. When replacing `drm_simple_encoder_init` with `d=
rm_encoder_init`, the error code returned by the initialization function co=
ntinues to be discarded.
--

--- Patch [1]: [PATCH] drm/virtio: Remove usage of drm_simple_encoder_init(=
) ---
commit 8109d37cb7e4ad300368c323487228873cfe6959
Author: Tianyi Liu <liutianyi2211@gmail.com>

drm/virtio: Remove usage of drm_simple_encoder_init()

This patch removes the deprecated drm_simple_encoder_init() helper function=
.=20
It replaces it with a direct call to drm_encoder_init() and introduces a=20
drm_encoder_funcs structure to handle cleanup.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/v=
irtio/virtgpu_display.c
> index 44ffffec550fd..048c195432183 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c

[ ... ]

> @@ -306,7 +310,8 @@ static int vgdev_output_init(struct virtio_gpu_device=
 *vgdev, int index)
>  	if (vgdev->has_edid)
>  		drm_connector_attach_edid_property(connector);
> =20
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
> +	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs_cleanup,
> +				DRM_MODE_ENCODER_VIRTUAL, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but the return value of
drm_encoder_init() appears to be ignored here.

If drm_encoder_init() fails, such as during memory pressure or ID exhaustio=
n,
the driver continues execution with partially initialized DRM objects.
Could this lead to kernel oopses if uninitialized mutexes or lists are
subsequently accessed during hotplug events or driver teardown?

Looking just above this in vgdev_output_init(), drm_connector_init() also
ignores its return value. Should we capture these error codes and return th=
em
to ensure robust error handling?

>  	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
>  	encoder->possible_crtcs =3D 1 << index;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721162114.4716=
92-1-liutianyi2211@gmail.com?part=3D1
