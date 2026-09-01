Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DC5C624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF46C10E3F6;
	Tue,  1 Sep 2026 12:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k/ZqZCHs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018AB10E3F6
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788267533;
 bh=HeFf1h/TleEc8dsAQ2uxWCJ/EFaBsCk3gj0/fOEmgXw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k/ZqZCHsgE1W+X4jw/ernZFJZlPs4KiBkX+GhOVp0vYRWntKEO+l0yaj0zS2THjXX
 AkdtwZ9NfDRqZ+Hjc/lhz+BBpE/d8EbLvq9v3hmy6bWoRmYUZUD1VdpPYUTMiem8z9
 NL9bXjLhHf0vxIS8Ry+h3p98taMjBo+vHWlDvo8OFytMJgu+qbLucbTOnFDMT6SiP4
 6IgPxgKFTWf7RvOsj/DABL3/boEg3u1k7i3yR+w/cGE3HnjO0VEKUvs0kbujVPmw0A
 Mgnaf/o22zvUZgDSfhv1Z9CYk/Zp0yylOhm2jXP2r8nLI4bdxhFA7FfI97aUxZD1es
 gOKdpSNsjhh+w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E3B9B17E0472;
 Tue, 01 Sep 2026 14:58:52 +0200 (CEST)
Date: Tue, 1 Sep 2026 14:58:47 +0200
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
Subject: Re: [PATCH v7 07/17] drm/panfrost: Stop all jobs before commencing
 device teardown
Message-ID: <20260901145847.779f9eb0@fedora-21.home>
In-Reply-To: <20260828-claude-fixes-v7-7-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-7-72a13b2c125d@collabora.com>
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

On Fri, 28 Aug 2026 21:56:47 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> We should make sure there are no inflight jobs at the time we finish driv=
er
> structures and synchronise their IRQs, and even more so by the time clocks
> and power domains are disabled.
>=20
> To that end, stop submissions from existing scheduler entities and force =
HW
> to stop all running jobs.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c |  2 +
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 71 ++++++++++++++++++------=
------
>  drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
>  3 files changed, 46 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 9549ddb7854a..9e02fb5f73c8 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -341,6 +341,8 @@ void panfrost_device_fini(struct panfrost_device *pfd=
ev)
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> =20
> +	panfrost_jm_stop_sched_jobs(pfdev);

Do we really want to do the SOFT_STOP+HARD_STOP dance in that case?
Can't we just SOFT_RESET the GPU and collect the pieces in the
panfrost_<component>_fini() functions?

> +
>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 5016d2d53da2..630298b7ea8a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -655,39 +655,12 @@ static u32 panfrost_active_slots(struct panfrost_de=
vice *pfdev,
>  	return js_state & *js_state_mask;
>  }
> =20
> -static void
> -panfrost_reset(struct panfrost_device *pfdev,
> -	       struct drm_sched_job *bad)
> +static void panfrost_stop_jobs(struct panfrost_device *pfdev)
>  {
>  	u32 js_state, js_state_mask =3D 0xffffffff;
>  	unsigned int i, j;
> -	bool cookie;
>  	int ret;
> =20
> -	if (!atomic_read(&pfdev->reset.pending))
> -		return;
> -
> -	/* Stop the schedulers.
> -	 *
> -	 * FIXME: We temporarily get out of the dma_fence_signalling section
> -	 * because the cleanup path generate lockdep splats when taking locks
> -	 * to release job resources. We should rework the code to follow this
> -	 * pattern:
> -	 *
> -	 *	try_lock
> -	 *	if (locked)
> -	 *		release
> -	 *	else
> -	 *		schedule_work_to_release_later
> -	 */
> -	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> -		drm_sched_stop(&pfdev->js->queue[i].sched, bad);
> -
> -	cookie =3D dma_fence_begin_signalling();
> -
> -	if (bad)
> -		drm_sched_increase_karma(bad);
> -
>  	/* Mask job interrupts and synchronize to make sure we won't be
>  	 * interrupted during our reset.
>  	 */
> @@ -730,6 +703,48 @@ panfrost_reset(struct panfrost_device *pfdev,
>  	}
>  	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
>  	spin_unlock(&pfdev->js->job_lock);
> +}
> +
> +void panfrost_jm_stop_sched_jobs(struct panfrost_device *pfdev)
> +{
> +	for (u32 i =3D 0; i < NUM_JOB_SLOTS; i++)
> +		drm_sched_wqueue_stop(&pfdev->js->queue[i].sched);

Do we have something cleaning up the pending list if this is stopped
while jobs are in-flight? If not, we probably need a ::cancel_job()
implementation.

> +
> +	panfrost_stop_jobs(pfdev);
> +}
> +
> +static void
> +panfrost_reset(struct panfrost_device *pfdev,
> +	       struct drm_sched_job *bad)
> +{
> +	unsigned int i;
> +	bool cookie;
> +
> +	if (!atomic_read(&pfdev->reset.pending))
> +		return;
> +
> +	/* Stop the schedulers.
> +	 *
> +	 * FIXME: We temporarily get out of the dma_fence_signalling section
> +	 * because the cleanup path generate lockdep splats when taking locks
> +	 * to release job resources. We should rework the code to follow this
> +	 * pattern:
> +	 *
> +	 *	try_lock
> +	 *	if (locked)
> +	 *		release
> +	 *	else
> +	 *		schedule_work_to_release_later
> +	 */
> +	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> +		drm_sched_stop(&pfdev->js->queue[i].sched, bad);
> +
> +	cookie =3D dma_fence_begin_signalling();
> +
> +	if (bad)
> +		drm_sched_increase_karma(bad);
> +
> +	panfrost_stop_jobs(pfdev);
> =20
>  	/* Proceed with reset now. */
>  	panfrost_device_reset(pfdev, false);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/pa=
nfrost/panfrost_job.h
> index 3e3b9717838f..dc9d3c9dc67b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.h
> @@ -73,6 +73,7 @@ int panfrost_jm_is_idle(struct panfrost_device *pfdev);
>  int panfrost_job_get_slot(struct panfrost_job *job);
>  int panfrost_job_push(struct panfrost_job *job);
>  void panfrost_job_put(struct panfrost_job *job);
> +void panfrost_jm_stop_sched_jobs(struct panfrost_device *pfdev);
> =20
>  #ifdef CONFIG_DEBUG_FS
>  void panfrost_sched_debugfs_init(struct drm_minor *minor);
>=20

