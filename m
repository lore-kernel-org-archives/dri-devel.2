Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE68CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC49A10E63C;
	Mon, 15 Jun 2026 20:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JYMVHDMY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBEB10E63C
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:30:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3E0F601E1;
 Mon, 15 Jun 2026 20:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC79B1F000E9;
 Mon, 15 Jun 2026 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555407;
 bh=IA2ebLHqkhTfXEduin5pd/mq+lMyjIuSSbdM1giW5+o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JYMVHDMYiJvbMokau0PU2txsEP3x3eUx50frdR2ZG0xSL4EDpw0tD3GFhSYf2JmYW
 iDm9B/+p0aI8cByrA6xDuQNSGJqxlPVBtsm8TSlJClJ9WdoIa75UvI9F8F4VHMm7nQ
 TYslyjLNZ2pYIEOrCnzl3E+qFhd82rJOzMzTkonD8UXbNVRrYxAWuF4zs43n/jzT16
 K6KODqFpmm/zJkehhEl3/KDlJIz+8iczcIJ1G+fQ4MXoTvSfgBWtmxNhLlYG6t0/oN
 V8jSS03LGpKDXF6QVtCw+ULBCWUKM9YODsQejq2UkrgUd/YGU5Fgwm8vVBWOpDDRa7
 3e2owpoaIKfFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/27] drm/vblank_work: Add methods to schedule
 vblank_work in 2 stages
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-2-dev@lankhorst.se>
References: <20260615201846.307297-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:30:05 +0000
Message-Id: <20260615203006.AC79B1F000E9@smtp.kernel.org>
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
- [Medium] drm_vblank_work_schedule() fails to update the `armed` state if =
the target vblank count matches the currently scheduled count, causing stat=
e mismatches and resource leaks.
- [Low] Plain reads and writes to `work->armed` race with concurrent lockle=
ss accesses, causing potential compiler reordering issues.
--

commit 541484cf3b17ab53b7e81696c1a0711cae54129c
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/vblank_work: Add methods to schedule vblank_work in 2 stages

This commit introduces a 2-stage mechanism for scheduling vblank work. It
allows PREEMPT_RT systems to prepare work in advance, and then arm it later
using a lockless function to maintain constant execution times in disabled
interrupt contexts.

> diff --git a/drivers/gpu/drm/drm_vblank_work.c b/drivers/gpu/drm/drm_vbla=
nk_work.c
> index 70f0199251ea0..6acb240b9c112 100644
> --- a/drivers/gpu/drm/drm_vblank_work.c
> +++ b/drivers/gpu/drm/drm_vblank_work.c
[ ... ]
> @@ -139,6 +118,7 @@ int drm_vblank_work_schedule(struct drm_vblank_work *=
work,
>  		rescheduling =3D true;
>  	}
> =20

[Severity: Medium]
If a driver calls drm_vblank_work_schedule_disabled() followed by
drm_vblank_work_schedule() with the exact same count to enable it, does the
early exit for matching counts bypass updating the armed state?

For example, if __drm_vblank_work_schedule() in
drivers/gpu/drm/drm_vblank_work.c takes this path earlier in the function:

	} else if (work->count =3D=3D count) {
		/* Already scheduled w/ same vbl count */
		goto out;

If the work item remains unarmed after returning, could this regression leak
the hardware vblank reference since the item will never execute or be remov=
ed
from the pending list?

[Severity: Low]
Since the armed state is read locklessly by drm_handle_vblank_works() and
modified locklessly by drm_vblank_work_enable(), should this plain write in
__drm_vblank_work_schedule() use WRITE_ONCE() to prevent C data races and
compiler reordering regressions?

> +	work->armed =3D armed;
>  	work->count =3D count;
>  	cur_vbl =3D drm_vblank_count(dev, vblank->pipe);
>  	passed =3D drm_vblank_passed(cur_vbl, count);
[ ... ]
> +/**
> + * drm_vblank_work_enable - enable vblank work
> + * @work: vblank work to enable
> + *
> + * This function is specifically only for when drm_vblank_work_schedule_=
disabled() is
> + * called. It allows for the work to be armed in any context, without an=
y locks.
> + *
> + * The work will be signalled earliest at the @count argument, if it has=
 been passed,
> + * it will signalled at the next vblank.
> + *
> + * This is particularly useful for PREEMPT_RT, where the spin_lock is co=
nverted
> + * into a sleeping rtmutex, and vblank evasion requires some work to be
> + * scheduled on completion with interrupts disabled.
> + */
> +void drm_vblank_work_enable(struct drm_vblank_work *work)
> +{

[Severity: Low]
Because drm_vblank_work_enable() in drivers/gpu/drm/drm_vblank_work.c is
designed to be called locklessly, does this plain read of work->armed race
with concurrent modifications?

Should this use READ_ONCE() to avoid KCSAN warnings and compiler optimizati=
on
regressions?

> +	WARN_ON(work->armed);
> +	WRITE_ONCE(work->armed, true);
> +}
> +EXPORT_SYMBOL(drm_vblank_work_enable);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D1
