Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27F606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEaUpSyi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C43D10E2CE;
	Mon,  9 Nov 2026 17:36:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513D410E2CE
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:36:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DEA561157;
 Mon,  9 Nov 2026 17:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17041F0089F;
 Mon,  9 Nov 2026 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794245785;
 bh=nsQYzaw5bFvoSoU0zeowIHQLxI+cVGY4HO/jZvgR+hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hEaUpSyiIKmPqBFz7rE2FCan61KZ5RDm1GixVuPwSvC2bWc2NReJaK4jZDTnkTCZu
 q3ckqetNNrAGZdppjjovoI2wsaF6lodqBG+u75pLhvwPrTLdOXW04AZ0d5uV41Wd4y
 ElxRXjikGVZ50AvKGC0AOPIP7m2czvi/58+He8tahWA7+tpnZSNu2/TPEcITu8s1qs
 PYquGDqn5+LWhwEkkXMs2QYAKkXto9YU78L27rJhnff/nuxowgnX1PYQnWqJd5LlIS
 1W4k6SuWxvXP1XW+c1+EHIvL8uxEr1lAuVenrG9A1XbQDtqEKcvwhzwPuZBogqaK1/
 vqB01XtX9e/9Q==
Message-ID: <sashiko-outbox-205314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] drm/amdgpu: handle gpu_recovery per device
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:36:24 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: broken gpu_recovery init and ordering in
  amdgpu_device_init()
- [Medium] drm/amdgpu: sysfs reset_mask leak when gpu_recovery is
  disabled at runtime
--

commit da82b226214b96b7716dea3ad2863a26a7b52c07
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: handle gpu_recovery per device

This commit moves the gpu_recovery setting from a global module parameter
check into struct amdgpu_device and makes the amdgpu_gpu_recover debugfs
file writable so auto-recovery can be toggled per device.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9c6d51445f820..f284e433b72bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3769,6 +3769,45 @@ amdgpu_device_should_register_switcheroo(struct am=
dgpu_device *adev, bool px)
>  		       apple_gmux_detect(NULL, NULL)));
>  }
> =20
> +static void amdgpu_device_init_gpu_recovery(struct amdgpu_device *adev)
> +{
> +	adev->gpu_recovery =3D 0;
> +
> +	if (amdgpu_gpu_recovery =3D=3D 0)
> +		return;
> +
> +	/* Skip soft reset check in fatal error mode */
> +	if (!amdgpu_ras_is_poison_mode_supported(adev) ||
> +	    amdgpu_sriov_vf(adev)) {
> +		adev->gpu_recovery =3D adev->gpu_recovery > 0 ?
> +			adev->gpu_recovery :-1;
> +	} else if (amdgpu_gpu_recovery =3D=3D -1) {
> +		switch (adev->asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +		case CHIP_VERDE:
> +		case CHIP_TAHITI:
> +		case CHIP_PITCAIRN:
> +		case CHIP_OLAND:
> +		case CHIP_HAINAN:
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +		case CHIP_KAVERI:
> +		case CHIP_KABINI:
> +		case CHIP_MULLINS:
> +#endif
> +		case CHIP_CARRIZO:
> +		case CHIP_STONEY:
> +		case CHIP_CYAN_SKILLFISH:
> +			return;
> +		default:
> +			adev->gpu_recovery =3D 1;
> +			break;
> +		}
> +	} else {
> +		adev->gpu_recovery =3D amdgpu_gpu_recovery;
> +	}
> +}
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -4117,6 +4156,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
> =20
> +	amdgpu_device_init_gpu_recovery(adev);
> +
>  fence_driver_init:
>  	/* Fence driver */
>  	r =3D amdgpu_fence_driver_sw_init(adev);

[Severity: High]
Does amdgpu_device_init_gpu_recovery() always set adev->gpu_recovery to
(unsigned int)-1 whenever amdgpu_gpu_recovery !=3D 0?

adev->gpu_recovery (declared as unsigned int in struct amdgpu_device) is set
to 0 at the top of the function, and then the first branch tests
adev->gpu_recovery > 0 instead of amdgpu_gpu_recovery > 0.  That overwrites
positive module parameter values such as amdgpu.gpu_recovery=3D4 or 5 with =
-1,
so the adev->gpu_recovery =3D=3D 4 || adev->gpu_recovery =3D=3D 5 check in
soc15_asic_reset_method() can never select Mode-2 reset.

In addition, amdgpu_device_init() calls amdgpu_device_init_gpu_recovery()
before amdgpu_device_ip_init() -> amdgpu_ras_init() allocates the RAS conte=
xt
and sets con->poison_supported.  At this point
amdgpu_ras_is_poison_mode_supported(adev) always returns false (and legacy
SI/CIK/Carrizo/Stoney/Cyan Skillfish ASICs do not support RAS poison mode
either), making the else-if per-ASIC exclusion switch and the final else
branch unreachable dead code.  Placing the call here also leaves
adev->gpu_recovery at 0 during the earlier reset-on-init amdgpu_asic_reset()
call and skips it altogether when amdgpu_emu_mode =3D=3D 1 jumps to
fence_driver_init.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 0ae6e990c3102..28f9048f806cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2299,7 +2299,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct =
amdgpu_device *adev)
>  {
>  	int r =3D 0;
> =20
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return r;
> =20
>  	if (adev->gfx.num_gfx_rings) {
> @@ -2319,7 +2319,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct =
amdgpu_device *adev)
> =20
>  static void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  {
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return;
> =20
>  	if (adev->gfx.num_gfx_rings)

[Severity: Medium]
Can disabling gpu_recovery at runtime via debugfs leak the reset_mask sysfs
files on teardown?

If GPU recovery is enabled during sw_init, amdgpu_gfx_sysfs_reset_mask_init=
()
and amdgpu_sdma_sysfs_reset_mask_init() create gfx_reset_mask,
compute_reset_mask, and sdma_reset_mask on adev->dev.  If a user then writes
0 to amdgpu_gpu_recover in debugfs before driver unbind or module unload,
amdgpu_device_should_recover_gpu(adev) is false in
amdgpu_gfx_sysfs_reset_mask_fini() and amdgpu_sdma_sysfs_reset_mask_fini(),
so device_remove_file() is skipped.  The dangling sysfs attributes remain on
the PCI device, causing a subsequent re-bind to fail with -EEXIST in
device_create_file() and allowing reads of those attributes to access freed
adev memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109171333.4329=
-1-pierre-eric.pelloux-prayer@amd.com?part=3D4
