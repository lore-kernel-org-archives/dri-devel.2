Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7647BC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8D410E3D1;
	Sat,  8 Aug 2026 13:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bgrej4TY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD2810E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:17:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 892A04049B;
 Sat,  8 Aug 2026 13:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1DC1F000E9;
 Sat,  8 Aug 2026 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786195051;
 bh=iOuKWaZLJ9J+sQlmyDIvtZew1ZwKzj2+5o+yTXAIs8I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bgrej4TYkrdcLbB85ypePZeMaR8BK1cksdt/wES99z4nulEF78Nj4Ptu/yiEBiSq+
 TUK6nCy+dQ7bgMFdogfGOoPC4K+7gxZOjUwS5EoUUc2dfOpSUCa1YvWYpCUfhHsEjP
 y5N96gkJG1864tZwGvVI43YX1TyXoPwJKb4gM9UQpiBc34PAjkaJgWfcPnmnJIYwus
 UGcEYQh9fTUgaKylwkg8pvyy4boIzMeZS1aaUKJ9zrvKPRmFOnv8SMq1k2Rg/QAKQV
 M7UvoTwUECmzxEIeZBmtNWXvZQe0iq/TCaiXXXBMrYtNzwMSkLlhgIcBUibhvzPXtn
 mY1rcBoMOpR4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/lima: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808125953.2842241-1-lgs201920130244@gmail.com>
References: <20260808125953.2842241-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:17:30 +0000
Message-Id: <20260808131731.4C1DC1F000E9@smtp.kernel.org>
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
- [High] Calling `pm_runtime_dont_use_autosuspend()` before `pm_runtime_dis=
able()` forces a synchronous runtime suspend, causing a fatal bus fault whe=
n teardown code accesses hardware registers with clocks disabled, and leads=
 to double-disable warnings.

Pre-existing issues:
- [High] Interrupt handlers read MMIO registers directly without verifying =
that the device is actively powered on.
- [High] Missing `synchronize_irq()` in the runtime suspend callback for a =
driver using shared IRQs.
--

--- Patch [1]: [PATCH] drm/lima: fix autosuspend cleanup during teardown ---
commit 4763e4050f129243cd08b2beca088f25dfc1da22
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/lima: fix autosuspend cleanup during teardown

lima_pdev_probe() calls pm_runtime_use_autosuspend(), but its failure
path does not call the matching pm_runtime_dont_use_autosuspend()
before disabling runtime PM. The remove path has the same issue.

> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_=
drv.c
> index 9a0eb1092ad3d..9bd44c191e6c3 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
[ ... ]
> @@ -434,6 +434,7 @@ static int lima_pdev_probe(struct platform_device *pd=
ev)
>  	return 0;
> =20
>  err_out3:
> +	pm_runtime_dont_use_autosuspend(ldev->dev);
>  	pm_runtime_disable(ldev->dev);

[Severity: High]
Does calling pm_runtime_dont_use_autosuspend() before pm_runtime_disable()
force a synchronous runtime suspend here?

Because lima_device lacks a runtime_idle callback, the idle check from
dropping the usage count falls through to rpm_suspend(), which executes
lima_device_suspend() and disables device clocks.=20

When the teardown path proceeds to lima_device_fini() -> lima_pmu_hw_fini(),
it attempts to read LIMA_PMU_STATUS, which will cause a fatal bus fault
because the device clocks are already off. It also leads to double-disabling
the clocks.

Had pm_runtime_disable() been called first, its disable_depth increment
would have safely prevented rpm_idle() from suspending the device.

>  	lima_devfreq_fini(ldev);
>  err_out2:
[ ... ]
> @@ -456,6 +457,7 @@ static void lima_pdev_remove(struct platform_device *=
pdev)
> =20
>  	/* stop autosuspend to make sure device is in active state */
>  	pm_runtime_set_autosuspend_delay(ldev->dev, -1);
> +	pm_runtime_dont_use_autosuspend(ldev->dev);
>  	pm_runtime_disable(ldev->dev);

[Severity: High]
Does this have the same issue as the probe error path?

Calling pm_runtime_dont_use_autosuspend() before pm_runtime_disable()
triggers rpm_idle() and suspends the device before lima_devfreq_fini() and
lima_device_fini() execute, potentially causing a crash when they access
powered down hardware.

> =20
>  	lima_devfreq_fini(ldev);

As an additional observation, there are some pre-existing issues in the
driver:

[Severity: High]
This isn't a bug introduced by this patch, but do the interrupt handlers
read MMIO registers directly without verifying that the device is actively
powered on?

drivers/gpu/drm/lima/lima_mmu.c:lima_mmu_irq_handler() {
	u32 status =3D mmu_read(LIMA_MMU_INT_STATUS);

	/* for shared irq case */
	if (!status)
		return IRQ_NONE;
...
}

Similar patterns exist in lima_gp_irq_handler() and lima_pp_irq_handler().

Since the driver uses the IRQF_SHARED flag and supports runtime PM, if
another device on the same IRQ line triggers an interrupt while the lima
device is runtime suspended, these handlers will execute and unconditionally
read from powered-down hardware registers. This can cause an external abort
and crash the system. Should these handlers use pm_runtime_get_if_active()
before accessing hardware?

[Severity: High]
This is a pre-existing issue, but does the runtime suspend callback disable
clocks without waiting for in-flight interrupt handlers to finish?

drivers/gpu/drm/lima/lima_device.c:lima_device_suspend() {
...
	lima_regulator_disable(ldev);

	lima_clk_disable(ldev);

	return 0;
}

Because IRQF_SHARED is used, an interrupt handler could be actively
executing on another CPU when the suspend callback runs. Pulling the power
and clocks mid-execution causes the handler's MMIO accesses to fault. Does
this need a synchronize_irq() call before powering down the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808125953.2842=
241-1-lgs201920130244@gmail.com?part=3D1
