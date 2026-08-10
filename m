Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F554C5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 17:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F3B10E953;
	Mon, 10 Aug 2026 17:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="akDPwM0e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F058710E20E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 17:11:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A154F40E02;
 Mon, 10 Aug 2026 17:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6397D1F000E9;
 Mon, 10 Aug 2026 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786381868;
 bh=9fNWuNJsw44+YGih/a+n+8/78PxSWGb/SLVh0yMvPe8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=akDPwM0eWeEeRQakxSFOxhvDyShM+pLT23N3ctBqzuDvgSqyIyd8xodfproreNRW/
 Z9bForb0c4D+JN4LjM5BldgWgbLu9g2m+xZ79cH7drJoQYm7lwnRd1exjDgR2pWi/I
 lsLqxUoz2A11TBbpDT96jzpEz5rpPhDZJ+pvbEQgl8hSGKHvOzb55pqbW6yqUWoTvW
 c5oZMFwJ87r9Y1vNh/P1byHcorQB5o0RIOxE7forfNVGx4qWZ6IPz1Q9WSrCt45XIu
 RW5hyUujU276OvH6XeSsh2iCQCsGcNc0qgMdWoQ/MFynlBTWp2yrxweh2QwnVsbiiM
 JTbglO7gCwR/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] drm/amdgpu: add wedge event implementation
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 17:11:07 +0000
Message-Id: <20260810171108.6397D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Concurrent execution of wedge recovery across multiple rings cause=
s race conditions in DRM scheduler and fence driver state.
- [High] Unconditionally returning `-ENODEV` in `amdgpu_drm_ioctl` blocks a=
ll core DRM ioctls, breaking userspace tools, KMS, and resource cleanup.
- [Medium] The per-device debugfs node `amdgpu_wedge` incorrectly modifies =
a global module parameter, affecting all GPUs.
- [Medium] The PM runtime usage counter is leaked if the device is removed =
or unbound while in the wedged state.
- [Medium] A Time-of-Check to Time-of-Use (TOCTOU) race exists between `amd=
gpu_job_timedout` setting the wedge flag and `amdgpu_device_gpu_recover` cl=
earing it.
--

--- Patch [1]: [PATCH v1 1/3] drm/amdgpu: add wedge event implementation ---
commit da2e81546012e13c20ccab9ed3ffded97a0f3ece
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: drm/amdgpu: add wedge event implementation

This commit adds a wedge framework for amdgpu to disable gpu recovery and
signal pending fences upon a hang, allowing userspace to inspect hardware
state. The wedge status is tracked via an atomic flag, and users can
manually trigger recovery later.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 964efec0d3352..c636a94d869c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -5740,6 +5744,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>  		dev_info(adev->dev, "GPU reset end with ret =3D %d\n", r);
> =20
>  	atomic_set(&adev->reset_domain->reset_res, r);
> +	if (atomic_xchg(&adev->wedged.flag, 0))
> +		pm_runtime_put_autosuspend(adev->dev);
> =20

[Severity: Medium]
Is there a race condition between setting the wedge flag in
amdgpu_job_timedout() and clearing it here?

If a TDR thread in amdgpu_job_timedout() sets the flag but gets preempted
before calling pci_clear_master(), a concurrent call to
amdgpu_device_gpu_recover() could clear the flag.

If the TDR thread then resumes execution, could it execute
pci_clear_master() on a successfully recovered and active GPU?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e645..399e935df7b29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3006,10 +3006,15 @@ long amdgpu_drm_ioctl(struct file *filp,
>  		      unsigned int cmd, unsigned long arg)
>  {
>  	struct drm_file *file_priv =3D filp->private_data;
> +	struct amdgpu_device *adev;
>  	struct drm_device *dev;
>  	long ret;
> =20
>  	dev =3D file_priv->minor->dev;
> +	adev =3D drm_to_adev(dev);
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +

[Severity: High]
Does returning -ENODEV unconditionally here block all core DRM ioctls?

This seems like it would lock out standard KMS and modeset queries, as
well as diagnostic tools attempting to read hardware state.

Could this prevent the exact hardware inspection the commit message
mentions?

>  	ret =3D pm_runtime_get_sync(dev->dev);
>  	if (ret < 0)
>  		goto out;

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 3043ad041bb42..b241062985769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
[ ... ]
> @@ -974,6 +974,39 @@ static int amdgpu_debugfs_fence_info_show(struct seq=
_file *m, void *unused)
> +static int amdgpu_device_wedged_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> +
> +	if (amdgpu_device_is_wedged(adev))
> +		return -EINVAL;
> +
> +	if (val)
> +		amdgpu_gpu_recovery =3D 0;
> +	else
> +		amdgpu_gpu_recovery =3D adev->wedged.boot_gpu_recovery;
> +
> +	return 0;
> +}
> +

[Severity: Medium]
Does modifying amdgpu_gpu_recovery here affect all GPUs in a multi-GPU
system?

The commit message mentions this is to enable/disable at runtime for one
GPU, but amdgpu_gpu_recovery is a global module parameter.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index d97cf1212e0f9..187eac9aab1f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
[ ... ]
> @@ -184,9 +185,44 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>  		if (r)
>  			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>  	} else {
> -		drm_sched_suspend_timeout(&ring->sched);
> -		if (amdgpu_sriov_vf(adev))
> +		if (amdgpu_sriov_vf(adev)) {
> +			drm_sched_suspend_timeout(&ring->sched);
>  			adev->virt.tdr_debug =3D true;
> +		} else {
> +			/* Declare the device as wedged if it's not already. */
> +			struct drm_gpu_scheduler *sched;
> +			struct amdgpu_ring *ring;
> +			struct amdgpu_fence *guilty_fence;
> +			int i;
> +
> +			if (!atomic_xchg(&adev->wedged.flag, 1)) {
> +				pm_runtime_get_sync(adev->dev);
> +

[Severity: Medium]
If the device is unbound or hot-unplugged while in the wedged state, will
this pm_runtime_get_sync() reference be leaked?

It appears there is no corresponding put if the device is torn down before
manual recovery is triggered.

> +				pci_clear_master(adev->pdev);
> +
> +				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND |
> +						DRM_WEDGE_RECOVERY_BUS_RESET, NULL);
> +			}
> +
> +			guilty_fence =3D to_amdgpu_job(s_job)->hw_fence;
> +
> +			for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> +				ring =3D adev->rings[i];
> +
> +				if (!amdgpu_ring_sched_ready(ring))
> +					continue;
> +
> +				sched =3D &ring->sched;
> +
> +				/* Stop the scheduler to prevent anybody else from touching the ring=
 buffer. */
> +				drm_sched_wqueue_stop(sched);
> +
> +				amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
> +
> +				/* Start the scheduler again */
> +				drm_sched_wqueue_start(sched);
> +			}

[Severity: High]
Since this loop iterating over AMDGPU_MAX_RINGS is outside the
atomic_xchg() check, can multiple concurrent TDR threads race on stopping
and starting schedulers?

If multiple rings hang concurrently, all their respective TDR threads will
attempt to stop/start the schedulers and force fence completions across
all rings simultaneously, which could corrupt the scheduler and fence
driver state.

> +		}
>  	}
> =20
>  exit:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810165322.2468=
2-1-pierre-eric.pelloux-prayer@amd.com?part=3D1
