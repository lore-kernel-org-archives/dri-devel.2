Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC59DC5AD5A
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 02:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FB010F194;
	Thu, 13 Aug 2026 02:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jn9SqIox";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE3410F18C;
 Thu, 13 Aug 2026 02:47:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91EC3600AF;
 Thu, 13 Aug 2026 02:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139A71F000E9;
 Thu, 13 Aug 2026 02:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786589261;
 bh=MWIB6F+JrHGiydkPzlvM+CwGCVNa2MqTSbtWoAdQwJ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jn9SqIoxB7nbtcswPVX8w5dd1pzsaVQFyfsx16abC6rKIgdm9ARQQwnB2d7fCWp/H
 ztsCfGKhg8jKETrby3ztnM2N6g/vBpXZcEg/ssIViUPpf1ynbfdEkyM4D/9EmNYVwn
 6V1bAh5OELzoK5x/GzQP5L9pzqu50Ykz0gjzlEuoFBOtLs/y7hYSYrM5+Nl0Xgyv1A
 GoiWhfBU3esy/n1kh2f3Xfl0Bd991SkOsbelWFI61PRn2YKFtsI4I23gKxAv0PDrRp
 yy6aLQVvH5d04xIjwj9xvQW7MDHA6BvtHyQkiB/tMsmJIZsl/2kJitTWSrPS8X8AsA
 /lTq/2QaQSYLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260813023016.805573-2-talesam@gmail.com>
References: <20260813023016.805573-1-talesam@gmail.com>
 <20260813023016.805573-2-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 02:47:40 +0000
Message-Id: <20260813024741.139A71F000E9@smtp.kernel.org>
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
- [High] The asynchronous devcoredump capture work is never canceled if the=
 driver unloads before it runs, leading to a Use-After-Free of `xe_device` =
and execution of unmapped module text.
--

--- Patch [1]: [PATCH v2 1/3] drm/xe: Capture devcoredump on TLB invalidati=
on timeout ---
commit 32f12415ddea719f0004ff662a031ef828c48ba8
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

    drm/xe: Capture devcoredump on TLB invalidation timeout

This commit introduces a variant of xe_devcoredump() designed to capture
the GuC log and CT state on GTs for hangs that aren't tied to an exec queue
or job. It then hooks this up to the TLB invalidation timeout path to
diagnose GuC TLB invalidation ack stalls.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> index 5f2b90b18f97b..6bee8933f9578 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -323,40 +318,44 @@ static void xe_devcoredump_deferred_snap_work(struc=
t work_struct *work)
>  }
> =20
>  static void devcoredump_snapshot(struct xe_devcoredump *coredump,
> +				 struct xe_gt *gt,
>  				 struct xe_exec_queue *q,
>  				 struct xe_sched_job *job)
>  {

[ ... ]

> -	ss->gt =3D q->gt;
> +	ss->gt =3D gt;
>  	INIT_WORK(&ss->work, xe_devcoredump_deferred_snap_work);
> =20
>  	/* keep going if fw fails as we still want to save the memory and SW da=
ta */

[ ... ]

>  	queue_work(system_dfl_wq, &ss->work);

[Severity: High]
This is a pre-existing issue, but is it possible for this work item to run
after the module is unloaded?

If the driver unbinds or the module unloads before this work executes, the
devm action xe_driver_devcoredump_fini() runs and calls dev_coredump_put().
Since the devcoredump device hasn't been created yet (which happens inside
the work via dev_coredumpm_timeout()), that function does nothing.

The xe_device memory is then freed by devres, and the module text may be
unmapped. When system_dfl_wq eventually executes
xe_devcoredump_deferred_snap_work(), could this result in a Use-After-Free
of the xe_device and a jump to unmapped module memory?

> =20
>  	dma_fence_end_signalling(cookie);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813023016.8055=
73-1-talesam@gmail.com?part=3D1
