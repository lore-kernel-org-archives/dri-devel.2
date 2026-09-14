Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879A5C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FB110E04E;
	Mon, 14 Sep 2026 10:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FFrYIo95";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED70610E04E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789381023;
 bh=IjILyR/6pp2CMI4f8n/7R4sQdcPlICiJR2ESd2YF9AM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FFrYIo95+Fp/V8qXSi1v/BTlJXKDo5jd91GMgnwbKK6t24baLhXR/YXQs5/TFJIP2
 3zzodkap9o6Ftxzv6B6Lu7IpG85/OuHJlALT7ZVeni0kc8GD9qCu6GSAIIj2yORNj9
 JQVnZg5MErwvK9Rw2/yP7xWdq70GVctUdlxhpLoRvDVpZrCUAyDMBTMFDHqMN06Q3R
 NyFyxuJl88l01mRFhyYqgdnmTk5mf3+iMSIPcXOJex3jC+WeZvvKxDGh9DxxvFJ7YS
 6+LQXgDzdz2uMBTtHY2zgDZ3X1q/bEj7IrF+1r5BR9BXDKkPfOcswnW385W+Ub757I
 vk18n7lmLGWew==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E471117E031C;
 Mon, 14 Sep 2026 12:17:02 +0200 (CEST)
Date: Mon, 14 Sep 2026 12:16:57 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <20260914121657.2e9925c9@fedora-21.home>
In-Reply-To: <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, 12 Sep 2026 00:28:16 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Formerly, the reset sequence would race with panfrost_mmu_as_put()
> when tearing down a perfcnt session. On top of that, poking GPU
> registers to program a perfcnt session or obtaining a dump might lead to
> undefined behaviour when done at the same time a reset was ongoing.
>=20
> Use the reset r/w semaphore to govern access to the hardware at reset
> time. On top of that, expand the DRM uAPI for the perfcnt DUMP operation
> so that userspace can be made aware of a reset having happened, because
> that means counters will go back to 0 and can no longer be accumulated
> to values previously kept in user space.

In GPU_PERFCNT_CFG_MODE_MANUAL mode (which is the one we use), internal
counters are always cleared after each DUMP request. So, it's not so
much that counters can't be accumulated after a RESET, it's more that
we've lost data in the process, making this very sample inaccurate
(counters lower than they should be).

>=20
> The new perfcnt-aware reset sequence also takes care to reestablish
> perfcnt to its original configuration if there was an enabled session,
> or else flags the current session as dead if that failed.
>=20
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through u=
nstable ioctls")
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 201 +++++++++++++++++++---=
------
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
>  include/uapi/drm/panfrost_drm.h             |   8 +-
>  4 files changed, 151 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 6c65feae63aa..e774f61c642b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -479,6 +479,8 @@ void panfrost_device_reset(struct panfrost_device *pf=
dev, bool enable_job_int)
>  	panfrost_jm_reset_interrupts(pfdev);
>  	if (enable_job_int)
>  		panfrost_jm_enable_interrupts(pfdev);
> +
> +	panfrost_perfcnt_reset(pfdev);
>  }
> =20
>  static int panfrost_device_runtime_resume(struct device *dev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a..9847657179a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -11,6 +11,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/panfrost_drm.h>
> +#include <drm/drm_print.h>
> =20
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
> @@ -28,11 +29,15 @@
> =20
>  struct panfrost_perfcnt {
>  	struct panfrost_gem_mapping *mapping;
> +	unsigned int counterset;
>  	size_t bosize;
>  	void *buf;
>  	struct panfrost_file_priv *user;
>  	struct mutex lock;
>  	struct completion dump_comp;
> +	bool reset_happened;
> +	bool dump_finished;

Why not store the state flags directly instead of these
dump_finished/reset_happened booleans?

> +	bool owns_as_ref;
>  };
> =20
>  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> @@ -47,36 +52,113 @@ static void panfrost_perfcnt_hw_disable(struct panfr=
ost_device *pfdev)
> =20
>  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
>  {
> +	pfdev->perfcnt->dump_finished =3D true;
>  	complete(&pfdev->perfcnt->dump_comp);
>  }
> =20
>  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  {
> -	if (pfdev->features.selected_coherency !=3D COHERENCY_ACE)
> +	if (pfdev->features.selected_coherency !=3D COHERENCY_ACE) {
>  		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> -	else
> +	} else {
> +		pfdev->perfcnt->dump_finished =3D true;
>  		complete(&pfdev->perfcnt->dump_comp);
> +	}
> +}
> +
> +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u32 cfg, as;
> +	int ret;
> +
> +	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	if (ret < 0)
> +		return ret;
> +
> +	as =3D ret;
> +	cfg =3D GPU_PERFCNT_CFG_AS(as) |
> +	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> +
> +	/*
> +	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> +	 * the first one for now.
> +	 */
> +	if (panfrost_model_is_bifrost(pfdev))
> +		cfg |=3D GPU_PERFCNT_CFG_SETSEL(perfcnt->counterset);
> +
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> +
> +	/*
> +	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> +	 * counters.
> +	 */
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +	else
> +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +
> +	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +
> +	return 0;
>  }
> =20
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u=
32 *state)
>  {
> -	u64 gpuva;
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
>  	int ret;
> =20
> -	reinit_completion(&pfdev->perfcnt->dump_comp);
> -	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_INT_CLEAR,
> -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		perfcnt->dump_finished =3D false;
> +		*state =3D 0;
> +
> +		if (!perfcnt->owns_as_ref) {
> +			*state =3D PANFROST_PERFCNT_SESSION_DEAD;
> +			return -EIO;
> +		}
> +
> +		if (perfcnt->reset_happened) {
> +			*state =3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> +			perfcnt->reset_happened =3D false;
> +		}

		*state =3D perfcnt->state;
		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
			return -EIO;

		perfcnt->state =3D 0;

> +
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	}
> +
> +	/*
> +	 * Here we release the reset semaphore because perfcnt should not get i=
n the way
> +	 * of a HW reset. Besides, a legitimate reset might be issued during th=
e wait.
> +	 */
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
> -	if (!ret)
> -		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret =3D 0;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/* Either sample finished or reset happened */
> +		if (ret > 0) {
> +			ret =3D perfcnt->dump_finished ? 0 :
> +			      perfcnt->owns_as_ref ? -EAGAIN : -EIO;
> +
> +		} else if (!ret) {
> +			ret =3D -ETIMEDOUT;
> +		}
> +
> +		if (perfcnt->reset_happened)
> +			*state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> +		if (!perfcnt->owns_as_ref)
> +			*state |=3D PANFROST_PERFCNT_SESSION_DEAD;
> +	}

	if (!ret)
		return -ETIMEDOUT;

	scoped_guard(rwsem_read, &pfdev->reset.lock) {
		u32 new_state =3D perfcnt->state;

		*state |=3D new_state;
		if (new_state & PANFROST_PERFCNT_SESSION_DEAD)
			return -EIO;

		perfcnt->state =3D 0;

		/* If we faced a reset during our SAMPLE, the user needs to try again. */
		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
			return -EAGAIN;
	}

	return 0;

> =20
>  	return ret;
>  }
> @@ -87,9 +169,8 @@ static int panfrost_perfcnt_enable_locked(struct panfr=
ost_device *pfdev,
>  {
>  	struct panfrost_file_priv *user =3D file_priv->driver_priv;
>  	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> -	struct iosys_map map;
>  	struct drm_gem_shmem_object *bo;
> -	u32 cfg, as;
> +	struct iosys_map map;
>  	int ret;
> =20
>  	if (user =3D=3D perfcnt->user)
> @@ -122,54 +203,31 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
>  	ret =3D drm_gem_vmap(&bo->base, &map);
>  	if (ret)
>  		goto err_put_mapping;
> +
>  	perfcnt->buf =3D map.vaddr;
> +	perfcnt->counterset =3D counterset;
> =20
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> =20
> -	/*
> -	 * Clear the counters to start from a fresh state.
> -	 */
> -	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> -
> -	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> -	if (ret < 0)
> -		goto err_vunmap;
> -
> -	as =3D ret;
> -	cfg =3D GPU_PERFCNT_CFG_AS(as) |
> -	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> -
> -	/*
> -	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> -	 * the first one for now.
> -	 */
> -	if (panfrost_model_is_bifrost(pfdev))
> -		cfg |=3D GPU_PERFCNT_CFG_SETSEL(counterset);
> -
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> -
> -	/*
> -	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> -	 * counters.
> -	 */
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> -	else
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;
> =20
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->reset_happened =3D false;
> +		perfcnt->owns_as_ref =3D true;

This should probably be set in panfrost_perfcnt_hw_enable(), just after the=
=20
panfrost_mmu_as_get() call.

> +		perfcnt->user =3D user;
> +	}
> =20
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
> =20
> -	perfcnt->user =3D user;
> -
>  	return 0;
> =20
>  err_vunmap:
> @@ -195,13 +253,16 @@ static int panfrost_perfcnt_disable_locked(struct p=
anfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	panfrost_perfcnt_hw_disable(pfdev);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_perfcnt_hw_disable(pfdev);
> +		if (perfcnt->owns_as_ref)
> +			panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);

Similarly, I think it'd be preferable to have this as_put() inside
perfcnt_hw_disable().

> +		perfcnt->user =3D NULL;
> +	}
> =20
> -	perfcnt->user =3D NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>  	perfcnt->buf =3D NULL;
>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping =3D NULL;
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
> @@ -249,13 +310,16 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *=
dev, void *data,
>  	if (ret)
>  		return ret;
> =20
> +	if (req->pad)
> +		return -EINVAL;
> +
>  	mutex_lock(&perfcnt->lock);
>  	if (perfcnt->user !=3D file_priv->driver_priv) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	ret =3D panfrost_perfcnt_dump_locked(pfdev);
> +	ret =3D panfrost_perfcnt_dump_locked(pfdev, &req->state);
>  	if (ret)
>  		goto out;
> =20
> @@ -338,3 +402,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *p=
fdev)
>  	/* Disable everything before leaving. */
>  	panfrost_perfcnt_hw_disable(pfdev);
>  }
> +
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +
> +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> +		return;
> +
> +	lockdep_assert_held(&pfdev->reset.lock);
> +
> +	if (!perfcnt->user)
> +		return;
> +
> +	perfcnt->owns_as_ref =3D !panfrost_perfcnt_hw_enable(pfdev);
> +	perfcnt->reset_happened =3D true;
> +	complete(&perfcnt->dump_comp);

	/* All active AS are released during the MMU post_reset. */
	perfcnt->owns_as_ref =3D false;
	perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
	if (panfrost_perfcnt_hw_enable(pfdev))
		perfcnt->state |=3D PANFROST_PERFCNT_SESSION_DEAD;

	/* Unblock pending sample requests. */
	complete(&perfcnt->dump_comp);
> +}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.h
> index 8bbcf5f5fb33..8b9bc704b634 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> @@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *de=
v, void *data,
>  				  struct drm_file *file_priv);
>  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv);
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
> =20
>  #endif
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_=
drm.h
> index 50d5337f35ef..97e001040543 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -47,7 +47,7 @@ extern "C" {
>   * them for anything but debugging purpose.
>   */
>  #define DRM_IOCTL_PANFROST_PERFCNT_ENABLE	DRM_IOW(DRM_COMMAND_BASE + DRM=
_PANFROST_PERFCNT_ENABLE, struct drm_panfrost_perfcnt_enable)
> -#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOW(DRM_COMMAND_BASE + DRM_=
PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
> +#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOWR(DRM_COMMAND_BASE + DRM=
_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
> =20
>  #define PANFROST_JD_REQ_FS (1 << 0)
>  #define PANFROST_JD_REQ_CYCLE_COUNT (1 << 1)
> @@ -270,8 +270,14 @@ struct drm_panfrost_perfcnt_enable {
>  	__u32 counterset;
>  };
> =20
> +/* Perfcnt dump state as influenced by a HW reset */
> +#define PANFROST_PERFCNT_SESSION_DEAD                 (1 << 0)
> +#define PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET (1 << 1)
> +
>  struct drm_panfrost_perfcnt_dump {
>  	__u64 buf_ptr;
> +	__u32 state;
> +	__u32 pad;		/* MBZ */
>  };
> =20
>  /* madvise provides a way to tell the kernel in case a buffers contents
>=20

