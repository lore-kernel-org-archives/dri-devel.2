Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EB0CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694FF10F166;
	Mon,  8 Jun 2026 10:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a3EzHmT4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5DB10F166
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 878D5601D8;
 Mon,  8 Jun 2026 10:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4AB1F00893;
 Mon,  8 Jun 2026 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780915126;
 bh=r3/iWdtbvbBIutTIkSne9G/Zn1tof9frAseGAwAEJpo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a3EzHmT4OzLy2C9BEO5TYA8GGhxAj01S/IpOSOpgEHUzkTPo6h6oN8/B6faM3T7XX
 MI0OakS0PrN/xC5JBnV0YWzXMZbRq9OBK9kuGqah19buzFP49MQ+HNtJTgmdBP8VwF
 FJCGkBlkAjVTxYsdqeXB2geeQljmV4U3Uh+QK181SuDwdNpoc45WifQg5ieL+kGHay
 5KB8oDIABNRDBujhQw8M7WBQMxj7qGqlg1EBt5PVx5DFBIH2bxrrVze8/TD6mRGRer
 7XMzFVYwsLK7HWWUGNV8UNDwkgPgnNwmTd7xYs91jJeFQ/1GnmWbE0WnSwEBoyqOay
 YTkuvjMW38ADw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/rocket: Fix fence leak, runtime PM leak and
 WARN in rocket_job_run() error paths
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260608100040.985526-1-zhaojinming@uniontech.com>
References: <20260608100040.985526-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 10:38:45 +0000
Message-Id: <20260608103845.6F4AB1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] IOMMU group reference leak in rocket_job_handle_irq()
- [High] Unsafe hardware register access in shared IRQ handler while runtim=
e suspended
--

commit fca53bbe333680ce9d4e0368b39e684506994081
Author: ZhaoJinming <zhaojinming@uniontech.com>
Subject: accel/rocket: Fix fence leak, runtime PM leak and WARN in rocket_j=
ob_run() error paths

This commit fixes multiple resource leaks in the error paths of rocket_job_=
run().
It replaces pm_runtime_get_sync() with pm_runtime_resume_and_get() to handle
the usage counter, correctly releases dma_fence references on failure, and
adds pm_runtime_put() during IOMMU attachment failures.

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
> +	if (ret < 0) {
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}
> =20
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
> =20
>  	scoped_guard(mutex, &core->job_lock) {
>  		core->in_flight_job =3D job;

[ ... ]

>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
>  	pm_runtime_mark_last_busy(core->dev);
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>  	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =20
>  	scoped_guard(mutex, &core->job_lock)
>  		if (core->in_flight_job) {
>  			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
>  				rocket_job_hw_submit(core, core->in_flight_job);
>  				return;
>  			}
> =20
>  			iommu_detach_group(NULL, iommu_group_get(core->dev));

[Severity: High]
This isn't a bug introduced by this patch, but does this leak an IOMMU
group reference?

It looks like iommu_group_get() increments the kobject reference count for =
the
group. However, iommu_detach_group() doesn't consume this reference, and th=
ere
is no subsequent iommu_group_put() call.

Since this runs on every completed job, could this eventually overflow the
reference counter and prevent the group from being freed?

[ ... ]

>  static irqreturn_t rocket_job_irq_handler(int irq, void *data)
>  {
>  	struct rocket_core *core =3D data;
>  	u32 raw_status =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);

[Severity: High]
This is a pre-existing issue, but is it safe to access hardware registers
here without first checking if the device is active?

Since the driver registers this as a shared interrupt handler, it could be
invoked if another device on the same IRQ line triggers an interrupt while =
the
NPU device is runtime suspended.

Reading from a powered-down device typically returns 0xffffffff, which would
spuriously trigger the WARN_ON macros below and falsely return=20
IRQ_WAKE_THREAD.

Should this use pm_runtime_get_if_active() to verify the device is powered
before reading INTERRUPT_RAW_STATUS?

> =20
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608100040.9855=
26-1-zhaojinming@uniontech.com?part=3D1
