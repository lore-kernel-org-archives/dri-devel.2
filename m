Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92AEC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CB410F06C;
	Wed, 12 Aug 2026 15:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K5ovYbZm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291DC10F06C
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:24:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36CAC60A7D;
 Wed, 12 Aug 2026 15:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77781F000E9;
 Wed, 12 Aug 2026 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786548267;
 bh=e2fIeAxmTvc1hqWGdYyd2mdQM2P8bCdjdd0uu+xUSSQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K5ovYbZm5+RrVT01kENJhIvZ+wTqfij1kV1c88C3EFIsSZgDxMZ2aaXWWtYomB//a
 QhM3c/32Is+o04sMd7XafscEbfCAToPH9Lo26AUXXeqArovKfmzWg4gnUaU42e90r0
 j6slH4M8u8PN1j8kp+8EDiGAr92wrznPP/GsKRY4mxf4xDZQ0hsE3iAbr0dvzkr95B
 YHIJ1P4lGUR85hmTRviV4ImyXYSMLqfjHTzF8DzBFmYI2JDrpsuIqrHWvJAXw05ko4
 1I0nQnu5ta+HXpnbaftdBLSKWiYtSxZ8Tt3UAALFYGXr+20Zl8U7o1FZYvOfoQeS3m
 YuKBTWFagDWuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/amdgpu: add Apple GMUX runtime PM support
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812144221.35877-3-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812144221.35877-1-dev@deq.rocks>
 <20260812144221.35877-3-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:24:27 +0000
Message-Id: <20260812152427.B77781F000E9@smtp.kernel.org>
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

New issues:
- [Medium] State leak on runtime PM error paths for GMUX and PX devices.

Pre-existing issues:
- [High] BOCO capability checks incorrectly overlap with PX mode, breaking =
system suspend.
--

--- Patch [2]: [PATCH v2 2/3] drm/amdgpu: add Apple GMUX runtime PM support=
 ---
commit 0b96cccee1dc38f37893eddd321b413c6829882e
Author: Andre Eikmeyer <dev@deq.rocks>
Subject: drm/amdgpu: add Apple GMUX runtime PM support

This commit adds runtime PM support for the discrete GPU on the Apple
MacBookPro15,1 using the vga_switcheroo PM domain. It allows the dGPU
to enter D3cold while the iGPU is primary and wake on demand.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e645..a231a002831bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2494,11 +2494,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> =20
>  	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> -		/* only need to skip on ATPX */
>  		if (amdgpu_device_supports_px(adev))
>  			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> -		/* we want direct complete for BOCO */
> -		if (amdgpu_device_supports_boco(adev))
> +		/* BOCO and GMUX can remain runtime suspended across system sleep. */
> +		if (amdgpu_device_supports_boco(adev) ||
> +		    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)

[Severity: High]
This is a pre-existing issue, but does this direct capability check for BOCO
incorrectly evaluate to true for hybrid devices? If a device supports both
PX (ATPX) and BOCO capabilities, it seems amdgpu_device_supports_boco()
will return true in amdgpu_pci_probe(), overwriting the
DPM_FLAG_NO_DIRECT_COMPLETE flag just set for PX.

>  			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
>  						DPM_FLAG_SMART_SUSPEND |
>  						DPM_FLAG_MAY_SKIP_RESUME);
[ ... ]
> @@ -2609,7 +2610,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
>  	/* Return a positive number here so
>  	 * DPM_FLAG_SMART_SUSPEND works properly
>  	 */
> -	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
> +	if ((amdgpu_device_supports_boco(adev) ||
> +	     adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX) &&
> +	    pm_runtime_suspended(dev))

[Severity: High]
This is a pre-existing issue, but does this capability check erroneously
instruct the PM core to skip system suspend and resume for a PX-designated
device? If the device supports both PX and BOCO, returning 1 here in
amdgpu_pmops_prepare() will skip system suspend, which ATPX explicitly
requires.

>  		return 1;
> =20
>  	/* if we will not support s3 or s2i for the device
[ ... ]
> @@ -2872,7 +2875,8 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>  	}
> =20
>  	adev->in_runpm =3D true;
> -	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
> +	    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
>  		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
> =20
>  	/*
[ ... ]
>  	ret =3D amdgpu_device_prepare(drm_dev);
>  	if (ret)
>  		return ret;
>  	ret =3D amdgpu_device_suspend(drm_dev, false);
>  	if (ret) {
>  		adev->in_runpm =3D false;
>  		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
>  			adev->mp1_state =3D PP_MP1_STATE_NONE;
>  		return ret;
>  	}

[Severity: Medium]
If amdgpu_device_suspend() fails later in amdgpu_pmops_runtime_suspend(),
is drm_dev->switch_power_state left permanently in
DRM_SWITCH_POWER_CHANGING?=20

The early return on failure does not appear to restore the previous power
state, and this state leak now applies to the GMUX path as well.

[ ... ]
> @@ -2947,10 +2952,11 @@ static int amdgpu_pmops_runtime_resume(struct dev=
ice *dev)
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access =3D true;
> =20
> -	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
> +	    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX) {
>  		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
> =20
> -		/* Only need to handle PCI state in the driver for ATPX
> +		/* Only need to handle PCI state in the driver for ATPX and GMUX.
>  		 * PCI core handles it for _PR3.
>  		 */
>  		pci_set_power_state(pdev, PCI_D0);
> @@ -2970,12 +2976,14 @@ static int amdgpu_pmops_runtime_resume(struct dev=
ice *dev)
>  	}
>  	ret =3D amdgpu_device_resume(drm_dev, false);
>  	if (ret) {
> -		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> +		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
> +		    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
>  			pci_disable_device(pdev);
>  		return ret;
>  	}

[Severity: Medium]
If either pci_enable_device() or amdgpu_device_resume() fails and returns
early in amdgpu_pmops_runtime_resume(), does this leave
drm_dev->switch_power_state permanently set to DRM_SWITCH_POWER_CHANGING,
since the failure paths do not restore it?

> -	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
> +	    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
>  		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
> =20
>  	amdgpu_restore_umd_profile_pstate_after_runpm(adev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812144221.3587=
7-1-dev@deq.rocks?part=3D2
