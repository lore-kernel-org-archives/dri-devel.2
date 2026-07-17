Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160AAC4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1526310E404;
	Fri, 17 Jul 2026 06:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FhEwV69N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3B010E404
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:22:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 666EA41269;
 Fri, 17 Jul 2026 06:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B071F000E9;
 Fri, 17 Jul 2026 06:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784269338;
 bh=oMVno41LvXRD5++P549nOqCWyNKr94cNQeOAmwz6QKs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FhEwV69NcHLOyURvYlN3OgnP91xVnnQs4pagc0+1kR/VZxBllCHo+Yy0kmXdqEgwT
 LWge1tbtLqMJLcwqt4T49s8Mi26IOB6d7XvqgT9qbRSER3dtDNnWoIJyTk5RfoehxG
 gfMt9F5mdRGEttM5dZadxWmhrnuB5rYu9bcs12LKQy4P7sd2nsu5fUKncJPsMdfxfR
 Heyqs8dYLuM7YTpbmeOosLu/dBPC2+vJpt/8RMQHXtcN5xewr3+RSIN1T5DMjwc2wB
 ySLVZA9vln/K/Z+CBNJ6Rb1VYfdUbFD2iSjbSA1/gEalBOosbUsjeCuakHdI6ilXpu
 w79+Z/TNtumxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] accel/ethosu: fix job completion fence cleanup
To: "GuoHan Zhao" <zhaoguohan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717061145.1478139-6-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-6-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 06:22:17 +0000
Message-Id: <20260717062218.29B071F000E9@smtp.kernel.org>
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
- [High] Calling drm_sched_job_cleanup() on an uninitialized struct drm_sch=
ed_job causes a NULL pointer dereference in the ethosu_ioctl_submit_job() e=
rror path.
- [High] The shared IRQ handler accesses hardware registers without ensurin=
g the device is active via Runtime PM, and the suspend callback fails to sy=
nchronize IRQs, risking fatal bus faults.
--

--- Patch [5]: [PATCH v2 5/5] accel/ethosu: fix job completion fence cleanu=
p ---
commit b390c1806154d7460d3ff212d56c250283785f11
Author: GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: accel/ethosu: fix job completion fence cleanup

This commit addresses memory leaks and refcount underflows in the Ethos-U N=
PU
driver's job cleanup path. It ensures that the done_fence is properly relea=
sed
during error cleanup and uses dma_fence_was_initialized() to handle raw
allocations gracefully.

Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kyl=
inos.cn?part=3D1

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index 5847433e87e7e..b68a905d22f83 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -152,6 +152,13 @@ static void ethosu_job_err_cleanup(struct ethosu_job=
 *job)
> =20
>  	drm_gem_object_put(job->cmd_bo);
> =20
> +	if (job->done_fence) {
> +		if (dma_fence_was_initialized(job->done_fence))
> +			dma_fence_put(job->done_fence);
> +		else
> +			dma_fence_free(job->done_fence);
> +	}
> +
>  	kfree(job);
>  }
> =20

[Severity: High]
This is a pre-existing issue, but was not introduced by this patch.

When the done_fence allocation fails in ethosu_ioctl_submit_job(), it jumps
to out_cleanup_job:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
	if (!ejob->done_fence) {
		ret =3D -ENOMEM;
		goto out_cleanup_job;
	}
    ...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&ejob->base);
}

Because drm_sched_job_init() was not called yet, ejob->base is completely
zero-initialized, meaning ejob->base.s_fence is NULL.

When drm_sched_job_cleanup() attempts to read the refcount:

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_job_cleanup() {
    ...
	if (kref_read(&job->s_fence->finished.refcount)) {
    ...
}

Will this result in a NULL pointer dereference because the function assumes
job->s_fence is a valid pointer?


[Severity: High]
This isn't a bug introduced by this patch, but there appears to be an issue
with how shared interrupts interact with runtime PM.

The NPU interrupt is registered with the IRQF_SHARED flag:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_init() {
    ...
	ret =3D devm_request_threaded_irq(dev, edev->irq,
				ethosu_job_irq_handler,
				ethosu_job_irq_handler_thread,
				IRQF_SHARED, KBUILD_MODNAME,
				edev);
    ...
}

If another device sharing the IRQ line triggers an interrupt while the NPU =
is
runtime-suspended, the handler executes and reads MMIO registers:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
    ...
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);

	if (!(status & STATUS_IRQ_RAISED))
		return IRQ_NONE;
    ...
}

Could this unconditionally read registers without verifying the device's PM
state via pm_runtime_get_if_active()?

Furthermore, the runtime suspend callback disables clocks:

drivers/accel/ethosu/ethosu_drv.c:ethosu_device_suspend() {
    ...
	clk_bulk_disable_unprepare(ethosudev->num_clks, ethosudev->clks);
	return 0;
}

Since this doesn't call synchronize_irq() to wait for executing handlers,
could concurrent IRQ execution cause invalid hardware writes or a bus fault
when accessing powered-off MMIO registers?

> @@ -162,7 +169,6 @@ static void ethosu_job_cleanup(struct kref *ref)
> =20
>  	pm_runtime_put_autosuspend(job->dev->base.dev);
> =20
> -	dma_fence_put(job->done_fence);
>  	dma_fence_put(job->inference_done_fence);
> =20
>  	ethosu_job_err_cleanup(job);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717061145.1478=
139-1-zhaoguohan@kylinos.cn?part=3D5
