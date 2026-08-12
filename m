Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5721DC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E41D10F07D;
	Wed, 12 Aug 2026 15:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZz4D7yP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A5410F07D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D510760A7D;
 Wed, 12 Aug 2026 15:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620691F000E9;
 Wed, 12 Aug 2026 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786548622;
 bh=gLaQtWkayvU/paQLzOFkDyxh6qOJDN4vnCFBoehKcsc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MZz4D7yPd2Z4+nh4lE3uMy0hD7/JntvkozxPTxkW6j2MBthSibLSo9+KrgJx7eXFV
 sZn8n4Mq8OSJstlZIluI4szA7NtUqMg3vZrD20aAsz2u8oPMCxhIqctkJfIG+M+brs
 GYdxLtweATLjm29Fgb4uX9ZlJa301qh/17mhuUvIYOoIUnBHhL0lf3IyNEGYqjL3CZ
 WKnY4mRGxJPktsMFnUo2lYnwTsdTA4oQtCvzmHMSx/0V71qL0k5t+baSNYQzd5iyD7
 n5LTbllPgDZhaVEHQX7nhawoV7Fi7aFnbHFg6mwbqly99M6dxrLGdrWKiQuyj778Pj
 7Vvhmr2xlnXkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/amdgpu: add Apple GMUX runtime PM support
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812144750.36797-3-dev@deq.rocks>
References: <20260812144221.35877-1-dev@deq.rocks>
 <20260812144750.36797-1-dev@deq.rocks>
 <20260812144750.36797-3-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:30:21 +0000
Message-Id: <20260812153022.620691F000E9@smtp.kernel.org>
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
- [High] The system suspend and hibernation poweroff callbacks fail to hand=
le the runtime-suspended state for GMUX devices, leading to unhandled MMIO =
accesses on powered-off hardware if `direct_complete` is aborted.
--

--- Patch [2]: [PATCH v3 2/3] drm/amdgpu: add Apple GMUX runtime PM support=
 ---
commit bd409ba52fe58e23b69e9e8883bcbcd307329cae
Author: Andre Eikmeyer <dev@deq.rocks>
Subject: drm/amdgpu: add Apple GMUX runtime PM support

The MacBookPro15,1 uses Apple GMUX to control power to the discrete GPU,
but it does not expose the ATPX or ACPI power-resource interfaces currently
recognized by amdgpu. A dedicated GMUX runtime PM mode uses the existing
vga_switcheroo PM domain to sequence GPU power. A runtime-suspended GMUX GPU
can remain powered off across system sleep, following the smart-suspend
handling already used by BOCO devices.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e645..a231a002831bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c

[ ... ]

> @@ -2494,11 +2494,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> =20
>  	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> -		/* only need to skip on ATPX */
> +		/* ATPX requires a full system-sleep transition. */
>  		if (amdgpu_device_supports_px(adev))
>  			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> -		/* we want direct complete for BOCO */
> -		if (amdgpu_device_supports_boco(adev))
> +		/* BOCO and GMUX can remain runtime suspended across system sleep. */
> +		if (amdgpu_device_supports_boco(adev) ||
> +		    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
>  			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
>  						DPM_FLAG_SMART_SUSPEND |
>  						DPM_FLAG_MAY_SKIP_RESUME);

[Severity: High]
Does this setup require handling the runtime-suspended state in the system
suspend and hibernation callbacks for GMUX devices?

If a child device like the HDA audio controller aborts direct_complete for
the GPU, or if the GPU supports PME from D3cold, the PCI PM core will skip
runtime-resuming the GPU during system suspend.

This causes amdgpu_pmops_suspend() and amdgpu_pmops_poweroff() in
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c to be called while the GPU is still
in the D3cold state powered off by GMUX.

Since these callbacks unconditionally fall through to amdgpu_device_suspend=
()
without checking the runtime PM state:

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pmops_suspend() {
    ...
    return amdgpu_device_suspend(drm_dev, true);
}

and

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pmops_poweroff() {
    ...
    if (adev->in_s4 && adev->in_suspend)
        return 0;

    return amdgpu_device_suspend(drm_dev, true);
}

Could this lead to unhandled MMIO accesses on the powered-off hardware
during the suspension phase and cause system hangs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812144750.3679=
7-1-dev@deq.rocks?part=3D2
