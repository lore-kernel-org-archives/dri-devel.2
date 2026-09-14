Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B487C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBF210E12E;
	Mon, 14 Sep 2026 08:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMzY98q1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8B310E12E
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:41:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81BAB60142;
 Mon, 14 Sep 2026 08:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B1E1F000FF;
 Mon, 14 Sep 2026 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789375313;
 bh=X5iQRodKCV989/8d7ukhSzApSSn6lNVGBFHIAhXRAsw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZMzY98q1uJmv1TsouG1Q/G+BUfrEpV09JhV0E34vnA8KBni3s3oQywtsFhtBUNWVR
 9fQUa7T1H3bjITYamCdi5lXnrNoz0IIwmiPfXcPOzrIGHwgnPA+2xm9XsL+G0cW6Ll
 JQaMPdmcJgZoBOsJ8Mu2snlFZBQRlR5WO947SwMa/uJwpxyaic/7WjeETACbGzMk7P
 7P/ePCjiOrev3YjmImaI5E3S+2KTyuH7+CwEjIBV3u7lOmioOcUz3Sj8EWAwm2YHs2
 xBlGWYYxX6QWgkeVoH5Rv5ml4wYPU0E+0JqipngtqqDbeiU+ur4teE+sFe8vHtO+uT
 QdWtunkckmsow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Use separate flag for job timeout
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914082800.892044-1-karol.wachowski@linux.intel.com>
References: <20260914082800.892044-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:41:52 +0000
Message-Id: <20260914084153.13B1E1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Premature clearing of `job_timeout_detected` flag before flushing =
`context_abort_work` silently drops the ban on the guilty context during a =
job timeout (TDR).

Pre-existing issues:
- [High] Lockless `xa_load` of `file_priv` in the MMU event queue IRQ handl=
er leads to a Use-After-Free.
--

commit b8245a180aec634640c11be76ef2b20b2a900039
Author: Jakub Pawlak <jakub.pawlak@intel.com>

accel/ivpu: Use separate flag for job timeout

This patch introduces a separate flag, job_timeout_detected, to distinguish
engine resets caused by job timeouts from other reasons. The flag is
cleared in ivpu_prepare_for_reset() to ensure a clean state after recovery.

> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 0f215392d42de..647684219e9d3 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -528,6 +528,7 @@ void ivpu_prepare_for_reset(struct ivpu_device *vdev)
>  {
>  	ivpu_hw_irq_disable(vdev);
>  	disable_irq(vdev->irq);
> +	atomic_set(&vdev->job_timeout_detected, 0);
>  	flush_work(&vdev->irq_dct_work);
>  	flush_work(&vdev->context_abort_work);

[Severity: High]
Is it safe to clear the job_timeout_detected flag before flushing
context_abort_work?

If a concurrent recovery calls ivpu_prepare_for_reset() and sets the flag
to 0, and context_abort_work runs simultaneously, could it reach the
atomic_cmpxchg() in reset_engine_and_mark_faulty_contexts(), see a 0, and
silently skip banning the guilty context?=20

Should this flag be cleared after flushing the work queues instead?

[ ... ]

> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index b3de5dd29d1e8..084d825f744dd 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
[ ... ]
> @@ -1260,10 +1259,10 @@ static int reset_engine_and_mark_faulty_contexts(=
struct ivpu_device *vdev)
>  		return ret;
> =20
>  	/*
> -	 * If faults are detected, ignore guilty contexts from engine reset as =
NPU may not be stuck
> -	 * and could return currently running good context and faulty contexts =
are already marked
> +	 * If job timeout is detected, read guilty context from engine reset, f=
or other reasons
> +	 * faulty context is already known
>  	 */
> -	if (atomic_cmpxchg(&vdev->faults_detected, 1, 0) =3D=3D 1)
> +	if (atomic_cmpxchg(&vdev->job_timeout_detected, 1, 0) =3D=3D 0)
>  		return 0;
> =20
>  	num_impacted_contexts =3D resp.payload.engine_reset_done.num_impacted_c=
ontexts;

[ ... ]

> diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
> index 41efd8985fa67..b2025274f91de 100644
> --- a/drivers/accel/ivpu/ivpu_mmu.c
> +++ b/drivers/accel/ivpu/ivpu_mmu.c
> @@ -964,7 +964,6 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vd=
ev)
>  		file_priv =3D xa_load(&vdev->context_xa, ssid);
>  		if (file_priv) {
>  			if (!READ_ONCE(file_priv->has_mmu_faults)) {
> -				atomic_set(&vdev->faults_detected, 1);
>  				ivpu_mmu_dump_event(vdev, event);
>  				WRITE_ONCE(file_priv->has_mmu_faults, true);
>  			}

[Severity: High]
This is a pre-existing issue, but does the lockless xa_load() here risk a
use-after-free?

Looking at file_priv_release() in drivers/accel/ivpu/ivpu_drv.c, file_priv
is freed immediately via kfree() without waiting for an RCU grace period
after being removed from the xarray:

drivers/accel/ivpu/ivpu_drv.c:file_priv_release() {
    ...
    ivpu_user_limits_put(vdev, file_priv->user_limits);
    mutex_destroy(&file_priv->ms_lock);
    mutex_destroy(&file_priv->lock);
    kfree(file_priv);
}

If a user closes the file descriptor concurrently with this IRQ handler,
could file_priv be freed while we are still accessing
file_priv->has_mmu_faults via READ_ONCE() or WRITE_ONCE()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914082800.8920=
44-1-karol.wachowski@linux.intel.com?part=3D1
