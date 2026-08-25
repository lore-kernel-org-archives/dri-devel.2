Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98B2C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAE310E96C;
	Tue, 25 Aug 2026 08:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k92ujTdN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F1D10E96C
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:21:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39B916013A;
 Tue, 25 Aug 2026 08:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FA81F00A3E;
 Tue, 25 Aug 2026 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787646096;
 bh=BNHw+5jwz2rNT6cywbebA2gfNgKNfatqaeMTjKIZuGw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k92ujTdNSZELJVp4vwSfRtq4F8LM428HtiATe68ARSysnVvQYlF550m8x8/BKHi15
 FgCFVVb9RD/ls9xsg0ueHtylyUw6cMr1xhFvPoGmdodY5tXRlO4xkiwc/THlrIOEG/
 AWNkzE2eUayISyoTTpHFHq2Hjynw7qrtEwBFlyWLBfqKk/P2nF640sflPv3WM9T8hw
 y1RYVhozB2/CcQMUPpXjlZpiP26EG3Qhs6n9dxSw2zG74TE0ru9M/Rrf04dEpBV49/
 Vms1HcLbyj+jWQS8DAXY3BITy4VoHK97p+W4mt0Eb1PnL3Z/sgfUyuNab2oqnb5CiF
 Ox2WWzIiJtxPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] drm/panthor: Don't defer FW event processing
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825-panthor-signal-from-irq-v7-8-ebb5b4c891a4@collabora.com>
References: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
 <20260825-panthor-signal-from-irq-v7-8-ebb5b4c891a4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:21:36 +0000
Message-Id: <20260825082136.B9FA81F00A3E@smtp.kernel.org>
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
- [High] Possible Use-After-Free of firmware structures when group_process_=
tiler_oom() runs concurrently with or after panthor_fw_unplug(). This probl=
em wasn't introduced by this patch, but remains unresolved as replacing fw_=
events_work with direct threaded IRQ processing still leaves tiler_oom_work=
 queued to an unflushed workqueue.
--

--- Patch [8]: [PATCH v7 8/9] drm/panthor: Don't defer FW event processing =
---
commit 99ae40464e2d4753b77cca3059716afd0d1bd396
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Don't defer FW event processing

This commit avoids a workqueue roundtrip by processing firmware events
immediately from panthor_sched_report_fw_events() rather than deferring
them to the fw_events_work workqueue.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 64b5fc1a0984f..7f99745ff4041 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -4083,7 +4055,6 @@ void panthor_sched_unplug(struct panthor_device *pt=
dev)
>  	struct panthor_scheduler *sched =3D ptdev->scheduler;
> =20
>  	disable_delayed_work_sync(&sched->tick_work);
> -	disable_work_sync(&sched->fw_events_work);

[Severity: High]
This is a pre-existing issue, but since we are modifying the workqueue tear=
down
here in panthor_sched_unplug(), is it possible for a tiler_oom_work to exec=
ute
after panthor_fw_unplug() has already run?

In panthor_device_unplug(), the sequence calls panthor_sched_unplug() which
stops the scheduler tick and disables some works, but it doesn't appear to
flush sched->heap_alloc_wq where tiler_oom_work is queued.

If panthor_fw_unplug() subsequently destroys the firmware mappings, and a
pending tiler_oom_work executes group_process_tiler_oom():

drivers/gpu/drm/panthor/panthor_sched.c:group_process_tiler_oom()
    cs_iface =3D panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
    heaps =3D panthor_vm_get_heap_pool(group->vm, false);
    heap_address =3D cs_iface->output->heap_address;

Could this dereference the unmapped cs_iface->output memory and cause a
use-after-free, since the async worker doesn't seem to check drm_dev_enter(=
)?

>  	disable_work_sync(&sched->sync_upd_work);
> =20
>  	mutex_lock(&sched->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-panthor-si=
gnal-from-irq-v7-0-ebb5b4c891a4@collabora.com?part=3D8
