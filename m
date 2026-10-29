Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1E606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxWCw2k6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C5C112350;
	Thu, 29 Oct 2026 14:29:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2420511235F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:29:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E347C41B4B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D71F01825;
 Thu, 29 Oct 2026 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793284158;
 bh=B+ItxzyzcIhV1ISu+JHSDX0OiZQp7YxA1i2Lvp3D9a4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gxWCw2k6JOC5NaEUjbWh7AZ8EEJotLY/a91oS7clpVav2Srjx9h2lhtlLUY8s6JHk
 uYAuA5iMue/GXIisaOwoaj7g0GoLBE5fnY3hg9IWUz8EUR3g9EAPJb75oxmXy33WtL
 uY3rzjPdXoBjy+udWh69KENgx7nj7Lv/UD53bAvLh0LE2C/ZQ4W2LJuNXOeSfRVkKR
 d65PdeiXqI/XObbBx5ki2q2JJwdiFH7+68Kh2uG3VwZeeAMJXGj/pz4cl515SnJE3Q
 FbdYVuQOhv+w4E93gzLx/lzdW1S1JEze/bwp7Z6W3qo/6UYGXspT+Hhit7UyvM/DyT
 AgDnQTDLUlfsQ==
Message-ID: <sashiko-outbox-189517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/31] accel: ethosu: Keep scheduler after unplug
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-10-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-10-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:29:18 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] accel: ethosu: race with work_tdr and pending_list leak in ethosu_=
job_stop()
- [High] accel: ethosu: double clock disable and RPM imbalance in ethosu_re=
move()
- [Medium] accel: ethosu: premature entity kill on file close in ethosu_job=
_close()
--

commit b4de18ee902b7d8141192389e4617bb0996bcadc
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Keep scheduler after unplug

This commit defers scheduler teardown until the final DRM device reference =
is
released and tracks open scheduling entities so device removal can stop each
entity and cancel the in-flight job while leaving the scheduler alive for
postclose handling.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 91b2c2ab0a03e..ee50e7db36ad1 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
[ ... ]
> @@ -389,20 +389,18 @@ static int ethosu_probe(struct platform_device *pde=
v)
[ ... ]
>  static void ethosu_remove(struct platform_device *pdev)
>  {
>  	struct ethosu_device *ethosudev =3D dev_get_drvdata(&pdev->dev);
> +	bool clocks_disabled;
> =20
>  	drm_dev_unplug(&ethosudev->base);
> -	ethosu_job_fini(ethosudev);
> -
>  	pm_runtime_barrier(&pdev->dev);
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> +	clocks_disabled =3D ethosu_job_stop(ethosudev);
> +	if (!clocks_disabled && !pm_runtime_status_suspended(&pdev->dev))
>  		ethosu_device_suspend(&pdev->dev);

[Severity: High]
Can calling ethosu_device_suspend() directly here (or inside ethosu_job_sto=
p()
when ethosu_device_reset() fails) cause clk_bulk_disable_unprepare() to run=
 a
second time during devres teardown?

In ethosu_init(), the driver enables autosuspend and registers runtime PM
cleanup via devm_pm_runtime_set_active_enabled().

In ethosu_remove(), pm_runtime_barrier() is called before ethosu_job_stop().
Inside ethosu_job_stop(), ethosu_perfmon_stop_locked() calls pm_runtime_put=
(),
and flushing work_free_job runs ethosu_job_cleanup() ->
pm_runtime_put_autosuspend(), which drops usage_count and arms the autosusp=
end
timer while runtime_status remains RPM_ACTIVE.

When ethosu_device_suspend() is then called directly, it disables and
unprepares the clocks without updating runtime_status to RPM_SUSPENDED or
disabling runtime PM. When ethosu_remove() returns and devres_release_all()
runs pm_runtime_disable_action() -> pm_runtime_dont_use_autosuspend() ->
rpm_idle() -> rpm_suspend() (or if the autosuspend timer fires first),
runtime PM invokes ethosu_device_suspend() again on already-disabled clocks.

In addition, for queued entity jobs killed via drm_sched_entity_kill() in
ethosu_job_stop(), cleanup runs asynchronously via
drm_sched_entity_kill_jobs_work(). Because ethosu_job_stop() does not wait =
for
those killed jobs (such as jobs waiting on external dependencies kept alive=
 via
keep_device), won't they retain their pm_runtime_resume_and_get() usage_cou=
nt
references across ethosu_remove() and later call pm_runtime_put_autosuspend=
()
in ethosu_job_cleanup() after the device has been unbound?

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index 8ffdc83d06f98..ef95a8abd61e2 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
[ ... ]
> @@ -388,45 +421,76 @@ int ethosu_job_init(struct ethosu_device *edev)
[ ... ]
> -void ethosu_job_fini(struct ethosu_device *dev)
> +bool ethosu_job_stop(struct ethosu_device *dev)
>  {
> +	struct ethosu_file_priv *priv;
> +	struct ethosu_job *job;
> +	bool clocks_disabled =3D false;
> +
> +	guard(mutex)(&dev->sched_lock);
>  	drm_sched_wqueue_stop(&dev->sched);
> +	disable_irq(dev->irq);
>  	cancel_delayed_work_sync(&dev->sched.work_tdr);
> =20
> -	if (READ_ONCE(dev->in_flight_job)) {
> -		WRITE_ONCE(dev->in_flight_job, NULL);
> -		ethosu_device_reset(dev);
> +	scoped_guard(mutex, &dev->perfmon_state.lock)
> +		ethosu_perfmon_stop_locked(dev, dev->perfmon_state.active, false);
> +
> +	list_for_each_entry(priv, &dev->sched_entities, sched_entity_list)
> +		drm_sched_entity_kill(&priv->sched_entity);
> +
> +	job =3D ethosu_job_clear_in_flight(dev);
> +	if (job && ethosu_device_reset(dev)) {
> +		ethosu_device_suspend(dev->base.dev);
> +		clocks_disabled =3D true;
>  	}
> =20
> -	synchronize_irq(dev->irq);
> -	drm_sched_fini(&dev->sched);
> +	if (job)
> +		ethosu_job_cancel(&job->base);
> +
> +	/* Let drm-sched release the cancelled in-flight job. */
> +	drm_sched_wqueue_start(&dev->sched);
> +	flush_work(&dev->sched.work_free_job);
> +	drm_sched_wqueue_stop(&dev->sched);
> +
> +	return clocks_disabled;
>  }

[Severity: High]
What happens in ethosu_job_stop() if work_tdr (drm_sched_job_timedout() ->
ethosu_job_timedout()) is already running or has previously failed recovery?

First, drm_sched_wqueue_stop() and disable_irq() are called before
cancel_delayed_work_sync(&dev->sched.work_tdr) and before killing entities =
with
drm_sched_entity_kill(). Since ethosu_job_timedout() does not take
dev->sched_lock:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
	...
	drm_sched_stop(&dev->sched, bad);

	ethosu_job_clear_in_flight(dev);

	/* Proceed with reset now. */
	ret =3D pm_runtime_force_suspend(dev->base.dev);
	if (!ret)
		ret =3D pm_runtime_force_resume(dev->base.dev);
	if (ret) {
		dev_err(dev->base.dev, "Failed to recover NPU: %d\n", ret);
		return DRM_GPU_SCHED_STAT_ENODEV;
	}

	/* Drain a pending completion IRQ before a replacement job can run. */
	synchronize_irq(dev->irq);

	/* Restart the scheduler */
	drm_sched_start(&dev->sched, 0);
	...
}

an in-progress ethosu_job_timedout() can finish recovery while
ethosu_job_stop() is waiting in cancel_delayed_work_sync(&dev->sched.work_t=
dr)
and call drm_sched_start() -> drm_sched_wqueue_start() (as well as
drm_sched_start_timeout_unlocked() in drm_sched_job_timedout()). When
cancel_delayed_work_sync() returns, sched->pause_submit is false and
work_run_job is queued while dev->sched_entities are not yet killed. Can
drm_sched_run_job_work() then pop a job from an entity before
drm_sched_entity_kill() reaches it, submit it to hardware via ethosu_job_ru=
n()
with IRQs already disabled, and re-arm work_tdr after
cancel_delayed_work_sync() has completed?

Second, if a prior timeout recovery in ethosu_job_timedout() failed at
pm_runtime_force_suspend() or pm_runtime_force_resume() and returned
DRM_GPU_SCHED_STAT_ENODEV, drm_sched_stop() has already placed the timed-out
job back onto dev->sched.pending_list and detached its parent fence callbac=
k,
while ethosu_job_clear_in_flight() cleared dev->in_flight_job to NULL.

Because ethosu_job_push() now takes a drm_dev_get() and try_module_get()
reference on every pushed job until ethosu_job_cleanup(), and drm_sched_fin=
i()
(which calls drm_sched_cancel_remaining_jobs()) is deferred to the drmm act=
ion
ethosu_job_fini(), ethosu_job_stop() sees ethosu_job_clear_in_flight(dev) =
=3D=3D
NULL and never cancels the job left on dev->sched.pending_list. Doesn't this
create a reference cycle where the unsignaled job on pending_list (and any
entity jobs chained to entity->last_scheduled in drm_sched_entity_kill()) is
never freed, leaking the drm_device, THIS_MODULE, GEM objects, and runtime =
PM
references?

> =20
>  int ethosu_job_open(struct ethosu_file_priv *ethosu_priv)
>  {
>  	struct ethosu_device *dev =3D ethosu_priv->edev;
>  	struct drm_gpu_scheduler *sched =3D &dev->sched;
> +	int ret;
> =20
> -	return drm_sched_entity_init(&ethosu_priv->sched_entity,
> -				     DRM_SCHED_PRIORITY_NORMAL,
> -				     &sched, 1, NULL);
> +	guard(mutex)(&dev->sched_lock);
> +	ret =3D drm_sched_entity_init(&ethosu_priv->sched_entity,
> +				    DRM_SCHED_PRIORITY_NORMAL,
> +				    &sched, 1, NULL);
> +	if (!ret)
> +		list_add(&ethosu_priv->sched_entity_list, &dev->sched_entities);
> +
> +	return ret;
>  }
> =20
>  void ethosu_job_close(struct ethosu_file_priv *ethosu_priv)
>  {
> +	struct ethosu_device *dev =3D ethosu_priv->edev;
>  	struct drm_sched_entity *entity =3D &ethosu_priv->sched_entity;
> =20
> +	scoped_guard(mutex, &dev->sched_lock) {
> +		drm_sched_entity_kill(entity);
> +		list_del(&ethosu_priv->sched_entity_list);
> +	}
>  	drm_sched_entity_destroy(entity);
>  }

[Severity: Medium]
Should ethosu_job_close() call drm_sched_entity_kill() unconditionally befo=
re
drm_sched_entity_destroy()?

During normal operation when the device has not been unplugged,
drm_sched_entity_destroy() calls drm_sched_entity_flush() to allow queued j=
obs
in entity->job_queue to be scheduled before drm_sched_entity_fini() kills t=
he
entity.

Because the scheduler has credit_limit =3D 1, if userspace submits multiple=
 jobs
or a job waiting on dependencies and then closes the DRM file descriptor,
calling drm_sched_entity_kill() first immediately sets entity->stopped =3D =
true
and aborts all unscheduled jobs in entity->job_queue with -ESRCH instead of
flushing them in drm_sched_entity_destroy().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D10
