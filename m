Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2743C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2F510E08F;
	Fri, 25 Sep 2026 08:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CEh1cYrK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5213F10E08F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790324315;
 bh=+tH4Mc9FC4T4Lpy94DCG6SpUwN4tXJW8DVCLpr5sk9o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CEh1cYrK2B39TQLwj7BzHLDsqqM99K3trEOfbawx/yC4wO/v++gvzkXQsq730rcyM
 gWc6RB0pk7Qt5VGfBug7k5r4d0NgPjaTPCQAdO5PRbgSWPtxbw+qeEWhyuJh4shR8P
 c0bRAwRkkrTDPdgaZXPwUgXZ4wI4tWtfHSpbfT9yTP2p+pAAP2W6QquSx7JVuW+I2Y
 Gg4CuBec/xumiHxX787HuPzUztlNczfHkwfwsVTqrtXRZlt4kgC7ipzTsNFGhEeEsY
 7ovxXwZ7ndEvSY+YZ+rMRDZrlW5IUSZh80UP2G6uMNYIAb5h/HlYObTonAVrfZXpTF
 +3LeYG6p+7TAQ==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 47A1117E05F4;
 Fri, 25 Sep 2026 10:18:35 +0200 (CEST)
Date: Fri, 25 Sep 2026 10:18:30 +0200
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
Subject: Re: [PATCH v10 15/15] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <20260925101830.25d16466@fedora-32.home>
In-Reply-To: <20260924-claude-fixes-v10-15-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
 <20260924-claude-fixes-v10-15-755929b3cc19@collabora.com>
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

On Thu, 24 Sep 2026 19:09:32 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Formerly, the reset sequence would race with panfrost_mmu_as_put()
> when tearing down a perfcnt session. On top of that, poking GPU
> registers to program a perfcnt session or obtaining a dump might lead to
> undefined behaviour when done at the same time a reset was ongoing.
>=20
> Use the reset r/w semaphore to govern access to the hardware at reset
> time. On top of that, expand the DRM uAPI for the perfcnt DUMP operation
> so that userspace can be made aware of a reset having happened. UM needs
> to know about this condition because counter data is inaccurate after
> a reset, so the best approach is simply to try again.
>=20
> The new perfcnt-aware reset sequence also takes care to reestablish
> perfcnt to its original configuration if there was an enabled session,
> or else flags the current session as dead if that failed.
>=20
> Also bump DRM driver minor to reflect the new DUMP IOCTL req field.
>=20
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through u=
nstable ioctls")
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c     |   3 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 200 ++++++++++++++++++++--=
------
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
>  include/uapi/drm/panfrost_drm.h             |   8 +-
>  5 files changed, 155 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 801ca07ccb28..98de04362517 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -483,6 +483,8 @@ void panfrost_device_reset(struct panfrost_device *pf=
dev, bool enable_job_int)
>  	panfrost_jm_reset_interrupts(pfdev);
>  	if (enable_job_int)
>  		panfrost_jm_enable_interrupts(pfdev);
> +
> +	panfrost_perfcnt_reset(pfdev);
>  }
> =20
>  static int panfrost_device_runtime_resume(struct device *dev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 571a26b84126..de9b1c115181 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driv=
er_fops =3D {
>   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
>   *	   PANFROST_IOCTL_QUERY_BO_INFO and
>   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> + * - 1.7 - adds PERFCNT_DUMP req state field
>   */
>  static const struct drm_driver panfrost_drm_driver =3D {
>  	.driver_features	=3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
> @@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver =
=3D {
>  	.name			=3D "panfrost",
>  	.desc			=3D "panfrost DRM",
>  	.major			=3D 1,
> -	.minor			=3D 6,
> +	.minor			=3D 7,
> =20
>  	.gem_create_object	=3D panfrost_gem_create_object,
>  	.gem_prime_import	=3D panfrost_gem_prime_import,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a..91983d450c24 100644
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
> @@ -28,21 +29,31 @@
> =20
>  struct panfrost_perfcnt {
>  	struct panfrost_gem_mapping *mapping;
> +	unsigned int counterset;
>  	size_t bosize;
>  	void *buf;
>  	struct panfrost_file_priv *user;
>  	struct mutex lock;
>  	struct completion dump_comp;
> +	unsigned int state;

nit:
	u32 state;

to be consistent with the uAPI field.

> +	bool owns_as_ref;
>  };
> =20

[...]

> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u=
32 *state)
> +{
> +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> +	int ret;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state =3D perfcnt->state;
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		perfcnt->state =3D 0;
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
> +
> +	/* A reset might come through in the gap between the completion returni=
ng and the following
> +	 * check, but because no sample was produced, we don't care to relay th=
e state back to UM
> +	 */
>  	if (!ret)
> -		ret =3D -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret =3D 0;
> +		return -ETIMEDOUT;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		u32 new_state =3D perfcnt->state;
> +
> +		*state |=3D new_state;
> +		if (new_state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		perfcnt->state =3D 0;
> +
> +		/* If we faced a reset during our SAMPLE, the user needs to try again.=
 */
> +		if (new_state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> +			return -EAGAIN;

Okay, so I think we have a weird situation where sometimes the state
should be ignored when an error is returned (we don't
propagate the state on ETIMEDOUT), and sometimes not (if EAGAIN or EIO
is returned, the state has been propagated and cleared). This is problematic
if INTERRUPTED_BY_RESET is set and EAGAIN is returned, because on the next
DUMP this flag will have disappeared, and if userspace didn't store the
information on the EAGAIN, it wouldn't know the counters are disjoint.

We either need to propagate the state all the time, and document the errno
where userspace should not ignore it (EAGAIN, ETIMEDOUT and EIO), or we need
to preserve the INTERRUPTED_BY_RESET bit when EAGAIN is returned (basically
move the perfcnt->state =3D 0 below the if (INTERRUPTED_BY_RESET) branch, a=
nd
restore the state that was cleared in the first scoped_guard()).

Once addressed, this is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
