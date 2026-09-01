Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578E0C624D5
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B324F10E3F7;
	Tue,  1 Sep 2026 14:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UsxwIs8m";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586CA10E3F7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788271437;
 bh=CZ4L3BxkouAA3OkQqjUagY48e7Wce7AW/nJMoc6hGOw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UsxwIs8mPt5rYP3pHHiE2BKPFwvt2S37qNOPB6LTRgbxqPw43RU9ILAYw7M2R5s2q
 ELh7UdoF1g+t8Sqr4z97h6p0bylp0x1MrYrHo0JbF+PbJH0pyPnN5/wprneYmYRK0U
 i8D0Sh8PH4cAoo25Pkl6SmpdgdozQvaSMXKhhJ0t+0GO8p0ZE6Q0bBrfvot4rZaffL
 x2Yn9PK1ycVRM0lQZ1+k2xbT7LBNNbhrrwCtfp9bkt5mar7ABylAl8hSK5TnzXVGCe
 1yjoEH/oGYUnP0NPiWG9zzFku0vEYPPg26cxaQ9wzNBft2g9Zg4eyeS80TsatnojoJ
 OIzTTycCQOxdg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 481BD17E063E;
 Tue, 01 Sep 2026 16:03:56 +0200 (CEST)
Date: Tue, 1 Sep 2026 16:03:44 +0200
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
Subject: Re: [PATCH v7 16/17] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <20260901160344.586a2295@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-16-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-16-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:56 +0100
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
>=20
> The new perfcnt-aware reset sequence also takes care to reestablish
> perfcnt to its original configuration if there was an enabled session.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c  |   1 +
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 189 ++++++++++++++++++++--=
------
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
>  include/uapi/drm/panfrost_drm.h             |   3 +-
>  4 files changed, 140 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index c8c5dc26b03d..471bd4b037e6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -498,6 +498,7 @@ void panfrost_device_reset(struct panfrost_device *pf=
dev)
>  	panfrost_gpu_power_on(pfdev);
>  	panfrost_mmu_reset(pfdev);
>  	panfrost_jm_reset_interrupts(pfdev);
> +	panfrost_perfcnt_reset(pfdev);
>  }
> =20
>  static int panfrost_device_runtime_resume(struct device *dev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a..0564aa2753f9 100644
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
> @@ -25,14 +26,18 @@
>  #define BYTES_PER_COUNTER		4
>  #define BLOCKS_PER_COREGROUP		8
>  #define V4_SHADERS_PER_COREGROUP	4
> +#define PERFCNT_DUMP_MAX_RETRIES	5
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
> +	bool reset_failed;
>  };
> =20
>  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> @@ -58,25 +63,107 @@ void panfrost_perfcnt_sample_done(struct panfrost_de=
vice *pfdev)
>  		complete(&pfdev->perfcnt->dump_comp);
>  }
> =20
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
>  {
> -	u64 gpuva;
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u32 cfg, as;
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
> +}
> +
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> +					u64 *reset_happened)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> +	s64 retries =3D PERFCNT_DUMP_MAX_RETRIES;
> +	bool retry;
> +	int ret;
> +
> +dump_retry:
> +	retry =3D false;
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*reset_happened =3D perfcnt->reset_happened;
> +		perfcnt->reset_happened =3D false;
> +		if (perfcnt->reset_failed) {

I'd rather treat that as a terminal fault (returning -EIO, and maybe
reflecting the perf session as dead through some state flag) in order
to force the user to re-create a session. The only case where it would
fail is if as_get() fails, and it's not supposed to fail after a reset.
This should simplify the dump logic quite a bit.

> +			ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +			if (ret)
> +				return ret;
> +			perfcnt->reset_failed =3D false;
> +		}
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
> +	 * of a HW reset. The downside is in the gap between the completion is =
flagged
> +	 * by the GPU IRQ handler and the sempahore taken once again, yet anoth=
er reset
> +	 * could happen, which would lead to a valid sample being discarded. Th=
is is
> +	 * a solution of compromise between ensuring synchronisation with the r=
eset
> +	 * sequence and letting it happen as quickly as possible for jobs to be=
 rerun.
> +	 */
> +
>  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump=
_comp,
>  							msecs_to_jiffies(1000));
> -	if (!ret)
> -		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret =3D 0;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (ret > 0) {
> +			if (perfcnt->reset_happened) {
> +				if (--retries >=3D 0)
> +					retry =3D true;
> +				else
> +					ret =3D -EBUSY;
> +			} else {
> +				ret =3D 0;
> +			}
> +		} else if (!ret) {
> +			ret =3D -ETIMEDOUT;
> +		}
> +	}

I think it's fine to return -EAGAIN here and skip the retry, because
what's important is the re-enable part: get the counting running again
as soon as we can, so that, if the user-side sampling is done at a low
rate, we still get non-zero values between two dumps when a reset
occurred in the middle.

> +
> +	if (retry)
> +		goto dump_retry;
> =20
>  	return ret;
>  }
> @@ -87,9 +174,8 @@ static int panfrost_perfcnt_enable_locked(struct panfr=
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
> @@ -122,7 +208,9 @@ static int panfrost_perfcnt_enable_locked(struct panf=
rost_device *pfdev,
>  	ret =3D drm_gem_vmap(&bo->base, &map);
>  	if (ret)
>  		goto err_put_mapping;
> +
>  	perfcnt->buf =3D map.vaddr;
> +	perfcnt->counterset =3D counterset;
> =20
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> =20
> @@ -132,44 +220,19 @@ static int panfrost_perfcnt_enable_locked(struct pa=
nfrost_device *pfdev,
>  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
>  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> =20
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
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;
> =20
> -	/*
> -	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> -	 * counters.
> -	 */
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> -	else
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> -
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> -
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->reset_happened =3D false;
> +		perfcnt->reset_failed =3D false;
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
> @@ -195,13 +258,16 @@ static int panfrost_perfcnt_disable_locked(struct p=
anfrost_device *pfdev,
>  	if (user !=3D perfcnt->user)
>  		return -EINVAL;
> =20
> -	panfrost_perfcnt_hw_disable(pfdev);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_perfcnt_hw_disable(pfdev);
> +		if (!perfcnt->reset_failed)
> +			panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);

Let's not conflate !reset_failed and owns_as_slot, even if they are
related in practice.

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
> @@ -255,7 +321,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *de=
v, void *data,
>  		goto out;
>  	}
> =20
> -	ret =3D panfrost_perfcnt_dump_locked(pfdev);
> +	ret =3D panfrost_perfcnt_dump_locked(pfdev, &req->hw_reset);
>  	if (ret)
>  		goto out;
> =20
> @@ -338,3 +404,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *p=
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
> +	perfcnt->reset_failed =3D !!panfrost_perfcnt_hw_enable(pfdev);
> +	perfcnt->reset_happened =3D true;
> +	complete(&perfcnt->dump_comp);
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
> index 50d5337f35ef..3bbf9220103d 100644
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
> @@ -272,6 +272,7 @@ struct drm_panfrost_perfcnt_enable {
> =20
>  struct drm_panfrost_perfcnt_dump {
>  	__u64 buf_ptr;
> +	__u64 hw_reset;

Let's make this a

	__u32 state;
	__u32 pad;

and define state flags like:

#define PANFROST_PERFCNT_SESSION_DEAD                 (1 << 0)
#define PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET (1 << 1)

so we can easily extend the thing without introducing new fields or
renaming hw_reset.

>  };
> =20
>  /* madvise provides a way to tell the kernel in case a buffers contents
>=20

