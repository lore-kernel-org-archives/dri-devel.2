Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB8606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KyNLaFxY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CEC10E401;
	Sat, 28 Nov 2026 08:43:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED8110E401
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 08:42:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6F0860148;
 Sat, 28 Nov 2026 08:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596EB1F000C1;
 Sat, 28 Nov 2026 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795855376;
 bh=XVpHSkyEiDjG8SVxMqyYjD18BzBAI1ohPpUo1wzhNH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KyNLaFxYJay7h2xk/4PE9RUlJHu7NiR75rqHrWgt9uuMoBIebnkNMwTO1XKRD+0A9
 2BBZ+UaFhoRe9V8w3PdrhuUccxGsEsyCm3EcIgVyR2cgHCDLCqLS+P6Oq/+5AgcD1l
 hHT/R5zk9k6VOptl8ufVpEVqiM9SDTnF+ujjIhc2sOP7ZxWdSNJfk3Is46kx0RmNyk
 awUm/nfpZaM2YI0J3Yqxs1V2+8yI0zL7gP3K5M7wgoFqP6N0OMCXK9rrqThF9d+BGi
 aE7F6iwkB+DPg2I4Gm9T/Jde93QeSKqVz5+SR3FShWvdsyIeAyMbu8FVdsfuStbUbc
 2eMhQB+mx0dsA==
Message-ID: <sashiko-outbox-238559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Sanitise wqueue_start/wqueue_stop/is_stopped
 interleavings
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261128-drm-sched-fini-race-v1-1-9803ee8aa8b4@collabora.com>
References: <20261128-drm-sched-fini-race-v1-1-9803ee8aa8b4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 08:42:55 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/sched: unbalanced work disable depth in wqueue stop and
  start
- [High] drm/sched: deadlock on pause_lock and work_tdr in
  drm_sched_fini()
- [Medium] drm/sched: lockdep inversion acquiring pause_lock in
  drm_sched_wqueue_start()
- [Low] drm/sched: missing kernel-doc entry for pause_lock in
  drm_gpu_scheduler
--

commit a76a12f06c945a6e5b2e2b77f19934547861ccb1
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/sched: Sanitise wqueue_start/wqueue_stop/is_stopped interleavings

This commit serializes GPU scheduler workqueue start and stop operations wi=
th
a mutex, switches from cancel_work_sync() to disable_work_sync() /
enable_work(), and orders pause_submit accesses with release/acquire barrie=
rs.

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 99252674e2668..4662f024ad885 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
[ ... ]
> @@ -1190,6 +1189,20 @@ static void drm_sched_cancel_remaining_jobs(struct=
 drm_gpu_scheduler *sched)
>  	}
>  }
> =20
> +static void drm_sched_wqueue_stop_locked(struct drm_gpu_scheduler *sched)
> +{
> +	lockdep_assert_held(&sched->pause_lock);
> +
> +	disable_work_sync(&sched->work_run_job);
> +	disable_work_sync(&sched->work_free_job);
> +
> +	/*
> +	 * Anything that observes pause_submit will also want to see the effects
> +	 * of any of the previous memory operations.
> +	 */
> +	smp_store_release(&sched->pause_submit, true);
> +}

[Severity: High]
Can unbalanced drm_sched_wqueue_stop() and drm_sched_wqueue_start() calls l=
eave
work_run_job and work_free_job permanently disabled or underflow their disa=
ble
count?

Previously, drm_sched_wqueue_stop() and drm_sched_wqueue_start() were
idempotent, whereas disable_work_sync() and enable_work() increment and
decrement a reference-counted disable depth on each work item. Neither
drm_sched_wqueue_stop_locked() nor drm_sched_wqueue_start() checks
sched->pause_submit before changing the disable depth.

Several drivers do not pair stop and start 1:1. For example,
amdgpu_job_timedout() calls drm_sched_wqueue_stop(&ring->sched) before
attempting a per-ring reset; if amdgpu_ring_reset() fails and falls through=
 to
amdgpu_device_gpu_recover() -> amdgpu_device_halt_activities(),
drm_sched_wqueue_stop(&ring->sched) is called a second time while
amdgpu_device_sched_resume() only calls drm_sched_wqueue_start(&ring->sched)
once. That leaves the work disable depth at 1 while pause_submit is set back
to false, wedging the scheduler ring. Conversely, if amdgpu_ring_reset()
succeeds via amdgpu_sdma_reset_engine(), the helper already restarts
ring->sched before amdgpu_job_timedout() calls drm_sched_wqueue_start() a
second time, triggering the disable count underflow warning in
work_offqd_enable().

Guarding disable_work_sync() and enable_work() on sched->pause_submit under
sched->pause_lock would keep stop and start idempotent.

>  /**
>   * drm_sched_fini - Destroy a gpu scheduler
>   *
> @@ -1212,13 +1225,15 @@ void drm_sched_fini(struct drm_gpu_scheduler *sch=
ed)
>  {
>  	int i;
> =20
> -	drm_sched_wqueue_stop(sched);
> +	/* Guarantee queue is paused for the entirety of the teardown */
> +	guard(mutex)(&sched->pause_lock);
> +	drm_sched_wqueue_stop_locked(sched);
> =20
>  	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
>  	wake_up_all(&sched->job_scheduled);
> =20
>  	/* Confirm no work left behind accessing device structures */
> -	cancel_delayed_work_sync(&sched->work_tdr);
> +	disable_delayed_work_sync(&sched->work_tdr);

[Severity: High]
Does holding sched->pause_lock across disable_delayed_work_sync(&sched->wor=
k_tdr)
cause an ABBA deadlock when a timeout work item is running?

drm_sched_job_timedout() runs on sched->work_tdr and invokes
sched->ops->timedout_job(), where drivers call drm_sched_stop() /
drm_sched_wqueue_stop() and drm_sched_start() / drm_sched_wqueue_start(). B=
oth
now take sched->pause_lock:

CPU0                              CPU1 (work_tdr)
----                              ---------------
drm_sched_fini()                  drm_sched_job_timedout()
  mutex_lock(&sched->pause_lock)    ops->timedout_job()
  ...                                 drm_sched_stop()
  disable_delayed_work_sync(            drm_sched_wqueue_stop()
    &sched->work_tdr)                     mutex_lock(&sched->pause_lock)

 *** DEADLOCK ***

[ ... ]
> @@ -1320,9 +1335,19 @@ EXPORT_SYMBOL(drm_sched_wqueue_stop);
>   */
>  void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched)
>  {
> -	WRITE_ONCE(sched->pause_submit, false);
> +	guard(mutex)(&sched->pause_lock);
> +
> +	enable_work(&sched->work_run_job);
> +	enable_work(&sched->work_free_job);
> +
>  	queue_work(sched->submit_wq, &sched->work_run_job);
>  	queue_work(sched->submit_wq, &sched->work_free_job);
> +
> +	/*
> +	 * Anything that observes pause_submit will also want to see the effects
> +	 * of any of the previous memory operations.
> +	 */
> +	smp_store_release(&sched->pause_submit, false);
>  }

[Severity: Medium]
Does taking sched->pause_lock in drm_sched_wqueue_start() introduce lockdep
inversions with dma_fence signalling and with work items running on
sched->submit_wq?

In drm_sched_wqueue_stop_locked() and drm_sched_fini(), sched->pause_lock is
held across disable_work_sync(&sched->work_run_job),
disable_work_sync(&sched->work_free_job), drm_sched_cancel_remaining_jobs(),
and destroy_workqueue(sched->submit_wq), chaining sched->pause_lock above t=
he
submit_wq lockdep map and the free_job() / fs_reclaim paths.

In panfrost_reset(), drm_sched_start() -> drm_sched_wqueue_start() is called
inside a dma_fence_begin_signalling() critical section, which chains
dma_fence_signalling -> sched->pause_lock -> work_free_job / fs_reclaim. In
xe's disable_scheduling_deregister(), xe_sched_submission_start() ->
drm_sched_wqueue_start() runs from xe_sched_process_msg_work() on
sched->submit_wq, inverting the sched->pause_lock -> submit_wq order and
risking deadlock if a concurrent drm_sched_wqueue_stop() holds
sched->pause_lock while waiting for work queued behind work_process_msg on =
the
same ordered submit_wq.

> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 3b0978fa8cf08..259960fd584ae 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -627,6 +627,7 @@ struct drm_gpu_scheduler {
>  	bool				free_guilty;
>  	bool				pause_submit;
>  	bool				own_submit_wq;
> +	struct mutex			pause_lock;
>  	struct device			*dev;
>  };

[Severity: Low]
struct drm_gpu_scheduler has a kernel-doc comment block describing all of i=
ts
members, so adding pause_lock without a matching @pause_lock entry will
trigger a kernel-doc warning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128-drm-sched-=
fini-race-v1-1-9803ee8aa8b4@collabora.com?part=3D1
