Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1E0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3248310E4DD;
	Mon,  7 Sep 2026 20:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FDAQI6IV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4E110E4DD
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:29:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 478CF43A3F;
 Mon,  7 Sep 2026 20:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F251B1F00A3A;
 Mon,  7 Sep 2026 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788812999;
 bh=MMZDzvbCOwTIE4toXMW3VohpEGUINs6n0rmoUc1Trnw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FDAQI6IVbQ43ps9HsVV93z1l9Hu/eTkS8K4czARRwK0woPCFzUoseIWmWeqHdLCTh
 uuTfdRLyBESUGTkgnfOz5d/efvzD8Fmefpd13q/ks4thAKz6hd7z5TxG0ijefUk0J3
 7v1dcAWcyjYPT9qfdECgq74k+8TgITi2Eg+BeksKWADujagfja2JiNv0S9qxNr/DgX
 3Dqf+jOt+UAxFuBNrEEtGzYYOV4I3y0T6pnoyGBxOFQkKkvcwWSHZLwkrhtc0sQNgQ
 hO3jCkoepu4qrsplrJ2OKyl/WuaaWkNbCzXMeIBOc8LzE0MkfjDo0p/kyG1nNJSne1
 ZGRjJsuSVTEHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/16] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-claude-fixes-v8-6-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
 <20260907-claude-fixes-v8-6-c2bcb5e82184@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:29:58 +0000
Message-Id: <20260907202958.F251B1F00A3A@smtp.kernel.org>
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
- [High] Ignoring the return value of pm_runtime_get_sync() can lead to unc=
locked register accesses and system crashes.
- [High] Driver teardown races with in-flight GPU jobs, leading to unhandle=
d hardware faults.
--

commit 75e6d8fc2d8a39088a19c0381af15b43a9a4c041
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

During device probe(), failure to do a PM get() will leave the usage_count
set to 0, which is the value assigned at device creation time. That means
when the autosuspend delay expires, runtime suspend callback won't be
invoked, so the device will remain powered on forever.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 55fc22e8d4d4e..a3eff77add557 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c

[ ... ]

> @@ -884,9 +888,11 @@ static void panfrost_remove(struct platform_device *=
pdev)
>  	drm_dev_unregister(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> -	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	panfrost_device_fini(pfdev);

[Severity: High]
This is a pre-existing issue, but does panfrost_device_fini() ignore the
return value of pm_runtime_get_sync() and risk system crashes?

Looking at panfrost_device.c:panfrost_device_fini(), it issues a warning but
unconditionally proceeds with hardware teardown:

	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
	...
	panfrost_jm_fini(pfdev);
	panfrost_mmu_fini(pfdev);
	panfrost_gpu_fini(pfdev);

If pm_runtime_get_sync() fails (e.g., due to regulator or clock failure),
the device remains physically suspended with clocks disabled.

Can unconditionally writing to MMIO registers in panfrost_jm_fini(),
panfrost_mmu_fini(), and panfrost_gpu_fini() with clocks off cause a bus
fault or kernel panic?

[Severity: High]
This is a pre-existing issue, but does panfrost_device_fini() tear down
hardware while GPU jobs might still be executing?

During device unbind, the driver does not appear to wait for actively
executing jobs on the physical GPU hardware to complete or abort. It procee=
ds
to unmap pagetables and power off the GPU:

	panfrost_jm_fini(pfdev);
	panfrost_mmu_fini(pfdev);
	panfrost_gpu_fini(pfdev);

Can pulling the memory and clocks out from under a running GPU job during a
hot-unplug or unbind cause catastrophic hardware faults or kernel panics?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-claude-fix=
es-v8-0-c2bcb5e82184@collabora.com?part=3D6
