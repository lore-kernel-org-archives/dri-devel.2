Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605E2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CC110E036;
	Thu, 13 Aug 2026 17:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aJFU+IY7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4783710E036
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:18:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6651A600AD;
 Thu, 13 Aug 2026 17:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23B41F000E9;
 Thu, 13 Aug 2026 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786641508;
 bh=AfSDqtoOE/sAGxHP00Modn8eNWcbPCMjGEI7ImBF/pU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aJFU+IY7b0dOn/ghvcHhagrdebZOJCu2hOePGG+nbWtx9Ksjst4XeHbT8UOKALvtA
 7qbhoB3hwiuoFOhcsr7QQwUTgo/oSmQbn4QxLRppq8zk+KEa/MkrbZdd5pv7Dzup4P
 t7/yeZ6nuDuXAzXJnbRFfXI9/YYKWBfyl6GdVDKrd5yEZGEOPkEz0MORZYiMSb5dxO
 VHPXaKCOVjFf0DvrTbZjRprEIeHL7MTwXf7LfhhYnFB5lx/7EMYc93v71IIILfpptW
 HMZM5Hp7BSkVI7mqjKZaNMt18ntyPrkxL2TRQEOJNCV7UBlErWMDmJ+8YnccX49naZ
 bGox8W3iIRehA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add gpu_recovery_allowed flag to
 amdgpu_device
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:18:27 +0000
Message-Id: <20260813171827.F23B41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Overloading an action-triggering debugfs file with a configuration=
 state setter creates a severe usability trap.
- [Medium] Missing initialization of `gpu_recovery_allowed` in emulation mo=
de unintentionally disables GPU recovery.

Pre-existing issues:
- [High] Kernel stack memory leak in `gpu_recover_get` during debugfs file =
read.
--

--- Patch [1]: [PATCH v2 1/5] drm/amdgpu: add gpu_recovery_allowed flag to =
amdgpu_device ---
commit 387fc7f831c412d1422444dc6a5d877786192a5b
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: add gpu_recovery_allowed flag to amdgpu_device
   =20
Add a per-device boolean to control whether GPU recovery is attempted
on a hang, independently of the global amdgpu.gpu_recovery module
parameter. It defaults to true and is exposed as a write to the
existing amdgpu_gpu_recover debugfs file.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 520fd59036d57..eba75b41b50a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4080,6 +4080,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
> =20
> +	adev->gpu_recovery_allowed =3D true;
> +
>  fence_driver_init:

[Severity: Medium]
Does this skip initializing the flag in emulation mode?

If amdgpu_emu_mode =3D=3D 1, the code earlier in this function jumps direct=
ly to
fence_driver_init:

amdgpu_device_init() {
    if (amdgpu_emu_mode =3D=3D 1) {
        emu_soc_asic_init(adev);
        goto fence_driver_init;
    }
    ...
}

Since the device structure is zero-allocated, jumping over the assignment
will leave gpu_recovery_allowed as false, which inadvertently disables GPU
recovery for this device in emulation mode. Should the initialization be
moved before the goto or handled at the beginning of the function?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 3043ad041bb42..707e69d8bb115 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c

[ ... ]

>  static int gpu_recover_get(void *data, u64 *val)
>  {

[Severity: High]
This is a pre-existing issue, but does this function leak kernel stack memo=
ry?

In simple_attr_read(), an uninitialized u64 val is allocated on the stack
and passed to the attribute's get callback. gpu_recover_get() returns 0
without writing to val. The uninitialized value is then formatted into a
string and copied to userspace.

Because this patch converts the file into a configuration knob, users and
tooling are much more likely to read it to check its state, making this
leak more exposed.

[ ... ]

> @@ -1001,8 +1005,17 @@ static int gpu_recover_get(void *data, u64 *val)
>  	return 0;
>  }
> =20
> +static int gpu_recover_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +
> +	adev->gpu_recovery_allowed =3D !!val;
> +
> +	return 0;
> +}
> +
>  DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
> -DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_ge=
t, NULL,
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_ge=
t, gpu_recover_set,
>  			 "%lld\n");

[Severity: High]
Does overloading this debugfs file create a usability trap?

The patch adds a set callback to configure gpu_recovery_allowed, changing
amdgpu_gpu_recover into a dual-purpose configuration file. However,
gpu_recover_get unconditionally triggers a full GPU reset when read, rather
than returning the current configuration value:

gpu_recover_get() {
    ...
    if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
        flush_work(&adev->reset_work);
    return 0;
}

If a user attempts to read amdgpu_gpu_recover to check if recovery is
enabled, they will unintentionally reset the GPU. Would it be safer to
use a separate debugfs file for the configuration flag?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813170705.1574=
5-1-pierre-eric.pelloux-prayer@amd.com?part=3D1
