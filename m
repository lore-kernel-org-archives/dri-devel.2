Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D79C88E53
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 01:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B467910E052;
	Sun, 13 Sep 2026 01:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VCZ/t+qE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC66E10E052
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 01:48:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51174401D1;
 Sun, 13 Sep 2026 01:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FCE1F000FF;
 Sun, 13 Sep 2026 01:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789264088;
 bh=aRvu9R1O6f0kJ90RegKucN4z5UybCwC6VzV4IS15pgU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VCZ/t+qEpvJznbVZO4RuwVcDjspGo8rDhk8OZpDUlocT1Cx+tHO7qTrbCzQymRGLf
 SkzLbkY0UVL7Q94dzHAcbE7+eFL86Y+UsZWmc5bWudW9Ai5V1U2EoTNxaCGaMGnrA0
 XEQdVzYr32dZdWiLm1fR4PddUIlzysqh1YjqgnXgkPaquTDmE7+AHszYOH2ajy5GZW
 R3zvtCVk3WbrrBZKNExq+B2Vewtk67xpDNqBboKJ/tQiuhdwEwttd9EVGt7twihO8o
 EogxWDbev1oUkEk6W7gpM2d+69MGPxwGXCh7Q6Tk7xpu2jKT5qQWNC3CCSGpbBhTUJ
 6vICF4ULQn5GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exynos: fimc: disable LCLK during cleanup
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913013450.20786-1-mhun512@gmail.com>
References: <20260913013450.20786-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 01:48:07 +0000
Message-Id: <20260913014808.00FCE1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally disabling LCLK in fimc_remove and the probe error =
path races with devm_request_irq cleanup, allowing the IRQ handler to execu=
te while clocks are disabled.

Pre-existing issues:
- [High] The IRQ handler is registered before clocks are set up and the con=
text spinlock is initialized, risking a bus hang and spinlock BUG.
- [High] Concurrent execution of fimc_irq_handler and fimc_abort causes a d=
ata race on ctx->task, leading to workqueue corruption.
- [High] Active tasks are not cancelled and pending async cleanup works are=
 not flushed during module unbind in fimc_remove(), leading to memory leaks=
 and Use-After-Free.
--

commit 71fc119244ac2354764b21e9e75759a36ca6bc94
Author: Myeonghun Pak <mhun512@gmail.com>
Subject: drm/exynos: fimc: disable LCLK during cleanup

The commit disables LCLK at the cleanup sites that are reached only after
fimc_setup_clocks() succeeds, because the later failure path and normal
remove path only put the clock references.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/e=
xynos/exynos_drm_fimc.c
> index 09e33a26caaff..58214abb5a8e6 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
[ ... ]
> @@ -1362,6 +1362,7 @@ static int fimc_probe(struct platform_device *pdev)
>  err_pm_dis:
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
> +	clk_disable_unprepare(ctx->clocks[FIMC_CLK_LCLK]);

[Severity: High]
Does disabling the clock here race with the devm-managed IRQ handler?

Because the IRQ handler is managed by devm_request_irq(), it remains
registered and unmasked at the GIC until devres cleans it up after
fimc_probe() returns.

If a spurious interrupt occurs during this window, fimc_irq_handler()
could fire and access unclocked registers, which causes an external abort.

>  	fimc_put_clocks(ctx);
> =20
>  	return ret;
> @@ -1376,6 +1377,7 @@ static void fimc_remove(struct platform_device *pde=
v)
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but could removing the component
here without stopping hardware or flushing background tasks lead to a
use-after-free?

Active tasks are not cancelled and pending async cleanup works are not
flushed during module unbind in fimc_remove().

If the driver is unbound while an async task is running, devres frees the
fimc_context (ctx). The hardware completing the task triggers the IRQ, or
the pending work executes, both of which dereference the freed ctx.

> +	clk_disable_unprepare(ctx->clocks[FIMC_CLK_LCLK]);

[Severity: High]
Can manually disabling the clock here also race with devm_request_irq()
cleanup?

Similar to the probe error path, devm_request_irq() won't free the IRQ
until after fimc_remove() returns.

If the hardware is still active, or an interrupt occurs during this
window, fimc_irq_handler() would execute while clocks are disabled,
crashing the kernel.

>  	fimc_put_clocks(ctx);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but could the IRQ registration
order in fimc_probe() cause a bus hang or spinlock BUG?

The IRQ is requested and unmasked before hardware is clocked and the
spinlock is initialized:

	ret =3D devm_request_irq(dev, ret, fimc_irq_handler,
			       0, dev_name(dev), ctx);
	if (ret < 0) {
		dev_err(dev, "failed to request irq.\n");
		return ret;
	}

	ret =3D fimc_setup_clocks(ctx);
	if (ret < 0)
		return ret;

	spin_lock_init(&ctx->lock);

If the bootloader leaves the FIMC hardware active with a pending interrupt,
calling devm_request_irq() unmasks the interrupt immediately.

The handler fimc_irq_handler() will execute, which calls fimc_clear_irq()
to access unclocked registers and attempts to acquire ctx->lock before it
is initialized.

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of locking
when accessing ctx->task cause a data race between fimc_irq_handler() and
fimc_abort()?

fimc_abort() executes in process context and accesses ctx->task without
disabling interrupts:

	if (ctx->task) {
		struct exynos_drm_ipp_task *task =3D ctx->task;
		ctx->task =3D NULL;

Meanwhile, fimc_irq_handler() does the same:

	if (ctx->task) {
		struct exynos_drm_ipp_task *task =3D ctx->task;
		ctx->task =3D NULL;

If fimc_abort() runs concurrently with fimc_irq_handler() (e.g. userspace
aborts the task just as hardware completes it), both paths could see a
valid task pointer, set it to NULL, and call exynos_drm_ipp_task_done().

This leads to double scheduling of task->cleanup_work on the same
work_struct, corrupting the workqueue linked lists.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913013450.2078=
6-1-mhun512@gmail.com?part=3D1
