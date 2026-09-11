Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DCCC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD39610E370;
	Fri, 11 Sep 2026 23:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h5XsCNwm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1944D10E370
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:49:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73B44601EF;
 Fri, 11 Sep 2026 23:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E8B1F000FF;
 Fri, 11 Sep 2026 23:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789170559;
 bh=ro4TEVg/sLPb2tE41Sx3tEaznHf2G5YAsQbACluQaOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h5XsCNwmaVAPcktuC+E8E+ApXgeCraeHUXj1Pf70lHBeg8KEK6edohN0NsOT6MUgk
 T30LGeSW3haBHYemjjU39NOMV95GAOJRKVQqSQ8Vt2WK5CCPRj51qmqvnlnRvJ+kas
 iKdh6YEVuSi8Jui3oy0Wi1RIkAzC/utVcjLkEWuDi7Bq9hguGPwQ8EbsrbQb3kaY2F
 q9F1I+4Uvo7nWfTiJnEEi8MbQNAxe5OGmg5daRVbrcZJlxiYRwnV8l1fwTYmsjwugF
 bx47epG02B57M6YqOfcANmGTIvQGXBAsNq7oah1fjn2tHk6mFux4+klzDVmO7E/40K
 7Thr8uO2MEE3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/16] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-6-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-6-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:49:18 +0000
Message-Id: <20260911234918.F1E8B1F000FF@smtp.kernel.org>
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
- [High] Setting PM state to suspended before hardware teardown completes c=
auses bus errors.

Pre-existing issues:
- [High] Failure of pm_runtime_get_sync() is ignored in panfrost_remove(), =
which can lead to fatal MMIO accesses.
- [High] Concurrent IOCTLs during device removal can cause Use-After-Free o=
r hardware faults.
- [High] Interrupt handlers are not synchronized before hardware clocks are=
 disabled and scheduler structures are destroyed.
--

commit fc7ca29ac5bbdcbf8ed388bccbba4ac531c7ed14
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove
   =20
This patch fixes PM refcnt and autosuspend issues during device probe
and removal in the panfrost driver. It ensures the PM usage count is proper=
ly
managed so the device does not remain powered on forever or increase its
refcnt monotonically.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c

[ ... ]

> @@ -866,13 +867,16 @@ static int panfrost_probe(struct platform_device *p=
dev)
>  	if (err < 0)
>  		goto err_out1;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
>  	return 0;
> =20
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	panfrost_device_fini(pfdev);

[Severity: High]
Does moving pm_runtime_set_suspended() before panfrost_device_fini() cause =
bus
errors? pm_runtime_set_suspended() internally drops the PM runtime active
reference on the PM domains via rpm_put_suppliers(). Because the PM domains=
 may
power off asynchronously or synchronously when their usage count drops, the=
y can
be disabled while panfrost_device_fini() is still executing.

Subsequently, functions like panfrost_jm_fini() and panfrost_mmu_fini() per=
form
direct MMIO accesses on unclocked or powered-down hardware, which causes a
synchronous external abort and a kernel panic. Note that this bug is not fi=
xed
in the subsequent patches of the series (e.g. Patch 8 just moves the buggy
sequence into panfrost_device_fini).

>  err_out0:
>  	return err;
>  }
> @@ -884,9 +888,11 @@ static void panfrost_remove(struct platform_device *=
pdev)
>  	drm_dev_unregister(&pfdev->base);

[Severity: High]
This isn't a bug introduced by this patch, but does drm_dev_unregister()
prevent concurrent IOCTLs from open file descriptors? drm_dev_unregister()
removes the sysfs node but already-open file descriptors can still execute
IOCTLs (e.g. panfrost_ioctl_submit).

Because Panfrost does not use drm_dev_unplug() and drm_dev_enter()/exit() in
its IOCTL paths, a concurrent IOCTL can proceed, access the DRM scheduler, =
or
write to MMIO while panfrost_device_fini() destroys the schedulers and disa=
bles
clocks, causing a Use-After-Free or a kernel panic. Note that this missing
synchronization remains unfixed at the end of the patch series.

> =20
>  	pm_runtime_get_sync(pfdev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but does ignoring the return val=
ue
of pm_runtime_get_sync() lead to fatal MMIO accesses? If resuming fails, the
device remains unclocked. Execution proceeds unconditionally into
panfrost_device_fini(), which performs MMIO writes to the hardware. Writing=
 to
MMIO registers when the device is powered off causes a bus fault / SError,
resulting in a kernel panic.

Although remove() cannot return an error, the code must check the return va=
lue
and skip hardware accesses if resuming failed. Note that a follow-up patch
(Patch 9) wraps this call in a drm_WARN_ON, but it still does not handle the
error gracefully by aborting the hardware teardown steps, so the crash still
occurs.

> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	panfrost_device_fini(pfdev);

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown sequence
properly synchronize interrupts? panfrost_device_fini() calls
panfrost_mmu_fini() and panfrost_jm_fini(), which mask interrupts via MMIO
writes (e.g. mmu_write(pfdev, MMU_INT_MASK, 0)), but they do not call
synchronize_irq().

If the IRQ handler thread is running concurrently on another CPU, it will
continue executing and attempt to read MMIO registers with clocks disabled =
or
access destroyed scheduler queues, leading to a UAF or kernel panic. This
teardown synchronization issue remains unfixed at the end of the patch seri=
es.

Also, as noted in the panfrost_probe() error path, moving
pm_runtime_set_suspended() before panfrost_device_fini() risks disabling PM
domains while teardown is still ongoing, leading to bus errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D6
