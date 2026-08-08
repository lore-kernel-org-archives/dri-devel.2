Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4D0C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A8210E00B;
	Sat,  8 Aug 2026 12:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzPidFWo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF69010E00B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:29:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A0A2438E6;
 Sat,  8 Aug 2026 12:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2911F000E9;
 Sat,  8 Aug 2026 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786192165;
 bh=D27B7rUwYNKu8BK6bQ+KltFKtgror0TrKJJ6dpnEC8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nzPidFWoy2B7UjlwFTEiOYjzjy1e4J0Tzkpbkr1aW6cbt/4NbrAz7fq3I2lC9lLNB
 PJ3W5sdxgkxbTqjyWyrR//bhVhpOqEcKypYeFgivdpFh6p+SJE9xgb01l9+7m9GknB
 5sHd2P8WagpFBaU5fBhVTHFp0E4y4YSTX9pSrVhPBJFiJWexslZvk4DcA82b9/bVV/
 ZezyxkqE1U4XiAPuXJnu+URpgZKQcJXlxOCtzgONej+8Tof4YqR+bUrexxwtf5DPkr
 30fq2ESuoxmuaUGBtEWAwghV1TayR9gCFhIgg8yknmGxrf38/JdCGUqMiXegbQo6Eg
 Q3HieZJh5SEhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808121434.2815841-1-lgs201920130244@gmail.com>
References: <20260808121434.2815841-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 12:29:24 +0000
Message-Id: <20260808122925.4D2911F000E9@smtp.kernel.org>
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
- [High] Workqueue `gpu->wq` is destroyed before the GPU is quiesced, leadi=
ng to a Use-After-Free/kernel panic if an interrupt fires during unbind.
--

--- Patch [1]: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown =
---
commit 77333bf2f506b75e91ec774e0e32c5f41714ae15
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/etnaviv: fix runtime PM cleanup during teardown

etnaviv_gpu_platform_probe() calls pm_runtime_use_autosuspend() and
enables runtime PM before registering the component. If component_add()
fails, the probe path returns without undoing the autosuspend setting
or disabling runtime PM. The remove path also disables runtime PM
without calling the matching pm_runtime_dont_use_autosuspend().

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 5c23182f4d33a..cf71e43614f84 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c

[ ... ]

> @@ -1992,6 +1994,7 @@ static void etnaviv_gpu_platform_remove(struct plat=
form_device *pdev)
>  	struct etnaviv_gpu *gpu =3D dev_get_drvdata(&pdev->dev);
> =20
>  	component_del(&pdev->dev, &gpu_ops);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> =20
>  	mutex_destroy(&gpu->lock);

[Severity: High]
This is a pre-existing issue, but since this patch fixes teardown paths, can
this component teardown sequence lead to a use-after-free?

Looking at etnaviv_gpu_unbind(), which is called via component_del(), it
destroys the workqueue before stopping the scheduler and quiescing the
hardware:

    destroy_workqueue(gpu->wq);
    etnaviv_sched_fini(gpu);

If an active GPU workload completes precisely in this window, the hardware
raises an interrupt and irq_handler() executes:

    queue_work(gpu->wq, &gpu->sync_point_work);

Does queuing work to a destroyed workqueue cause a kernel panic here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808121434.2815=
841-1-lgs201920130244@gmail.com?part=3D1
