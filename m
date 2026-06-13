Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06E2CD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1747310ECCB;
	Sat, 13 Jun 2026 07:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfGt1ZoN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF41610ECD1
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:12:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61FCC60018;
 Sat, 13 Jun 2026 07:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64E11F000E9;
 Sat, 13 Jun 2026 07:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781334722;
 bh=D8QLZ5/N89EajPkUtrsVvhE6tHx3KQ1d+xbiJ+CAkwo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfGt1ZoNE8bekdSd/t/JkADVSk3Iem+vayTuLUjSIYBWZ11HMx1ogfh0EJg1gRFmM
 P11uk8D0x63mHRHSq1Nt+K3y4vlmz8KLA5KQMBjEXwtkUSQyCtiX9bKpUsxnWBCYKn
 aXESDPTXWqaPuSZQeX1P1Nw5t08UYSvfEPNbMVYg3OWb53wP6k8IlbGFJADQhJe7f8
 HZT4jLDFpzIBMAWdRjFS8vgOXMGM4hMhYPJmw6LbGJevVNXyipRNHHYoXY23oLvBu8
 TQs2A8nGP6CCXBHsIKhYMSHVakRnjX5LzrO+jfKEL0YqbYEUUl2FgFSJlfeh/5yoGl
 N4i7uDKl1zpqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 5/9] accel: rocket: Keep the IOMMU domain
 attached across jobs
To: MidG971 <midgy971@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260613070116.438906-6-midgy971@gmail.com>
References: <20260613070116.438906-6-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:12:01 +0000
Message-Id: <20260613071201.C64E11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] rocket_core_fini() tears down the IOMMU domain without quiescing t=
he hardware, causing IOMMU faults and wedged hardware.

Pre-existing issues:
- [High] Error paths in rocket_job_run() leak the PM runtime usage counter =
and return an unsignaled fence, causing permanent power drain and spurious =
timeouts.
- [High] Job timeout recovery leaves the NPU permanently powered on due to =
pm_runtime_put_noidle().
--

commit 629253998abe2060bd2b43f469323132b5743d36
Author: Midgy BALON <midgy971@gmail.com>
Subject: accel: rocket: Keep the IOMMU domain attached across jobs

This commit attaches the IOMMU domain once per context instead of toggling
it on every job to avoid hardware stall timeouts. The domain is released on
context swap, core reset, or core teardown.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index 779e951596a15..6c128f585cff4 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
[ ... ]
> @@ -112,9 +113,20 @@ void rocket_core_fini(struct rocket_core *core)
>  {
>  	pm_runtime_dont_use_autosuspend(core->dev);
>  	pm_runtime_disable(core->dev);
> +
> +	/*
> +	 * Stop the scheduler before tearing down the IOMMU so an in-flight
> +	 * job can no longer touch the (about to be detached) domain.
> +	 */
> +	rocket_job_fini(core);
> +
> +	if (core->attached_domain) {
> +		iommu_detach_group(NULL, core->iommu_group);

[Severity: High]
Does this detach the IOMMU page tables while the hardware is still active?

Calling drm_sched_fini() inside rocket_job_fini() only stops the software
scheduling thread, but it doesn't wait for the currently executing job on
the hardware to complete or reset the AXI master. Detaching the group while
the NPU is still executing could cause memory translation faults and wedge
the hardware.

Should the hardware be explicitly quiesced, for example by calling
rocket_core_reset(), before the IOMMU is detached here?

> +		rocket_iommu_domain_put(core->attached_domain);
> +		core->attached_domain =3D NULL;
> +	}
>  	iommu_group_put(core->iommu_group);
>  	core->iommu_group =3D NULL;
> -	rocket_job_fini(core);
>  }
> =20
>  void rocket_core_reset(struct rocket_core *core)
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index e25234261536b..368b2ebead1b3 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -314,9 +315,26 @@ static struct dma_fence *rocket_job_run(struct drm_s=
ched_job *sched_job)
>  	if (ret < 0)
>  		return fence;
> =20
> -	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> -	if (ret < 0)
> -		return fence;

[Severity: High]
This isn't a bug introduced by this patch, but does the pm_runtime_get_sync
error path just above this leak the PM runtime usage counter?=20

In rocket_job_run(), the code does:

	ret =3D pm_runtime_get_sync(core->dev);
	if (ret < 0)
		return fence;

If pm_runtime_get_sync() fails, returning without calling
pm_runtime_put_noidle() leaves the counter elevated.

> +	/*
> +	 * Attach the job's IOMMU domain only when it differs from the one
> +	 * already attached. Re-attaching per job toggles the rk_iommu
> +	 * stall/reset handshake on an idle NPU MMU, which is slow and
> +	 * noisy; keep the domain attached across jobs instead.
> +	 */
> +	if (core->attached_domain !=3D job->domain) {
> +		if (core->attached_domain) {
> +			iommu_detach_group(NULL, core->iommu_group);
> +			rocket_iommu_domain_put(core->attached_domain);
> +			core->attached_domain =3D NULL;
> +		}
> +
> +		ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> +		if (ret < 0)
> +			return fence;

[Severity: High]
This is a pre-existing issue, but does this error path leak the PM runtime
reference acquired earlier in this function?=20

Since the in_flight_job isn't set yet when returning the fence here, the
subsequent timeout handler won't clean this up, preventing the device from
ever entering low power states.

> +
> +		kref_get(&job->domain->kref);
> +		core->attached_domain =3D job->domain;
> +	}
> =20
>  	scoped_guard(mutex, &core->job_lock) {
>  		core->in_flight_job =3D job;
[ ... ]
> @@ -376,7 +393,15 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)

[Severity: High]
This isn't a bug introduced by this patch, but does job timeout recovery
leave the NPU permanently powered on?

Earlier in rocket_reset(), the usage counter is decremented:

	scoped_guard(mutex, &core->job_lock) {
		if (core->in_flight_job)
			pm_runtime_put_noidle(core->dev);

		core->in_flight_job =3D NULL;
	}

Because pm_runtime_put_noidle() does not invoke an idle check or queue an
auto-suspend, doesn't the device remain in the RPM_ACTIVE state and stay
physically powered on indefinitely? Should pm_runtime_put_autosuspend() be
used here instead?

>  	 */
>  	rocket_core_reset(core);
> =20
> -	iommu_detach_group(NULL, core->iommu_group);
> +	/*
> +	 * The reset wipes the IOMMU page-table base, so drop the attached
> +	 * domain to force the next job to re-attach and reprogram it.
> +	 */
> +	if (core->attached_domain) {
> +		iommu_detach_group(NULL, core->iommu_group);
> +		rocket_iommu_domain_put(core->attached_domain);
> +		core->attached_domain =3D NULL;
> +	}
> =20
>  	/* NPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&core->reset.pending, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613070116.4389=
06-1-midgy971@gmail.com?part=3D5
