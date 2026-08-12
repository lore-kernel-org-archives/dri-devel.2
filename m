Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747DFC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C078410EEF5;
	Wed, 12 Aug 2026 12:48:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d9RfLf9C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB28310EEF5
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:48:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89B1B4178C;
 Wed, 12 Aug 2026 12:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E471F000E9;
 Wed, 12 Aug 2026 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786538916;
 bh=1eVNii1i3p0JVosuG0kyUAOJEwMfA9B22uv64rpVp4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d9RfLf9Cl1wfwT/nR3g1DaN01xjIOIocvB+Pmv+L4g8RwAI8VDE3eaMG/9bGbzfyA
 4b4MhkqTQoWFxd/TkP1DXQ53G8b/Y7fOSoef1vPIvTwAWx+PrcDFVR94YFX3A9wYGC
 HUp+CneUJO9rF15STqbedSfsy3gPPAlxY7vHYd+YHEbhWgwQgzVZf6KOJXaV1ZUhWm
 WL3PpIvo/luwiHtw4lop68WMxirD0vrtUPLjihur+u1YwWT38kWsWDOnogEx1Dx7E6
 +dw8FuOH6EwTz++a+/E5jBRU9VdqJWNnbmiabIt/6VSdKCT/7CiBCg7AxPcWc7S12h
 dA6NhutBPQCog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amdgpu: add Apple GMUX runtime PM support
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812122206.193680-3-dev@deq.rocks>
References: <20260812122206.193680-1-dev@deq.rocks>
 <20260812122206.193680-3-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:48:34 +0000
Message-Id: <20260812124836.27E471F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but switch_power_sta=
te remains permanently stuck in DRM_SWITCH_POWER_CHANGING on suspend/resume=
 failure.
--

--- Patch [2]: [PATCH 2/3] drm/amdgpu: add Apple GMUX runtime PM support ---
commit 2067ef2b3a267308c80f88d728f87fe7fad945a3
Author: Andre Eikmeyer <dev@deq.rocks>

    drm/amdgpu: add Apple GMUX runtime PM support
   =20
    The MacBookPro15,1 uses Apple GMUX to control power to the discrete GPU,
    but it does not expose the ATPX or ACPI power-resource interfaces curre=
ntly
    recognized by amdgpu. The driver therefore leaves runtime PM disabled e=
ven
    though vga_switcheroo can switch the GPU reliably.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e645..a231a002831bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
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

[Severity: High]
This is a pre-existing issue, but I noticed that switch_power_state can be
left permanently stuck in DRM_SWITCH_POWER_CHANGING if a failure occurs her=
e.

Looking at amdgpu_pmops_runtime_suspend(), if amdgpu_device_suspend() fails,
it returns early:

	ret =3D amdgpu_device_suspend(drm_dev, false);
	if (ret) {
		adev->in_runpm =3D false;
		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
			adev->mp1_state =3D PP_MP1_STATE_NONE;
		return ret;
	}

Because switch_power_state is never reset on this error path, drm_open()
will explicitly reject new opens by returning -EINVAL. Does this mean a
failed runtime suspend renders the GPU completely unusable for new clients
until reboot?

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

[Severity: High]
This is also a pre-existing issue, but the same state machine corruption can
occur during resume.

If either pci_enable_device() or amdgpu_device_resume() fails, the function
returns without resetting switch_power_state from DRM_SWITCH_POWER_CHANGING:

	ret =3D amdgpu_device_resume(drm_dev, false);
	if (ret) {
		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
		    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
			pci_disable_device(pdev);
		return ret;
	}

Would it be safer to restore switch_power_state on these error paths so
that the state isn't permanently stuck?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812122206.1936=
80-1-dev@deq.rocks?part=3D2
