Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01944C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610F310E918;
	Mon,  6 Jul 2026 12:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QrxpU+vF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B738A10E918
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:02:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D44543492;
 Mon,  6 Jul 2026 12:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33AF1F000E9;
 Mon,  6 Jul 2026 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783339329;
 bh=x80MCiojiqH1PTayLQsAdWTXoS5RSHovSARhLcqbqWM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QrxpU+vFJoP4AhGXhRpyTNTIJ4QjCn8O3llUImYNGiiX9qK1rBHPpyB8SUhrrlcv0
 kl2L9zldQnwRzCFYzTBJPGb8DILDLvxxj1vK+knrzAJv+L7pLgc5riQf5QajtCHiVy
 DapCKYOGO9VdKCOv96GwprOdz2oXvuxYxgmbL6lEiV/poLHwFBk2dpy5NJdagnlB2G
 ukMYtndycP7JHm2SoXf8xwsTbIjHLcSXnNNGfQ/LLED+AzaZMpmZxCyRFEJ2hfalpO
 c6/4BeCyS3KyvVUBm3STqzQ7K+biiZX7QJF+ctRsdT+Sllx+JcBHnK85wLbOk5OCZ0
 rzUW+SiVOOKMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] drm/i915/guc: Consider also RCU depth in busy loop.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706114823.752313-4-dev@lankhorst.se>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-4-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:02:08 +0000
Message-Id: <20260706120208.E33AF1F000E9@smtp.kernel.org>
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
- [High] Looping with IRQs disabled causes soft-deadlocks and CT buffer bre=
akage because the G2H draining tasklet cannot run.
--

commit fa66d9f372062707343fef0e57e8f112f58ecabc
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/guc: Consider also RCU depth in busy loop.

This commit updates the not_atomic condition in intel_guc_send_busy_loop
to additionally check rcu_preempt_depth. This prevents RCU splats on
PREEMPT_RT systems where sleeping spinlocks are acquired, which would
cause in_atomic and irqs_disabled to report false.

> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i91=
5/gt/uc/intel_guc.h
> index 053780f562c1a..b25fa8f4dc4bd 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
> @@ -362,7 +362,7 @@ static inline int intel_guc_send_busy_loop(struct int=
el_guc *guc,
>  {
>  	int err;
>  	unsigned int sleep_period_ms =3D 1;
> -	bool not_atomic =3D !in_atomic() && !irqs_disabled();
> +	bool not_atomic =3D !in_atomic() && !irqs_disabled() && !rcu_preempt_de=
pth();

[Severity: High]
This isn't a bug introduced by this patch, but does spinning with IRQs
disabled here cause a soft-deadlock that breaks the GuC CT buffer?

If the G2H buffer fills up and intel_guc_send_nb returns -EBUSY, the code
enters a busy loop. If the caller acquired spinlocks that disabled IRQs,
not_atomic will evaluate to false, causing the loop to use cpu_relax
instead of sleeping.

Inside this process, has_room_nb is called, which attempts to drain the
credits by queuing a tasklet:

drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c:has_room_nb() {
    ...
    tasklet_hi_schedule(&ct->receive_tasklet);
    ...
}

This schedules the tasklet on the local CPU's tasklet list and sets
TASKLET_STATE_SCHED. However, because the local CPU is spinning in
cpu_relax with IRQs disabled, softirqs will never run.

Since the tasklet is pinned to the local deadlocked CPU, other CPUs
cannot drain the buffer even if they receive the GuC hard interrupt.
The G2H buffer never drains, and after 1.5 seconds, ct_deadlocked
returns true, permanently breaking the CT buffer.

> =20
>  	/*
>  	 * FIXME: Have caller pass in if we are in an atomic context to avoid
>  	 * using in_atomic() as it doesn't work for all configs (e.g. PREEMPT).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706114823.7523=
13-1-dev@lankhorst.se?part=3D3
