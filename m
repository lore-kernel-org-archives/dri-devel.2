Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF21EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F3210EB42;
	Tue, 30 Jun 2026 08:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V+69oScx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A0E10EB42
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:58:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3545417C8;
 Tue, 30 Jun 2026 08:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA671F000E9;
 Tue, 30 Jun 2026 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782809882;
 bh=SQzmjj6XGxGp5/L+noMpxJBSDxqHjA5F2QoFOSEyxN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V+69oScxRF8fF+70oQSPjoMVbeOG4yQ4h4+qlDkfG3UJLLleiBPNLpdMuBzF4IGu7
 bKi16kibQjP8coWNNFk2mwANyujUqx/AJk9aMqtTMDY0gc0y1chvOQr/McxpBv6OTu
 UQ20pKEUtduP/RnPYhJ8dsdjGqvFn/Idn1CYy4FuMpRT36y29iEnMZErnl2Ssxojaj
 uBX5KcZikFviE035VdkAjcTCIKuG0MTvm5xc3XB+G8TE40gDCTE5S/pRthwd6WkXu5
 CsxI90Ro/Ccmzwb63PZKjvJjTmlxx3pwGzs6BmwsTNikNekENYinEyXLfqNn8Vt/bP
 nAnuNaJEgPH0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] drm/amdgpu: Add DRIVER_PLANE_COLOR_PIPELINE
 driver feature
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630084229.529682-3-robert.mader@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <20260630084229.529682-3-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:58:02 +0000
Message-Id: <20260630085802.ACA671F000E9@smtp.kernel.org>
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
- [High] Unconditional advertisement of DRIVER_PLANE_COLOR_PIPELINE breaks =
legacy YUV-to-RGB conversion on pre-DCN 3.0 hardware.
--

commit 0f146a9591dc47b975ea73aa0e04b2950fb4ede5
Author: Robert Mader <robert.mader@collabora.com>

drm/amdgpu: Add DRIVER_PLANE_COLOR_PIPELINE driver feature

Adds the DRIVER_PLANE_COLOR_PIPELINE feature to the AMDGPU kms driver
structure to satisfy requirements for DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3092,7 +3092,7 @@ static const struct drm_driver amdgpu_kms_driver =
=3D {
>  	    DRIVER_ATOMIC |
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ |
> -	    DRIVER_SYNCOBJ_TIMELINE,
> +	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_PLANE_COLOR_PIPELINE,

[Severity: High]
Does advertising this feature unconditionally break legacy YUV-to-RGB conve=
rsion
on pre-DCN 3.0 hardware?

When a DRM client enables DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE based on this
flag, the DRM core hides the legacy COLOR_ENCODING and COLOR_RANGE properti=
es.

However, looking at dm_plane_init_colorops(), the actual COLOR_PIPELINE
property is only initialized for newer hardware:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c:dm_plane_init_color=
ops()
    ...
    if (dc->ctx->dce_version >=3D DCN_VERSION_3_0) {
        ret =3D amdgpu_dm_initialize_default_pipeline(plane, &pipelines[len=
]);
    ...

If the replacement COLOR_PIPELINE property is not attached on older hardware
(like Polaris or Vega), and the legacy properties are hidden, userspace will
have no way to configure YUV-to-RGB conversion.=20

Should this capability only be exposed when the underlying hardware actually
supports and attaches the new pipeline properties?

>  	.open =3D amdgpu_driver_open_kms,
>  	.postclose =3D amdgpu_driver_postclose_kms,
>  	.ioctls =3D amdgpu_ioctls_kms,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630084229.5296=
82-1-robert.mader@collabora.com?part=3D2
