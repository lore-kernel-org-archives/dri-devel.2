Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3C606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZRIS+CC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0673E112574;
	Thu, 26 Nov 2026 16:01:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688D3112572;
 Thu, 26 Nov 2026 16:01:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E1D0661D0A;
 Thu, 26 Nov 2026 16:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD0B1F000D0;
 Thu, 26 Nov 2026 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795708852;
 bh=SWjD6PLxz9KndqGcYLO0+S3kCBNR1pBxV1hz/urwc1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bZRIS+CCpfFjHJ1kcFZ+kylrKmaJ5vm+jbQl24LsiQSin4Pbx1SXvAp+Yhip841ux
 YkfXMuL1JyIqIDAUcVMcMR7X+Ko1xnYAekwrGKxG4F1nVjkgmx6jWPtcZsC6Qe7rmc
 mZ1bL1FeYDUBCsCeGA0ddGS3wSFfBX4niFh80SYcipJbh4WSctYcwOp1Mamhi40tXn
 v7X9MvEqZO+PEUwjWQTRFRC2usnThbeYul8DIXkbx7zD8xBarkxV7P8mWy4UaTi4D6
 iEGRH8+Pip9c4IyNy7Sk7eI4LiAgAPWVHAgv67sxcMXySBcKBueiYKwXRzrfTrGjhA
 nbeBp0tN0x9PA==
Message-ID: <sashiko-outbox-235869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC] drm/sched: Track sched fence scheduled and finished time
 directly
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
References: <20261126154200.71180-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:00:51 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/sched: drm_sched_fence_advance_start_time() advances
  start_ts past end
- [Medium] drm/sched: race in drm_sched_fence_scheduled() drops start_ts
  advancement
- [Low] drm/sched: wrong kernel-doc comment on
  drm_sched_fence_finished_time()
--

commit 410c845aad37c46edfe8c0d12fc45e44b4afc986
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Track sched fence scheduled and finished time directly

This commit records scheduled and finished timestamps directly in struct
drm_sched_fence under a dedicated spinlock instead of reading and
overwriting dma_fence.timestamp.

> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/sc=
heduler/sched_fence.c
> index 94ba0cf4fe027..5fecd3ebfffbb 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -65,6 +65,9 @@ static void drm_sched_fence_set_parent(struct drm_sched=
_fence *s_fence,
>  void drm_sched_fence_scheduled(struct drm_sched_fence *fence,
>  			       struct dma_fence *parent)
>  {
> +	ktime_t now =3D ktime_get();
> +	unsigned long flags;
> +
>  	/* Set the parent before signaling the scheduled fence, such that,
>  	 * any waiter expecting the parent to be filled after the job has
>  	 * been scheduled (which is the case for drivers delegating waits
> @@ -74,14 +77,26 @@ void drm_sched_fence_scheduled(struct drm_sched_fence=
 *fence,
>  	if (!IS_ERR_OR_NULL(parent))
>  		drm_sched_fence_set_parent(fence, parent);
> =20
> -	dma_fence_signal(&fence->scheduled);
> +	spin_lock_irqsave(&fence->ts_lock, flags);
> +	fence->start_ts =3D now;
> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
> +
> +	dma_fence_signal_timestamp(&fence->scheduled, now);
>  }

[Severity: Medium]
Can drm_sched_fence_scheduled() overwrite a start_ts advancement on an
unordered submit_wq?

drm_sched_run_job_work() adds the job to sched->pending_list in
drm_sched_job_begin() before calling run_job() and
drm_sched_fence_scheduled().  If the previous head job finishes while
this job is between drm_sched_job_begin() and acquiring fence->ts_lock:

work_run_job (next)               work_free_job (prev)
drm_sched_job_begin(next)
  list_add_tail(..., pending_list)
fence =3D run_job(next)
drm_sched_fence_scheduled()
  now =3D ktime_get()
                                  drm_sched_get_finished_job()
                                    ts =3D ...finished_time(prev)
                                    drm_sched_fence_advance_start_time()
                                      /* start_ts =3D=3D 0, no-op */
  spin_lock(&fence->ts_lock)
  fence->start_ts =3D now;  <-- older than prev's finished_ts

The advancement to prev's finish timestamp is lost and next->s_fence
keeps the earlier timestamp, overaccounting GPU time.

[ ... ]

> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm=
/scheduler/sched_internal.h
> index 32d3ddb820be6..be90e55af9470 100644
> --- a/drivers/gpu/drm/scheduler/sched_internal.h
> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
> @@ -67,6 +67,47 @@ void drm_sched_fence_scheduled(struct drm_sched_fence =
*fence,
>  			       struct dma_fence *parent);
>  void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
> =20
> +/**
> + * drm_sched_fence_advance_start_time - Advance scheduler fence schedule=
d timestamp
> + * @fence: scheduler fence
> + * @t: time to advance to
> + *
> + * Advances the scheduler fence scheduled time to @t if the fence has al=
ready
> + * been scheduled with an older timestamp.
> + */
> +static inline void
> +drm_sched_fence_advance_start_time(struct drm_sched_fence *fence, ktime_=
t t)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fence->ts_lock, flags);
> +	if (fence->start_ts && ktime_after(t, fence->start_ts))
> +		fence->start_ts =3D t;
> +	spin_unlock_irqrestore(&fence->ts_lock, flags);
> +}

[Severity: Medium]
Can drm_sched_fence_advance_start_time() advance fence->start_ts past an
already recorded fence->finished_ts?

If a later job on sched->pending_list finishes before the head job (for
example, when run_job() returns an error or NULL for a canceled job so
drm_sched_run_job_work() immediately calls drm_sched_job_done(), or when
parent fences signal out of order), next->s_fence->finished_ts is set to
T1 while next remains queued behind the head job.  When the head job
later completes at T2 > T1, drm_sched_get_finished_job() advances
next->s_fence->start_ts to T2 because drm_sched_fence_advance_start_time()
does not check fence->finished_ts.

ktime_sub(end, start) then yields a negative duration in
drm_sched_entity_stats_job_add_gpu_time() and amdgpu_ctx_fence_time(),
subtracting from accumulated runtime and passing a negative value cast to
unsigned long into ewma_drm_sched_avgtime_add(), which wraps
stats->avg_job_us and sched->avg_job_us near ULONG_MAX.

> +
> +/**
> + * drm_sched_fence_finished_time - Queries the scheduler fence finished =
timestamp
> + * @fence: scheduler fence
> + *
> + * Advances the scheduler fence scheduled time to @t if the fence has al=
ready
> + * been scheduled with an older timestamp.
> + *
> + * Returns: Scheduler fence finished timestamp.
> + */

[Severity: Low]
This kernel-doc body looks copy-pasted from
drm_sched_fence_advance_start_time() and refers to @t, which
drm_sched_fence_finished_time() does not take.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126154200.7118=
0-1-tvrtko.ursulin@igalia.com?part=3D1
