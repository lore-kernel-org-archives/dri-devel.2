Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01869C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65CC10F472;
	Thu, 13 Aug 2026 17:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fDPcYlhH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC5010F46A
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:29:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E87041A17;
 Thu, 13 Aug 2026 17:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5211F000E9;
 Thu, 13 Aug 2026 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786642191;
 bh=gUGkV2a1ruamu9o2ux0VSehAz2F32HQnIXuRblmnhJY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fDPcYlhHmMoBKaf64RN7XiGESSlNs8wEUVmGf0EKVmbVNIP0tWd6pTxNT5GJJ4/kS
 BgffK19snV0BhMl63AIXV1/kVXS4EMB2IPPbZe7d8bmkkTirc+I6imhhoh3pb7gqNB
 5WpmIq6YyouESmL2GdDr0niLDmTirin9Nm39np3NaqXfZFxaqgg8/2zRbupbclRAOB
 HrZGInWbImXGIGl5p2NwbuI/RVGdLoNbfsXgeJTCR2PrmFU+IRKtCPJ0c205dZqrmC
 dai+xu0k9501V9+mYnYlfnyojWUYWltsPxWIMOrIWnspQDvWnEz13ZX9wtqTbR2Mbc
 2YvEq0GJ5blZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] drm/amdgpu: add wedge event implementation
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813170705.15745-3-pierre-eric.pelloux-prayer@amd.com>
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
 <20260813170705.15745-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:29:50 +0000
Message-Id: <20260813172950.CB5211F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference in `kfd_profiler_pmc` due to TOCTOU race =
with asynchronous wedge state.
- [High] Concurrent GPU recovery races with wedge state application in `amd=
gpu_job_timedout`, leading to PM counter underflow and broken bus master st=
ate.
- [High] Top-level ioctl wedge check blocks core DRM cleanup ioctls, leadin=
g to kernel resource leaks.
--

--- Patch [3]: [PATCH v2 3/5] drm/amdgpu: add wedge event implementation ---
commit e3bfcebac5b33ee92580699914c3fa3365f9d94f
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: drm/amdgpu: add wedge event implementation

This commit enables the drm wedge framework for amdgpu. When a hang is
detected, the GPU isn't reset but pending fences are signalled and new
work is blocked. Runtime PM is also disabled when the device is wedged.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e645..399e935df7b29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
[ ... ]
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
Does this block core resource cleanup ioctls? By returning -ENODEV here,
it bypasses drm_ioctl() entirely.=20

If a Wayland compositor or X server tries to gracefully clean up a client's
resources after a GPU hang, won't standard cleanup interfaces like
DRM_IOCTL_GEM_CLOSE or DRM_IOCTL_SYNCOBJ_DESTROY fail and leak memory in
the kernel?

>  	ret =3D pm_runtime_get_sync(dev->dev);
>  	if (ret < 0)
>  		goto out;

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 43511e0419a12..41d083646da59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
[ ... ]
> @@ -185,9 +186,35 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
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
> +			struct drm_gpu_scheduler *sched;
> +			struct amdgpu_fence *guilty_fence;
> +
> +			/* Declare the device as wedged if it's not already. */
> +			if (!atomic_xchg(&adev->wedge_status, 1)) {
> +				pm_runtime_get_sync(adev->dev);
> +
> +				pci_clear_master(adev->pdev);
> +

[Severity: High]
Can this race with concurrent GPU recovery since it is not holding the
adev->reset_domain->sem lock?

If a user manually triggers a GPU reset concurrently, the reset thread in
amdgpu_device_gpu_recover() could clear wedge_status to 0 and call
pm_runtime_put_autosuspend().=20

If this happens while amdgpu_job_timedout() is preempted before executing
pm_runtime_get_sync(), will the PM usage count underflow?=20

Furthermore, when amdgpu_job_timedout() resumes, won't it execute
pci_clear_master() on the newly-recovered healthy GPU, breaking its state?

> +				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND |
> +						DRM_WEDGE_RECOVERY_BUS_RESET, NULL);
> +			}
> +
> +			guilty_fence =3D to_amdgpu_job(s_job)->hw_fence;

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 0a7c1900da959..544dc960833b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
[ ... ]
> @@ -2433,8 +2433,12 @@ struct kfd_process_device *kfd_process_device_data=
_by_id(struct kfd_process *p,
>  		for (i =3D 0; i < p->n_pdds; i++) {
>  			struct kfd_process_device *pdd =3D p->pdds[i];
> =20
> -			if (pdd->user_gpu_id =3D=3D gpu_id)
> +			if (pdd->user_gpu_id =3D=3D gpu_id) {
> +				if (amdgpu_device_is_wedged(pdd->dev->adev))
> +					return NULL;
> +

[Severity: High]
Does returning NULL dynamically here introduce a TOCTOU race leading to a
NULL pointer dereference?

Looking at kfd_profiler_pmc() in kfd_chardev.c, it acquires the pdd pointer
and immediately dereferences it without checking for NULL:

drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:kfd_profiler_pmc() {
    ...
    mutex_lock(&p->mutex);
    pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
    dqm =3D pdd->dev->dqm;
    mutex_unlock(&p->mutex);
    ...
}

Since the device can enter the wedged state asynchronously on a job timeout,
could this second call to kfd_process_device_data_by_id() return NULL and
cause a kernel crash when pdd->dev is accessed?

Additionally, does this abort unmapping loops and leak mappings on healthy
GPUs?

In kfd_ioctl_unmap_memory_from_gpu(), if kfd_process_device_data_by_id()
returns NULL for a wedged GPU, the loop aborts and goes to=20
get_mem_obj_from_handle_failed, leaking mappings on any subsequent healthy
GPUs in the array.

>  				return pdd;
> +			}
>  		}
>  	}
>  	return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813170705.1574=
5-1-pierre-eric.pelloux-prayer@amd.com?part=3D3
