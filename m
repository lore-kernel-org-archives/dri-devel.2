Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4515BC53200
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18E510E0CB;
	Thu, 30 Jul 2026 01:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RgA4Ofvd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479BD10E0CB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:24:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82A16600AA;
 Thu, 30 Jul 2026 01:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8AD1F000E9;
 Thu, 30 Jul 2026 01:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785374664;
 bh=aFycUevV72wzgCKf940sOou5NBRIMZ4LHZKmn+PqUqA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RgA4Ofvd3ccLKutHWH3hB/7axu2GzM5uNiKwlX9tPl4n/RYbCOY5JXAgrgs53B+SF
 rUaoTei8PL3xyM7asTlfKHGk0I+CeJ1X0LgKOyGLZwVYM+/GQEnYmP81ewIiu9QvHn
 izckrYbmrQiZuWF2R4ILQ1IInIg6yIuWzbBWjt9Tw5QrKZrp9eLADKkTC4GZMllePN
 30btzgCajxWWYRT+ctby2Bfkh1H/852NSsRei2ULXKm431o4WuSM5arqHkMi3nUdnK
 qgHCvP3nV1fERy3u7ZbCS/2toU3PuEI8E71qJlPgBXv3DAJQ8K2RwrbDKMO1orAfHy
 L2e4UbtlGXl+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/nouveau/kms: Only allow enabling atomic
 modesetting on nv50+
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730010828.1056397-4-lyude@redhat.com>
References: <20260730010828.1056397-1-lyude@redhat.com>
 <20260730010828.1056397-4-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:24:23 +0000
Message-Id: <20260730012424.0F8AD1F000E9@smtp.kernel.org>
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
- [High] Incorrect comparison of `chipset` against a `family` enum constant=
 (`NV_DEVICE_INFO_V0_TESLA`) fails to restrict atomic modesetting to NV50+ =
hardware.
- [Medium] Conditionally mutating the shared global `driver_pci` structure =
based on a per-device property causes state bleed across multiple heterogen=
eous GPUs.
--

--- Patch [3]: [PATCH 3/4] drm/nouveau/kms: Only allow enabling atomic mode=
setting on nv50+ ---
commit 5cd5776223b538bc498c01f641307f514607e91c
Author: Lyude Paul <lyude@redhat.com>
drm/nouveau/kms: Only allow enabling atomic modesetting on nv50+

This patch aims to prevent atomic modesetting from being forced on for
pre-nv50 chipsets. It adds a hardware generation check before enabling
the atomic driver feature.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -770,8 +770,12 @@ nouveau_drm_device_new(struct drm_driver *drm_driver=
, struct device *parent,
>  		goto done;
>  	}
> =20
> -	if (nouveau_atomic)
> -		driver_pci.driver_features |=3D DRIVER_ATOMIC;
> +	if (nouveau_atomic) {
> +		if (drm->device.info.chipset >=3D NV_DEVICE_INFO_V0_TESLA)

[Severity: High]
Does this comparison correctly identify NV50+ hardware?

The chipset field stores the hardware hex ID (e.g., 0x10 for NV10, 0x40 for
NV40), while NV_DEVICE_INFO_V0_TESLA is an architectural family enum defined
as 0x06.

Because legacy values like 0x10 and 0x40 are numerically greater than 0x06,
will this condition incorrectly evaluate to true for pre-nv50 hardware when
nouveau.atomic=3D1 is set?

> +			driver_pci.driver_features |=3D DRIVER_ATOMIC;

[Severity: Medium]
Is it safe to mutate the static global driver_pci structure here?

If a user has a heterogeneous multi-GPU setup (e.g., an NV50+ and an NV40)
and boots with nouveau.atomic=3D1, the NV50+ might probe first and append
DRIVER_ATOMIC to the global driver_pci.driver_features mask.

Will a subsequently probed legacy GPU inherit this mutated capability flag
since it shares the driver_pci template?

> +		else
> +			NV_WARN(drm, "Atomic modesetting not supported (needs nv50+)\n");
> +	}
> =20
>  	ret =3D nvif_device_map(&drm->device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730010828.1056=
397-1-lyude@redhat.com?part=3D3
