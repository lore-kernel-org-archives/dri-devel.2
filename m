Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C468C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A6510E360;
	Mon,  6 Jul 2026 11:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PDJJhdGJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09ED310E360
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:56:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7477F4195F;
 Mon,  6 Jul 2026 11:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB801F000E9;
 Mon,  6 Jul 2026 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783339007;
 bh=hbURqZ4Kx84iKLnBZMalN1EdVi23XUzFBV59EArYiUo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PDJJhdGJamJE46SDsyGMTavvkZ+m7pRqwdlIL8LtWkGRK5SVKH3nNCKOHEYf2w28Y
 ywgJ6wzFb1KoUYjwSrjNfWTT5vN/1Op3MrawFxWzE5tVgoXAPWtKo06nUdZuE2EaB5
 D5d7gxCp1sDRK0r/MT38Ay6gtNe/uXRngDucsUr+P0KnwZJUeel/a0+fgW63AJ3t2v
 a5on9XR13m3Zk/dzCZDOE55cDqCcF3UqcjvZrArMCodHOWFYkF5odRIeexweQwlTrZ
 HWHSGcTRVJrCdBop3LbU6LyYWSlYy68H/FihIMJFHSbJ2leQHP6OXpr8qssW+RYIN2
 W1BYnch38Pikg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] drm/i915/gt: Fix selftests on PREEMPT_RT
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706114823.752313-5-dev@lankhorst.se>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-5-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 11:56:46 +0000
Message-Id: <20260706115647.2CB801F000E9@smtp.kernel.org>
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
- [High] Incomplete implementation of PREEMPT_RT fixes for i915 selftests, =
leaving preemption-disabled busy-waits and delays that cause deadlocks and =
latency spikes.
--

commit c008dff1b2cefd9ee50ca924f83ff7c237a6fb3a
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/gt: Fix selftests on PREEMPT_RT

This commit modifies the i915 engine PM selftest to use migrate_disable()
instead of preempt_disable() around delay functions. This helps prevent=20
latency issues on PREEMPT_RT kernels.

> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/d=
rm/i915/gt/selftest_engine_pm.c
> index 10e556a7eac45..c1eff9edd8a5e 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
[ ... ]
> @@ -316,11 +316,11 @@ static int live_engine_busy_stats(void *arg)
>  		}
> =20
>  		ENGINE_TRACE(engine, "measuring busy time\n");
> -		preempt_disable();
> +		migrate_disable();
>  		de =3D intel_engine_get_busy_time(engine, &t[0]);
>  		mdelay(100);
>  		de =3D ktime_sub(intel_engine_get_busy_time(engine, &t[1]), de);
> -		preempt_enable();
> +		migrate_enable();

[Severity: High]
This isn't a bug introduced by this patch, but since this series addresses
PREEMPT_RT issues in i915 selftests, are there similar preemption-disabled
delays and waits remaining in other selftests that should be addressed?

For example, looking at live_rps_clock_interval() in
drivers/gpu/drm/i915/gt/selftest_rps.c, there is a block that disables
preemption for at least 1 millisecond:

    preempt_disable();
    cycles_[i] =3D -intel_uncore_read_fw(gt->uncore, GEN6_RP_CUR_UP_EI);
    dt_[i] =3D ktime_get();
   =20
    udelay(1000);
   =20
    cycles_[i] +=3D intel_uncore_read_fw(gt->uncore, GEN6_RP_CUR_UP_EI);
    dt_[i] =3D ktime_sub(ktime_get(), dt_[i]);
    preempt_enable();

Could this cause a severe latency spike on PREEMPT_RT?

Additionally, in drivers/gpu/drm/i915/selftests/i915_request.c,
measure_completion() disables preemption while busy-waiting for a callback:

    preempt_disable();
    semaphore_set(sema, i);
    while (!READ_ONCE(cb.seen))
        cpu_relax();
       =20
    elapsed[i - 1] =3D ENGINE_READ_FW(ce->engine, RING_TIMESTAMP);
    preempt_enable();

If the threaded handler that executes this callback is scheduled on the same
CPU on a PREEMPT_RT kernel, would this create a hard deadlock since the
busy-wait loop will never yield to the handler?

>  		dt =3D ktime_sub(t[1], t[0]);
>  		if (100 * de < 95 * dt || 95 * de > 100 * dt) {
>  			pr_err("%s: reported %lldns [%d%%] busyness while spinning [for %lldn=
s]\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706114823.7523=
13-1-dev@lankhorst.se?part=3D4
