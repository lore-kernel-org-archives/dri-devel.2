Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0107C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF14A10E2BB;
	Wed,  2 Sep 2026 16:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GoRQs/de";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F04F10E2BB
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788367900;
 bh=rz2Cl/LZ7GutHMT7RF43QRlnSxaG28sWwCvD2sypBKk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GoRQs/deptLhvJ++VmkXbuegtmMXljOdGyoTs1V0qRqBccJV1NUnzfCcVHAeSCAba
 YT6azKlcxXfufLe2TnZnOq04OvovYvEncg6RVeBpJDdZofDuchrtUvpqwUnHLK+5Tu
 wkL/onLXPJEYeIHu6StQ6O8Zc7VPAs/p8lPiLQJdVshpmOw//N59oR7SJLP8Sp3Zk5
 fNH2n00R2KQIkjQMW2MkLk6e6S89OddoeZXSHSt01XdcqQF9bJV1jjnZL1o7ed6uZB
 B+22QNbQ/lVlE9Kh/KexuXcTX6bbBKyPRUkNkIoxOmGKdcRELpJn1vvIaqn5LFV4c8
 ThyBKplKA47wA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7CBAD17E0DD8;
 Wed, 02 Sep 2026 18:51:39 +0200 (CEST)
Date: Wed, 2 Sep 2026 18:51:34 +0200
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
Message-ID: <20260902185134.592ecc81@fedora-21.home>
In-Reply-To: <aphEYmFOxITYikRU@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-16-72a13b2c125d@collabora.com>
 <20260901160344.586a2295@fedora-21.home>
 <aphEYmFOxITYikRU@sobremesa>
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

On Wed, 2 Sep 2026 16:45:38 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 01.09.2026 16:03, Boris Brezillon wrote:
> > On Fri, 28 Aug 2026 21:56:56 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> >  =20
> > > Formerly, the reset sequence would race with panfrost_mmu_as_put()
> > > when tearing down a perfcnt session. On top of that, poking GPU
> > > registers to program a perfcnt session or obtaining a dump might lead=
 to
> > > undefined behaviour when done at the same time a reset was ongoing.
> > >=20
> > > Use the reset r/w semaphore to govern access to the hardware at reset
> > > time. On top of that, expand the DRM uAPI for the perfcnt DUMP operat=
ion
> > > so that userspace can be made aware of a reset having happened, becau=
se
> > > that means counters will go back to 0 and can no longer be accumulated
> > > to values previously kept in user space.
> > >=20
> > > The new perfcnt-aware reset sequence also takes care to reestablish
> > > perfcnt to its original configuration if there was an enabled session.
> > >=20
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_device.c  |   1 +
> > >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 189 ++++++++++++++++++=
++--------
> > >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
> > >  include/uapi/drm/panfrost_drm.h             |   3 +-
> > >  4 files changed, 140 insertions(+), 54 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu=
/drm/panfrost/panfrost_device.c
> > > index c8c5dc26b03d..471bd4b037e6 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > @@ -498,6 +498,7 @@ void panfrost_device_reset(struct panfrost_device=
 *pfdev)
> > >  	panfrost_gpu_power_on(pfdev);
> > >  	panfrost_mmu_reset(pfdev);
> > >  	panfrost_jm_reset_interrupts(pfdev);
> > > +	panfrost_perfcnt_reset(pfdev);
> > >  }
> > > =20
> > >  static int panfrost_device_runtime_resume(struct device *dev)
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gp=
u/drm/panfrost/panfrost_perfcnt.c
> > > index b3f71d7fd82a..0564aa2753f9 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > > @@ -11,6 +11,7 @@
> > >  #include <drm/drm_file.h>
> > >  #include <drm/drm_gem_shmem_helper.h>
> > >  #include <drm/panfrost_drm.h>
> > > +#include <drm/drm_print.h>
> > > =20
> > >  #include "panfrost_device.h"
> > >  #include "panfrost_features.h"
> > > @@ -25,14 +26,18 @@
> > >  #define BYTES_PER_COUNTER		4
> > >  #define BLOCKS_PER_COREGROUP		8
> > >  #define V4_SHADERS_PER_COREGROUP	4
> > > +#define PERFCNT_DUMP_MAX_RETRIES	5
> > > =20
> > >  struct panfrost_perfcnt {
> > >  	struct panfrost_gem_mapping *mapping;
> > > +	unsigned int counterset;
> > >  	size_t bosize;
> > >  	void *buf;
> > >  	struct panfrost_file_priv *user;
> > >  	struct mutex lock;
> > >  	struct completion dump_comp;
> > > +	bool reset_happened;
> > > +	bool reset_failed;
> > >  };
> > > =20
> > >  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfde=
v)
> > > @@ -58,25 +63,107 @@ void panfrost_perfcnt_sample_done(struct panfros=
t_device *pfdev)
> > >  		complete(&pfdev->perfcnt->dump_comp);
> > >  }
> > > =20
> > > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfde=
v)
> > > +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> > >  {
> > > -	u64 gpuva;
> > > +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> > > +	u32 cfg, as;
> > >  	int ret;
> > > =20
> > > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > > -	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > > -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > > -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > > +	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	as =3D ret;
> > > +	cfg =3D GPU_PERFCNT_CFG_AS(as) |
> > > +	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> > > +
> > > +	/*
> > > +	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> > > +	 * the first one for now.
> > > +	 */
> > > +	if (panfrost_model_is_bifrost(pfdev))
> > > +		cfg |=3D GPU_PERFCNT_CFG_SETSEL(perfcnt->counterset);
> > > +
> > > +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> > > +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> > > +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> > > +
> > > +	/*
> > > +	 * Due to PRLAM-8186 we need to disable the Tiler before we enable =
HW
> > > +	 * counters.
> > > +	 */
> > > +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > > +	else
> > > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > > +
> > > +	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> > > +
> > > +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfde=
v,
> > > +					u64 *reset_happened)
> > > +{
> > > +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> > > +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > > +	s64 retries =3D PERFCNT_DUMP_MAX_RETRIES;
> > > +	bool retry;
> > > +	int ret;
> > > +
> > > +dump_retry:
> > > +	retry =3D false;
> > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > +		*reset_happened =3D perfcnt->reset_happened;
> > > +		perfcnt->reset_happened =3D false;
> > > +		if (perfcnt->reset_failed) { =20
> >=20
> > I'd rather treat that as a terminal fault (returning -EIO, and maybe
> > reflecting the perf session as dead through some state flag) in order
> > to force the user to re-create a session. The only case where it would
> > fail is if as_get() fails, and it's not supposed to fail after a reset.
> > This should simplify the dump logic quite a bit. =20
>=20
> Does that mean forcing the user to go through the disable/enable dance?

So, if we failed to re-enable (which, again, is unlikely if not
impossible), yes, this would force a DISABLE/ENABLE dance.

> I thought because in the event of a reset, UM would still like to claim o=
wnership
> of perfcnt, recovering within the dump ioctl itself and notifying that a =
reset happened
> so that it can respond to counters also being reset was the quickest way =
around.

Silently re-enabling and notifying about the RESET disturbing the
counters makes sense, because things are still functional. What I don't
like with this retry approach is the fact it doesn't really solve the
problem because you have a limited amount of attempts, and does add a
fair amount of complexity (take the lock, issue the command, release
the lock, wait, take the lock, check the state, release the lock, retry
if it failed)

>=20
> > > +			ret =3D panfrost_perfcnt_hw_enable(pfdev);
> > > +			if (ret)
> > > +				return ret;
> > > +			perfcnt->reset_failed =3D false;
> > > +		}
> > > +
> > > +		reinit_completion(&pfdev->perfcnt->dump_comp);
> > > +
> > > +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > > +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > > +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > > +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Here we release the reset semaphore because perfcnt should not g=
et in the way
> > > +	 * of a HW reset. The downside is in the gap between the completion=
 is flagged
> > > +	 * by the GPU IRQ handler and the sempahore taken once again, yet a=
nother reset
> > > +	 * could happen, which would lead to a valid sample being discarded=
. This is
> > > +	 * a solution of compromise between ensuring synchronisation with t=
he reset
> > > +	 * sequence and letting it happen as quickly as possible for jobs t=
o be rerun.
> > > +	 */
> > > +
> > >  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->=
dump_comp,
> > >  							msecs_to_jiffies(1000));
> > > -	if (!ret)
> > > -		ret =3D -ETIMEDOUT;
> > > -	else if (ret > 0)
> > > -		ret =3D 0;
> > > +
> > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > +		if (ret > 0) {
> > > +			if (perfcnt->reset_happened) {
> > > +				if (--retries >=3D 0)
> > > +					retry =3D true;
> > > +				else
> > > +					ret =3D -EBUSY;
> > > +			} else {
> > > +				ret =3D 0;
> > > +			}
> > > +		} else if (!ret) {
> > > +			ret =3D -ETIMEDOUT;
> > > +		}
> > > +	} =20
> >=20
> > I think it's fine to return -EAGAIN here and skip the retry, because
> > what's important is the re-enable part: get the counting running again
> > as soon as we can, so that, if the user-side sampling is done at a low
> > rate, we still get non-zero values between two dumps when a reset
> > occurred in the middle. =20
>=20
> I'm a bit confused about the uAPI you have in mind. When would we return =
-EAGAIN and when -EIO?

So, EAGAIN is if your SAMPLE request is interrupted by a RESET, but
counters were properly re-enabled after the RESET. This basically gets
rid of the retry logic kernel side and leaves that to the UMD.

EIO if when the re-enable failed.

> I guess the former would signal that a dump ioctl can be re-attempted, wh=
ile the latter that
> a whole perfcnt_disable/enable cycle needs to happen before issuing a new=
 dump.

Yep, this.

>=20
> > > +
> > > +	if (retry)
> > > +		goto dump_retry;
> > > =20
> > >  	return ret;
> > >  }
> > > @@ -87,9 +174,8 @@ static int panfrost_perfcnt_enable_locked(struct p=
anfrost_device *pfdev,
> > >  {
> > >  	struct panfrost_file_priv *user =3D file_priv->driver_priv;
> > >  	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> > > -	struct iosys_map map;
> > >  	struct drm_gem_shmem_object *bo;
> > > -	u32 cfg, as;
> > > +	struct iosys_map map;
> > >  	int ret;
> > > =20
> > >  	if (user =3D=3D perfcnt->user)
> > > @@ -122,7 +208,9 @@ static int panfrost_perfcnt_enable_locked(struct =
panfrost_device *pfdev,
> > >  	ret =3D drm_gem_vmap(&bo->base, &map);
> > >  	if (ret)
> > >  		goto err_put_mapping;
> > > +
> > >  	perfcnt->buf =3D map.vaddr;
> > > +	perfcnt->counterset =3D counterset;
> > > =20
> > >  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> > > =20
> > > @@ -132,44 +220,19 @@ static int panfrost_perfcnt_enable_locked(struc=
t panfrost_device *pfdev,
> > >  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > >  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> > > =20
> > > -	ret =3D panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> > > -	if (ret < 0)
> > > -		goto err_vunmap;
> > > -
> > > -	as =3D ret;
> > > -	cfg =3D GPU_PERFCNT_CFG_AS(as) |
> > > -	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> > > -
> > > -	/*
> > > -	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> > > -	 * the first one for now.
> > > -	 */
> > > -	if (panfrost_model_is_bifrost(pfdev))
> > > -		cfg |=3D GPU_PERFCNT_CFG_SETSEL(counterset);
> > > -
> > > -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> > > -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> > > -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > +		ret =3D panfrost_perfcnt_hw_enable(pfdev);
> > > +		if (ret)
> > > +			goto err_vunmap;
> > > =20
> > > -	/*
> > > -	 * Due to PRLAM-8186 we need to disable the Tiler before we enable =
HW
> > > -	 * counters.
> > > -	 */
> > > -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > > -	else
> > > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > > -
> > > -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> > > -
> > > -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > > +		perfcnt->reset_happened =3D false;
> > > +		perfcnt->reset_failed =3D false;
> > > +		perfcnt->user =3D user;
> > > +	}
> > > =20
> > >  	/* The BO ref is retained by the mapping. */
> > >  	drm_gem_object_put(&bo->base);
> > > =20
> > > -	perfcnt->user =3D user;
> > > -
> > >  	return 0;
> > > =20
> > >  err_vunmap:
> > > @@ -195,13 +258,16 @@ static int panfrost_perfcnt_disable_locked(stru=
ct panfrost_device *pfdev,
> > >  	if (user !=3D perfcnt->user)
> > >  		return -EINVAL;
> > > =20
> > > -	panfrost_perfcnt_hw_disable(pfdev);
> > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > +		panfrost_perfcnt_hw_disable(pfdev);
> > > +		if (!perfcnt->reset_failed)
> > > +			panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu); =20
> >=20
> > Let's not conflate !reset_failed and owns_as_slot, even if they are
> > related in practice. =20
>=20
> I did this so that mmu->as_count would be kept balanced in case a reset h=
appened but
> panfrost_mmu_as_get() for perfcnt's AS failed during recovery in panfrost=
_perfcnt_hw_enable().
> Because mmu->as_count can only be 0 during perfcnt_disabled when perfcnt_=
reset has failed,
> I thought this conflation was reasonable. Alternatively I could just poke=
 into mmu->as_count
> to make sure it's greater than 0, but that sounds like inspecting private=
 MMU implementation
> details from the perfcnt subsystem and it doesn't look good.

No, I'm actually suggesting keeping track of this information through a
dedicated field. Can be:

	// >=3D0 =3D> owns an AS ref
	int as_id;

or:

	// true when the perfcnt session owns an AS ref
	bool owns_as_ref;

and you set/reset that field in the enable/disable/reset path.
