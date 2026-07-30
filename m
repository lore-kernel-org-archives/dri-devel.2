Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D635CC53200
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDBC10E0C6;
	Thu, 30 Jul 2026 01:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AkgDI34q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5450810E0C6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:21:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 795AD600B1;
 Thu, 30 Jul 2026 01:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0653C1F00A3A;
 Thu, 30 Jul 2026 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785374486;
 bh=eDTZqcpVKQoSzc3yqZg1Ri1HZldUAQN5/db6mrN/9Us=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AkgDI34qE46XpykSVAa5roNdAUj/NzQawWzqJj3RI5lz6iPJuIokzzaWUfA/1EVO4
 067WuBYXGVgFXWZMYTNJaQcd3oTVNFao5fzM8jheKPfhsW1Tl9IH9wz+c09XU+YeWh
 kF3dHMG9PP2dMEu57GIyMsnyBXG8vw+r6oe3Wf7kNcIOfNPYT7KoQ8ziJmRbLJ3CVT
 r+q2BGqF/2WD03llRrr+kWt+bCp1ZwIJb7tniWkqPMW5PRxF9521ujVY1rcP4+FFMR
 lmTfBFPo74ifN31M0ctNWopuRwftNNiVMSNyF6vjVvhnQnvA/H6LSkMxTzsAsLRRfd
 fMHMcmIAl+mUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/nouveau/kms/nv50-: Enable atomic modesetting by
 default
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730010828.1056397-5-lyude@redhat.com>
References: <20260730010828.1056397-1-lyude@redhat.com>
 <20260730010828.1056397-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:21:25 +0000
Message-Id: <20260730012126.0653C1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Dynamic mutation of the shared global `driver_pci` struct during d=
evice probe causes a data race, ignores the passed `drm_driver` parameter, =
and fails to enable atomic modesetting on non-PCI (e.g., Tegra platform) de=
vices.
- [High] Comparing the `chipset` field to the `NV_DEVICE_INFO_V0_TESLA` fam=
ily enum incorrectly enables atomic modesetting on unsupported pre-nv50 har=
dware.
--

--- Patch [4]: [PATCH 4/4] drm/nouveau/kms/nv50-: Enable atomic modesetting=
 by default ---
commit 2db79d2947cdc47fc30e7b1b87de35e2d70fb39d
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Enable atomic modesetting by default

Nouveau is one of the very few modern hardware drivers in the kernel that
doesn't have atomic modesetting enabled by default, in part because when it
was originally written by Ben there wasn't much in the way of good atomic
modesetting clients to actually test things out with.

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index b959d79f7e1c7..5580ac9c782ba 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -770,10 +771,10 @@ nouveau_drm_device_new(struct drm_driver *drm_drive=
r, struct device *parent,
>  		goto done;
>  	}
> =20
> -	if (nouveau_atomic) {
> +	if (nouveau_atomic !=3D 0) {
>  		if (drm->device.info.chipset >=3D NV_DEVICE_INFO_V0_TESLA)

[Severity: High]
This isn't a bug introduced by this patch, but changing the default of
nouveau_atomic to auto makes it active by default. In nouveau_drm_device_ne=
w()
in drivers/gpu/drm/nouveau/nouveau_drm.c, does this compare a chipset hex
identifier (e.g., 0x40 for NV40) against a family enum (0x06 for TESLA)?

Because 0x40 is greater than 0x06, this evaluates to true for unsupported o=
lder
hardware, forcing atomic modesetting on pre-nv50 hardware and breaking disp=
lay
support. Should this check use device.info.family instead of chipset?

>  			driver_pci.driver_features |=3D DRIVER_ATOMIC;

[Severity: High]
This is a pre-existing issue, but with nouveau_atomic active by default,
does dynamically mutating the shared global driver_pci struct during device
probe in nouveau_drm_device_new() cause a data race?

Modifying driver_pci pollutes the template for all subsequent PCI devices,
even if they do not meet the chipset requirements. Additionally, does this
ignore the passed drm_driver parameter, preventing atomic modesetting from
being enabled on Tegra platform devices (which use driver_platform)?

> -		else
> +		else if (nouveau_atomic =3D=3D 1)
>  			NV_WARN(drm, "Atomic modesetting not supported (needs nv50+)\n");
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730010828.1056=
397-1-lyude@redhat.com?part=3D4
