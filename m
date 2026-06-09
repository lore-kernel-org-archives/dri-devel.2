Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E30CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534BD10E218;
	Tue,  9 Jun 2026 09:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eMDP47nQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E8610E231
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:50:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8BE44323E;
 Tue,  9 Jun 2026 09:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A21F00893;
 Tue,  9 Jun 2026 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780998657;
 bh=p9o4R+yel4scS8WsFEdUg7JJ6HoUuVj0hc3cvM/kLyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eMDP47nQX9C5weBSYOugPoy+86Z6mWqWVZeLC1gM4+F7H+FK8QGV83k6xc5xs2xit
 sKKz8cPxqrESut2tsBx9hYCGhdYRLmOBloY73PY0zZQSmsNP3GHX7TA4ca4nRtPrVX
 38XXXnoHOVQQgo1Tsdgn2n0oWrQ4S/PwnU3GEeO3ZbyyXwEg1ToZ0xDMgDIBgnanAV
 4mPJaSmRg3xLIPUyBVlJOLPo603ZVxYqEtFjeaFzyVqLsks5VCupqaKgAw0HJS/v0D
 Mwe7QreEiIBh94Xqdz5DTFMHMBItyYCyAonC74UYo1BqfwymZOrZ1xH4hrGSLvoYDP
 27KK+UsrT2xtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609093346.380396-1-zhaojinming@uniontech.com>
References: <20260609093346.380396-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 09:50:57 +0000
Message-Id: <20260609095057.877A21F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Calling `drm_sched_job_cleanup()` after `drm_sched_job_arm()` viol=
ates the DRM scheduler API contract.
- [High] The runtime suspend callback fails to synchronize the shared IRQ b=
efore powering down.
- [High] Potential NULL pointer dereference in `iommu_attach_group()` if th=
e device lacks an IOMMU group.
--

commit a91812825621124e6ae3a091adc6205cbeefed80
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix error path handling in rocket_job_run()

This commit fixes multiple issues in the error paths of rocket_job_run(). It
resolves a dma_fence reference leak, correctly balances the runtime PM
usage counter on failure by switching to pm_runtime_resume_and_get(), and
returns ERR_PTR(ret) instead of an unsignaled fence to avoid DRM scheduler
warnings.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f960ccb..cf9f61682dd8b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -310,13 +310,22 @@ static struct dma_fence *rocket_job_run(struct drm_=
sched_job *sched_job)

[ ... ]

>  	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> -	if (ret < 0)
> -		return fence;
> +	if (ret < 0) {
> +		pm_runtime_put(core->dev);
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}

[Severity: High]
This is a pre-existing issue, but can core->iommu_group be NULL here?

If the device does not have an IOMMU group (e.g., IOMMU is disabled or not
present in the device tree), iommu_group_get() returns NULL. Calling
iommu_attach_group() unconditionally with a NULL group parameter will cause=
 a
kernel crash when it attempts to dereference the pointer.

Should there be a check for a valid iommu_group before attaching?

[ ... ]

I also noticed a couple of pre-existing issues in this driver:

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
drm_sched_job_cleanup() after drm_sched_job_arm() has already been called?

In drivers/accel/rocket/rocket_job.c:rocket_job_push(), if
rocket_acquire_object_fences() fails:

	drm_sched_job_arm(&job->base);
	...
	ret =3D rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
					   &job->base, false);
	if (ret)
		goto err_unlock;

The error path returns to rocket_ioctl_submit_job(), which then calls:

out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&rjob->base);

The DRM scheduler API contract states that drm_sched_job_arm() is a point of
no return that initializes fences and sequence numbers. Calling
drm_sched_job_cleanup() after this breaks the dma_fence sequence numbers,
potentially causing any context waiting on the aborted sequence number to h=
ang
indefinitely.

[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback need to
synchronize the shared IRQ before powering down?

In drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend():

	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
				   rdev->cores[core].clks);

The Rocket driver registers its IRQ handler with IRQF_SHARED. According to
the power management subsystem rules, drivers using shared IRQs must call
synchronize_irq() in their runtime suspend callback before disabling clocks.

Without this, could the hardware be powered off while the IRQ handler is
mid-flight and reading registers, potentially leading to system hangs or
spurious wakeups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609093346.3803=
96-1-zhaojinming@uniontech.com?part=3D1
