Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C138CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD88D10EF32;
	Tue,  2 Jun 2026 11:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jgb+fxYg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F69B10E046
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7RgJfVQx32/rYLUVjSWUv2ZbHkzbURK8tDCps/DhjpU=; b=jgb+fxYgPPBFYDLQQSZO8rZAhP
 biVEEcJFEXtwDCWzczu9O1Trae2GdYkBGwNd1nOC3Yzi5v4DedRbO+MCs09A2FBHFHZQDYh396uQu
 XssLFATCSkg2FoJUMloh0F/z7/7U+Za2fvG23R3axJ10ge/w5YSk6lYcrsP4n/LvPi/wHKJ2di8pI
 T9YKMw+Tsul4sGiVzfnL1keQyShuZOdLkiZKHOQwPF5qU34hIAq8a8pJ1LeCG/CSwrEZPD53kqrGA
 03tiJUYlKqK+MDMzuOLJbMqkhEP05ZmQD8GIEVDulCMXMH1U4E4d6hR92XGN7wbj8+w9VRCm94o8Z
 AzOr42GA==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUN1O-00BfPi-EM; Tue, 02 Jun 2026 13:10:58 +0200
Message-ID: <d91f5f3365fc0b59d1bebeba04bed156aad85d9b.camel@igalia.com>
Subject: Re: [PATCH v2 3/4] drm/v3d: Serialize jobs across queues when a
 perfmon is attached
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 02 Jun 2026 13:10:47 +0200
In-Reply-To: <44cbf6ec-3134-44d5-b37c-0c99ac55f678@igalia.com>
References: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
 <20260531-v3d-perfmon-lifetime-v2-3-60ed4485a203@igalia.com>
 <7a9d503de81b403585962f1c25dd0b506a6eb3f2.camel@igalia.com>
 <44cbf6ec-3134-44d5-b37c-0c99ac55f678@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

Hi Ma=C3=ADra,

thanks for clarifying this. For the series:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

Iago

El mar, 02-06-2026 a las 07:49 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 02/06/26 04:35, Iago Toral wrote:
> > Hi Ma=C3=ADra, this pactch looks good to me but I am wondering if we
> > should
> > do anything to clean up the perfmon state when a gpu reset happens:
> > i.e. what would happen if a perfmon job resets? Would we continue
> > to
> > schedule after-reset jobs to wait on the fence of the reset job?
>=20
> If the job resets, the design around the DRM scheduler will protect
> us.
>=20
> The DRM scheduler guarantees that a finished fence is always signaled
> eventually. On a reset, drm_sched_start() signals the pending jobs'
> finished fences (with -ECANCELED for the guilty job). So if a
> perfmon-carrying job is the one that times out, the done_fence we
> stored for serialization still gets signaled when resubmitted (check
> the
> first if-clause in the run_job() callbacks).
>=20
> drm_sched_job_add_dependency() releases the dependent job as soon as
> the
> fence signals, regardless of error, so any job submitted behind the
> reset perfmon job is released and runs. The serialization window
> simply
> closes when the job dies.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> >=20
> > Iago
> >=20
> > El dom, 31-05-2026 a las 17:18 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> > > A non-global perfmon is meant to count events generated by a
> > > specific
> > > submission, but the scheduler can run jobs from different queues
> > > concurrently on the same V3D core. Without explicit
> > > serialization, an
> > > unrelated job running in parallel with a perfmon-carrying job
> > > pollutes
> > > the counters and generates unusable results.
> > >=20
> > > To address such issue, we must enforce cross-queue serialization
> > > when
> > > we
> > > detect a perfmon-carrying submission. It's possible to implement
> > > serialization by enforcing two rules:
> > >=20
> > > =C2=A0=C2=A0 1. A job that carries a non-global perfmon must wait for=
 every
> > > job
> > > =C2=A0=C2=A0=C2=A0=C2=A0 currently in-flight across all HW queues to =
finish.
> > >=20
> > > =C2=A0=C2=A0 2. While a perfmon-carrying job is still in-flight, all
> > > subsequently
> > > =C2=A0=C2=A0=C2=A0=C2=A0 submitted jobs must wait for it.
> > >=20
> > > Note that serialization is not needed in the global perfmon case,
> > > as
> > > the
> > > global perfmon tracks activity from all jobs, so concurrency is
> > > desirable.
> > >=20
> > > Therefore, check if serialization is needed during job submission
> > > and
> > > if
> > > so, attach fence dependences to enforce cross-queue
> > > serialization.
> > >=20
> > > Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/v3d/v3d_drv.h=C2=A0=C2=A0=C2=A0=C2=A0 | 3=
5 ++++++++++++++++++----
> > > =C2=A0=C2=A0drivers/gpu/drm/v3d/v3d_gem.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 ++
> > > =C2=A0=C2=A0drivers/gpu/drm/v3d/v3d_perfmon.c |=C2=A0 6 ++++
> > > =C2=A0=C2=A0drivers/gpu/drm/v3d/v3d_submit.c=C2=A0 | 63
> > > +++++++++++++++++++++++++++++++++++++++
> > > =C2=A0=C2=A04 files changed, 101 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/v3d/v3d_drv.h
> > > b/drivers/gpu/drm/v3d/v3d_drv.h
> > > index 51486af68cf4..cdf4926d51f2 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_drv.h
> > > +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> > > @@ -74,11 +74,13 @@ struct v3d_queue_state {
> > > =C2=A0=C2=A0	spinlock_t queue_lock;
> > > =C2=A0=C2=A0};
> > > =C2=A0=20
> > > -/* Performance monitor object. The perform lifetime is
> > > controlled by
> > > userspace
> > > - * using perfmon related ioctls. A perfmon can be attached to a
> > > submit_cl
> > > - * request, and when this is the case, HW perf counters will be
> > > activated just
> > > - * before the submit_cl is submitted to the GPU and disabled
> > > when
> > > the job is
> > > - * done. This way, only events related to a specific job will be
> > > counted.
> > > +/* Performance monitor object
> > > + *
> > > + * The performance monitor (perfmon) lifetime is controlled by
> > > userspace using
> > > + * perfmon related ioctls. A perfmon can be attached to a CL or
> > > CSD
> > > submission
> > > + * request, and when it is, HW performance counters will be
> > > activated just
> > > + * before the job is submitted to the GPU and disabled when the
> > > job
> > > is done.
> > > + * This way, only events related to a specific submission will
> > > be
> > > counted.
> > > =C2=A0=C2=A0 */
> > > =C2=A0=C2=A0struct v3d_perfmon {
> > > =C2=A0=C2=A0	/* Tracks the number of users of the perfmon, when this
> > > counter reaches
> > > @@ -167,13 +169,31 @@ struct v3d_dev {
> > > =C2=A0=20
> > > =C2=A0=C2=A0	struct v3d_queue_state queue[V3D_MAX_QUEUES];
> > > =C2=A0=20
> > > -	/* Tracks the performance monitor state. */
> > > +	/*
> > > +	 * Tracks the performance monitor state and consistency.
> > > +	 *
> > > +	 * When a non-global perfmon is attached to a job, the
> > > scheduler must
> > > +	 * not run any other job on the HW concurrently
> > > (otherwise,
> > > the
> > > +	 * counters would be polluted by unrelated work).
> > > +	 */
> > > =C2=A0=C2=A0	struct {
> > > =C2=A0=C2=A0		/* Protects @active. */
> > > =C2=A0=C2=A0		spinlock_t lock;
> > > =C2=A0=20
> > > =C2=A0=C2=A0		/* Perfmon currently programmed in HW (or NULL
> > > if
> > > none). */
> > > =C2=A0=C2=A0		struct v3d_perfmon *active;
> > > +
> > > +		/* Finished fence of the most recently submitted
> > > job
> > > that
> > > +		 * opened a serialization window (i.e. a job
> > > with a
> > > non-global
> > > +		 * perfmon attached).
> > > +		 */
> > > +		struct dma_fence *fence;
> > > +
> > > +		/* Finished fence of the most recently submitted
> > > job
> > > on each HW
> > > +		 * queue. Used so that a new perfmon-carrying
> > > job
> > > can depend on
> > > +		 * every job currently in-flight across all
> > > queues.
> > > +		 */
> > > +		struct dma_fence *last_hw_fence[V3D_MAX_QUEUES];
> > > =C2=A0=C2=A0	} perfmon_state;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/* Protects bo_stats */
> > > @@ -319,6 +339,9 @@ struct v3d_job {
> > > =C2=A0=20
> > > =C2=A0=C2=A0	struct v3d_dev *v3d;
> > > =C2=A0=20
> > > +	/* The queue that the job was submitted on. */
> > > +	enum v3d_queue queue;
> > > +
> > > =C2=A0=C2=A0	/* This is the array of BOs that were looked up at the
> > > start
> > > =C2=A0=C2=A0	 * of submission.
> > > =C2=A0=C2=A0	 */
> > > diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
> > > b/drivers/gpu/drm/v3d/v3d_gem.c
> > > index 9487ab7acd03..0b415486f5b4 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_gem.c
> > > +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> > > @@ -363,8 +363,11 @@ v3d_gem_destroy(struct drm_device *dev)
> > > =C2=A0=C2=A0	for (q =3D 0; q < V3D_MAX_QUEUES; q++) {
> > > =C2=A0=C2=A0		WARN_ON(v3d->queue[q].active_job);
> > > =C2=A0=C2=A0		v3d_stats_put(v3d->queue[q].stats);
> > > +		dma_fence_put(v3d-
> > > >perfmon_state.last_hw_fence[q]);
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > +	dma_fence_put(v3d->perfmon_state.fence);
> > > +
> > > =C2=A0=C2=A0	drm_mm_takedown(&v3d->mm);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	dma_free_coherent(v3d->drm.dev, 4096 * 1024, (void
> > > *)v3d-
> > > > pt,
> > > diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c
> > > b/drivers/gpu/drm/v3d/v3d_perfmon.c
> > > index 3ad0f022753c..07dab7fb3060 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> > > +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> > > @@ -275,6 +275,12 @@ void v3d_perfmon_start(struct v3d_dev *v3d,
> > > struct v3d_perfmon *perfmon)
> > > =C2=A0=C2=A0	if (!perfmon || v3d->global_perfmon)
> > > =C2=A0=C2=A0		return;
> > > =C2=A0=20
> > > +	/* Cross-queue serialization should have drained any
> > > previous perfmon
> > > +	 * job before this one runs.
> > > +	 */
> > > +	if (WARN_ON_ONCE(v3d->perfmon_state.active))
> > > +		return;
> > > +
> > > =C2=A0=C2=A0	if (!pm_runtime_get_if_active(v3d->drm.dev))
> > > =C2=A0=C2=A0		return;
> > > =C2=A0=20
> > > diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
> > > b/drivers/gpu/drm/v3d/v3d_submit.c
> > > index 4c526aafc4e0..46fc88bacc95 100644
> > > --- a/drivers/gpu/drm/v3d/v3d_submit.c
> > > +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> > > @@ -234,6 +234,7 @@ v3d_submit_add_job(struct v3d_submit *submit,
> > > void **container, size_t size,
> > > =C2=A0=C2=A0	job->v3d =3D v3d;
> > > =C2=A0=C2=A0	job->free =3D free;
> > > =C2=A0=C2=A0	job->file_priv =3D v3d_priv;
> > > +	job->queue =3D queue;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	ret =3D drm_sched_job_init(&job->base, &v3d_priv-
> > > > sched_entity[queue],
> > > =C2=A0=C2=A0				 1, v3d_priv, submit->file_priv-
> > > > client_id);
> > > @@ -293,6 +294,62 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit
> > > *submit, u32 perfmon_id)
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +/*
> > > + * Prepare fences to enforce job serialization when a perfmon is
> > > active. A job
> > > + * that carries a non-global perfmon must wait for every job
> > > currently in-flight
> > > + * across all HW queues to finish, otherwise concurrent
> > > unrelated
> > > work on the
> > > + * same core would pollute the performance counters.
> > > Symmetrically,
> > > while such a
> > > + * job is still in-flight, all subsequently submitted jobs must
> > > wait
> > > for it.
> > > + *
> > > + * We don't serialize the jobs when using a global perfmon as
> > > it's
> > > expected to
> > > + * track concurrent activity from all jobs.
> > > + */
> > > +static int
> > > +v3d_serialize_for_perfmon(struct v3d_job *job)
> > > +{
> > > +	struct v3d_dev *v3d =3D job->v3d;
> > > +	bool is_global_perfmon;
> > > +	int ret;
> > > +
> > > +	lockdep_assert_held(&v3d->sched_lock);
> > > +
> > > +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
> > > +		is_global_perfmon =3D !!v3d->global_perfmon;
> > > +
> > > +	if (is_global_perfmon)
> > > +		goto publish;
> > > +
> > > +	if (job->perfmon) {
> > > +		for (enum v3d_queue q =3D 0; q < V3D_MAX_QUEUES;
> > > q++)
> > > {
> > > +			struct dma_fence *f =3D v3d-
> > > > perfmon_state.last_hw_fence[q];
> > > +
> > > +			if (!f || dma_fence_is_signaled(f))
> > > +				continue;
> > > +
> > > +			ret =3D drm_sched_job_add_dependency(&job-
> > > > base, dma_fence_get(f));
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +	} else if (v3d->perfmon_state.fence &&
> > > +		=C2=A0=C2=A0 !dma_fence_is_signaled(v3d-
> > > >perfmon_state.fence))
> > > {
> > > +		ret =3D drm_sched_job_add_dependency(&job->base,
> > > +					=09
> > > dma_fence_get(v3d->perfmon_state.fence));
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +publish:
> > > +	dma_fence_put(v3d->perfmon_state.last_hw_fence[job-
> > > >queue]);
> > > +	v3d->perfmon_state.last_hw_fence[job->queue] =3D
> > > dma_fence_get(job->done_fence);
> > > +
> > > +	if (job->perfmon && !is_global_perfmon) {
> > > +		dma_fence_put(v3d->perfmon_state.fence);
> > > +		v3d->perfmon_state.fence =3D dma_fence_get(job-
> > > > done_fence);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > =C2=A0=C2=A0static void
> > > =C2=A0=C2=A0v3d_submit_attach_object_fences(struct v3d_submit *submit=
)
> > > =C2=A0=C2=A0{
> > > @@ -337,6 +394,12 @@ v3d_submit_jobs(struct v3d_submit *submit)
> > > =C2=A0=C2=A0			goto err;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > +	for (int i =3D 0; i < submit->job_count; i++) {
> > > +		ret =3D v3d_serialize_for_perfmon(submit-
> > > >jobs[i]);
> > > +		if (ret)
> > > +			goto err;
> > > +	}
> > > +
> > > =C2=A0=C2=A0	for (int i =3D 0; i < submit->job_count; i++)
> > > =C2=A0=C2=A0		drm_sched_entity_push_job(&submit->jobs[i]-
> > > >base);
> > > =C2=A0=20
> > >=20
> >=20
>=20
>=20

