Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA1CC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF3110E9C1;
	Tue,  4 Aug 2026 10:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nZhaj9uJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D55D710E154
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:35:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 75DE140516;
 Tue,  4 Aug 2026 10:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CD51F000E9;
 Tue,  4 Aug 2026 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785839735;
 bh=Oq5ZTEgXWSkJOMPU020uUPy8PiBLdDjGKP1GZGGEIxs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nZhaj9uJGK6lhjrgg+hxriTtjfWOYrbqlnlWLTMTTSAD8Jbg2INDZ9Y97ONS1Wbcm
 WAjCthaXJAc9QModF2M03Mp5KR7IKNeb53pFTkB6q7/7YP/YC4fpfaWXKorKQ8lpVF
 MdqpfptPSYQdgD+DMh5yoPxDU7X3mi3qDxxCeCAHx2y1SXkzsgz5ECDdLsYcGcJqZJ
 3lxXxroJn5Ey9vR5w7IstqGZBOrUwbvFfhkTQAT1pSIprteOxlngetsOT9C4L9A7To
 X4bfus1a5cuyVds3A+KT3StVBhFEuJZAKMoFsGz8+OyWMBrqicmeKAnm36CVx+nTNn
 5wrs8MSPUazGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] drm/panthor: Further delay reset work enablement
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-2-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-2-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:35:34 +0000
Message-Id: <20260804103535.38CD51F000E9@smtp.kernel.org>
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
- [High] Calling disable_work_sync() on a work item from within the work it=
em itself causes a deadlock.

Pre-existing issues:
- [High] A race condition during device resume can cause a hardware fault t=
o be permanently ignored, leaving the reset.pending flag stuck at 1 and blo=
cking all future resets.
- [High] A race condition at the end of the reset work can cause a new hard=
ware fault to be lost because `reset.pending` is cleared after interrupts a=
re re-enabled.
--

--- Patch [2]: [PATCH 02/12] drm/panthor: Further delay reset work enableme=
nt ---
commit 08177a6c8d92319bf18b6e18c4bb7d3f3023ca20
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Further delay reset work enablement

There's no point re-enabling the reset work before the DRM device
registration succeeds, so move the enable_work() after the point where
nothing can fail anymore, and in the unlikely event where a reset was
pending, reschedule it.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c

[ ... ]

> @@ -300,6 +297,14 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	if (ret)
>  		goto err_disable_autosuspend;
> =20
> +	/* Now that everything is initialized, we can enable the reset work.
> +	 * If there was a reset pending, clear and reschedule, otherwise the
> +	 * reset.pending bit is stuck.
> +	 */
> +	enable_work(&ptdev->reset.work);
> +	if (atomic_cmpxchg(&ptdev->reset.pending, 1, 0))
> +		panthor_device_schedule_reset(ptdev);

[Severity: High]
Can this lead to a deadlock if the firmware boot fails?

If panthor_fw_post_reset() fails during panthor_device_reset_work() in
drivers/gpu/drm/panthor/panthor_device.c, it directly calls
panthor_device_unplug().

panthor_device_unplug() then unconditionally calls:
disable_work_sync(&ptdev->reset.work);

Since disable_work_sync() synchronously waits for the currently executing
work item to complete, would this deadlock on itself if called from within
the reset work?

[Severity: High]
This is a pre-existing issue, but is the same fix needed in
panthor_device_resume()?

In panthor_device_resume(), pm.state is set to ACTIVE without checking if a
fault occurred. When resuming, pm.state starts as RESUMING and interrupts
are re-enabled by panthor_device_resume_hw_components().

If a fault fires before pm.state becomes ACTIVE, the interrupt handler calls
panthor_device_schedule_reset(), which sets reset.pending to 1 but skips
queuing the work because pm.state is not ACTIVE.

When panthor_device_resume() later sets pm.state to ACTIVE without checking
if pending became 1 (unlike the fix applied here in panthor_device_init),
does this leave reset.pending stuck at 1 and block all future resets?

[Severity: High]
This is a pre-existing issue, but can a hardware fault be lost due to a race
condition at the end of the reset work?

In panthor_device_reset_work(), panthor_mmu_post_reset() and
panthor_fw_post_reset() are called, which re-enable hardware interrupts.

If a fault occurs immediately after, the interrupt handler calls
panthor_device_schedule_reset(). Since reset.pending is still 1,
the atomic_cmpxchg fails and no work is queued.

Then, panthor_device_reset_work() executes:
atomic_set(&ptdev->reset.pending, 0);

Are faults occurring in this window silently ignored?

> +
>  	pm_runtime_put_autosuspend(ptdev->base.dev);
>  	return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D2
