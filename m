Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E92606A332
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hgd/CrR8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABC910EEBF;
	Tue, 10 Nov 2026 09:14:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B34610EEBF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:13:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4B9641216;
 Tue, 10 Nov 2026 09:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC0C1F0089F;
 Tue, 10 Nov 2026 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794302036;
 bh=crECGi/YhzWv6bwiZEVmYDsXFsEb0l+kTm2Hxb3SBlQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Hgd/CrR8gGkzp12/mYMtmS63Kb9Cqxt2ljO/GyH7pvryanzXzxMtca70cMOYo67VB
 VQ91k4konJ5qHZe+/Cb97+X3lsEfaYHFIG+u+/vVVTDkwv5HGSUoLbqir3JUxIUQak
 tY8qkfVRsqVqqwFgMD/BGVRgYvg5VIdgXEslL71bHkM7gYWo7kwRn/2JKtUYtP+ebt
 t+fD8E4+jGRVpGVBNHrx4vC6ibBKiUK0Aq9fenx5J06h77ziZzMpo2FIrw22JwBccX
 QX6c4vgxhUMPQqgGnCANtg+eNprSndDED7khJSU7zIS3KWcALvh+xfTJldGxkl2h4b
 qEw4nxx7IeTuA==
Message-ID: <sashiko-outbox-206716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/ivpu: Defer recovery until probe completes
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
References: <20261107174215.15818-1-swizzguy76@gmail.com>
 <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:13:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] accel/ivpu: race in ivpu_pm_enable() queues recovery_work
  twice
--

commit 53feec71cd6cb0035da92ea965a242f974fa21d7
Author: Karol Wachowski <karol.wachowski@linux.intel.com>

accel/ivpu: Defer recovery until probe completes

This commit disables recovery_work in ivpu_pm_init() and re-enables and
flushes it in ivpu_pm_enable() to prevent recovery from running during
probe before device initialization finishes.

> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index aa813262253e4..7aee728b19ef1 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
>  	atomic_set(&pm->engine_reset_counter, 0);
> =20
>  	INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
> +	disable_work(&pm->recovery_work);
>  	INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
> =20
>  	if (ivpu_disable_recovery)
> @@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>  {
>  	struct device *dev =3D vdev->drm.dev;
> =20
> +	enable_work(&vdev->pm->recovery_work);
> +	if (atomic_read(&vdev->pm->reset_pending)) {
> +		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
> +		flush_work(&vdev->pm->recovery_work);
> +	}

[Severity: Medium]
Can ivpu_pm_enable() race with ivpu_pm_trigger_recovery() and queue
recovery_work twice for a single fault?

In ivpu_pm_trigger_recovery(), reset_pending is set to 1 before
ivpu_hw_diagnose_failure(), ivpu_hw_irq_disable(), and queue_work():

drivers/accel/ivpu/ivpu_pm.c:ivpu_pm_trigger_recovery() {
	...
	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) =3D=3D 0) {
		ivpu_hw_diagnose_failure(vdev);
		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm=
 */
		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
	}
}

And reset_pending stays 1 until ivpu_pm_reset_complete() finishes, while
the workqueue clears WORK_STRUCT_PENDING_BIT as soon as a worker dequeues
recovery_work:

CPU0                              CPU1                        kworker
ivpu_pm_trigger_recovery()
  atomic_cmpxchg(reset_pending, 0, 1)
  ivpu_hw_diagnose_failure()
                                  ivpu_pm_enable()
                                    enable_work(&recovery_work)
                                    if (atomic_read(reset_pending))
                                      queue_work(&recovery_work)
                                      flush_work(&recovery_work)
                                                              ivpu_pm_recov=
ery_work()
  ivpu_hw_irq_disable()
  queue_work(&recovery_work)  <-- queued a second time

The same double queueing happens if ivpu_pm_trigger_recovery() runs right
after enable_work() and a worker starts ivpu_pm_recovery_work() before
ivpu_pm_enable() checks reset_pending.

In the first interleaving, ivpu_pm_recovery_work() runs concurrently with
ivpu_hw_diagnose_failure() and ivpu_hw_irq_disable(), and flush_work()
only waits for the first execution.  The second queued recovery_work then
runs after flush_work() returns, performing a second full NPU reset
concurrently with pm_runtime_allow() and pm_runtime_put_autosuspend() and
reintroducing the race where recovery disables runtime PM during the
initial autosuspend request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110085003.3527=
014-1-karol.wachowski@linux.intel.com?part=3D1
