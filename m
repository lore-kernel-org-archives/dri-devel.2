Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126E5CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569C510E6CE;
	Wed, 10 Jun 2026 03:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WgdEdrrX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997EF10E6CE
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 03:19:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1A966024D;
 Wed, 10 Jun 2026 03:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619931F00893;
 Wed, 10 Jun 2026 03:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781061585;
 bh=Ls+D304rGGxKi7/sZbrdMPI6bXOw5Ykj3BzOOLKMbPI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WgdEdrrXsGhxfa9s/mVRudt+QLuMDqCOd5hTFccDTG1FPA6CGKBSYeYTB78eNaZMu
 kPnKbYyAdvJ3Z9ArqrXCC5vu/h1C97itof7lMxLrfh+CBVu7R7Z2V9IVjl2DghJlCW
 tNQ3fkRu9xNrn12nAm5C2Kr/cbb41C1THqQUip3sKsaDTWzxKYG84gubN8hcyH7dOk
 YyE0Kwun6kWA8lHFRKRLXZgsU6RwGoJ787FhBPUwH+3lb2Mcm5BwIi+5GN1447WHju
 Fz4Z18tB2EqII0F3puvoDGOu0Xjq3XGjMRnWyU5m/YbZOxVZ7tN5iK6G3Fp89ehSJF
 dMAwrHh79H6Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610030322.2802744-1-zhaojinming@uniontech.com>
References: <20260610030322.2802744-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 03:19:45 +0000
Message-Id: <20260610031945.619931F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `synchronize_irq()` in the runtime suspend callback for a =
device using shared IRQs.
--

commit badac0ffd08d84278aad7a9068c91e38322fa44f
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix error path handling in rocket_job_run()

This commit fixes bugs in the error paths of rocket_job_run() by replacing
pm_runtime_get_sync() with pm_runtime_resume_and_get() to prevent leaking
the runtime PM reference. It also properly releases fence references on
error and returns ERR_PTR instead of an unsignaled fence.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f960ccb..cf9f61682dd8b 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -310,13 +310,22 @@ static struct dma_fence *rocket_job_run(struct drm_=
sched_job *sched_job)
>  		dma_fence_put(job->done_fence);
>  	job->done_fence =3D dma_fence_get(fence);
> =20
> -	ret =3D pm_runtime_get_sync(core->dev);
> -	if (ret < 0)
> -		return fence;
> +	ret =3D pm_runtime_resume_and_get(core->dev);

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
runtime PM handling here, I noticed a regression in the runtime suspend pat=
h:

drivers/accel/rocket/rocket_drv.c:rocket_device_runtime_suspend() {
    ...
	if (!rocket_job_is_idle(&rdev->cores[core]))
		return -EBUSY;

	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks),
				   rdev->cores[core].clks);

	return 0;
}

Since the device's IRQ is registered with the IRQF_SHARED flag, should
synchronize_irq() be called before gating the device clocks?

Without synchronization, could a concurrently running IRQ handler on another
CPU be halfway through executing when the clocks are abruptly disabled,
potentially causing an external abort when the handler attempts its next
MMIO access?

I saw that the IRQ handler was updated in a later commit ("accel/rocket: Fix
iommu_group leak and unsafe IRQ register access") to use
pm_runtime_get_if_active(), but doesn't the PM subsystem still mandate this
synchronization pattern for all drivers using IRQF_SHARED to guarantee no
handler is executing mid-flight during power down?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610030322.2802=
744-1-zhaojinming@uniontech.com?part=3D1
