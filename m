Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C392FC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FB610E4CE;
	Mon, 24 Aug 2026 14:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzvrgePD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4AB10E0C0;
 Mon, 24 Aug 2026 14:19:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DDD7140E11;
 Mon, 24 Aug 2026 14:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958861F000E9;
 Mon, 24 Aug 2026 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787581189;
 bh=osf90roqkwdlA4d0364B9VX/c5X2XCLSvuGD0BgOU1o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TzvrgePDKZZWQIu4dE2k0U8ToJCZ/XTQJLEsky3bQLFDPsDiKpxyYkneCdc/D0mhI
 8AM9wFOoJpRyjos/KbScGvmBVhEjv/A5xeWpz5uxheFM9KoSASEfgh6f9s5rJZb3lX
 X2U49VGXoQPUcHx7jxaaWOhZAbHu/scymQnztPirb87K/wsP6/19QzGdwy+RUDV4Mq
 vq6wyGHzcXzH+GAXvoMnlU/cInJQZ7exsUqnEi2swP3fCJJIKyKWBc5jk4wXALglLs
 YdmA5m6TNDO8xpoVd2EdMQeQbPGLeGOnG3vAsFuZBLpJtRrtUoQ7eC4IQwDqbafi4r
 7ObP7JlxL6CJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260824140748.54974-2-talesam@gmail.com>
References: <20260824140748.54974-1-talesam@gmail.com>
 <20260824140748.54974-2-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:19:49 +0000
Message-Id: <20260824141949.958861F000E9@smtp.kernel.org>
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
- [High] Uncancelled deferred devcoredump work on the global workqueue lead=
s to UAF if the driver is unbound/unloaded before the work executes.
--

--- Patch [1]: [PATCH v3 1/3] drm/xe: Capture devcoredump on TLB invalidati=
on timeout ---
commit e17a9749756454a4d7c32af8d34a73ac7b919a3e
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe: Capture devcoredump on TLB invalidation timeout

This commit adds xe_devcoredump_gt() to capture GuC log and CT state
for hangs that are not tied to an exec queue or job. It also hooks
this mechanism up to the TLB invalidation timeout path.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
[ ... ]
> @@ -323,40 +318,44 @@ static void devcoredump_snapshot(struct xe_devcored=
ump *coredump,
[ ... ]
> +	if (q) {
> +		ss->ge =3D xe_guc_exec_queue_snapshot_capture(q);
> +		if (job)
> +			ss->job =3D xe_sched_job_snapshot_capture(job);
> +		ss->vm =3D xe_vm_snapshot_capture(q->vm);
> +
> +		xe_engine_snapshot_capture_for_queue(q);
> +	}
> =20
>  	queue_work(system_dfl_wq, &ss->work);

[Severity: High]
This is a pre-existing issue, but does this deferred work item on the global
system_dfl_wq cause a use-after-free if the driver is unbound before it
executes?

During teardown, xe_driver_devcoredump_fini() calls dev_coredump_put(). If
the work hasn't run yet, the coredump device hasn't been registered by the
deferred worker.

Consequently, dev_coredump_put() finds no device, returns silently, and
never invokes xe_devcoredump_free(). The work remains uncanceled on
system_dfl_wq and will eventually execute using a freed xe_device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824140748.5497=
4-1-talesam@gmail.com?part=3D1
