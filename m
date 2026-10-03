Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339FACA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB9010E714;
	Sat,  3 Oct 2026 01:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f/RB3EHt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE73710E714;
 Sat,  3 Oct 2026 01:33:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CB8160A97;
 Sat,  3 Oct 2026 01:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90DC1F0089A;
 Sat,  3 Oct 2026 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991197;
 bh=tRwtVOpXEQqgWSgqNTVcB1+XqGOHmZ/GNHN5nYpi64Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f/RB3EHtr7Oyy8GYV73aXx2SsTUlZDOaT4KcOCMZowVaI9WQZonqrKZ4UWy1z+GMP
 4z2EJkWNHyT43Ad3jQDTfcnql8AiC76WaPwmHhVVcE5HLww/cl34lqQmLg3MYvLLEc
 cXWoG26v0omFySLEfKgXK9drd3W44fEaa7xGqs+daumTdpdiCfolp8Ab/GqLMpUVbN
 tvdQcEktgbJyOqff/GN+F+hkJgsBRaFKfEDOx0yqSg2q3l1gh2p5nacwv7y9s8egxQ
 Aig2nz5KlNXB/nss9PmRoOmvs9BUgDEZAb3M+rdID/2UVJaiPTMk4DwPLkkAfRvPFU
 01HmZcUEjOfeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/pmu: convert i915_pmu->lock to raw_spinlock_t
 from spinlock_t
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20261002161137.297365-1-ashelat@redhat.com>
References: <20261002161137.297365-1-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:16 +0000
Message-Id: <20261003013316.E90DC1F0089A@smtp.kernel.org>
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
- [High] i915/pmu: sleep in atomic (PREEMPT_RT) lock inversion in i915_pmu_=
gt_parked()
--

commit 4674b42fb5bd16ec1392c65ea4ec0e37639b3618
Author: Anubhav Shelat <ashelat@redhat.com>

drm/i915/pmu: convert i915_pmu->lock to raw_spinlock_t from spinlock_t

This commit converts the pmu lock from spinlock_t to raw_spinlock_t. The
conversion aims to avoid a sleep-in-atomic error on PREEMPT_RT kernels when
perf operations are called under a raw spinlock.

> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_=
pmu.c
> index 1c3bafda9c708..65771e54b9b51 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
[ ... ]
> @@ -304,7 +304,7 @@ void i915_pmu_gt_parked(struct intel_gt *gt)
>  	if (!pmu->registered)
>  		return;
> =20
> -	spin_lock_irq(&pmu->lock);
> +	raw_spin_lock_irq(&pmu->lock);
> =20
>  	park_rc6(gt);

[Severity: High]
Does this introduce a lock inversion on PREEMPT_RT kernels?

The patch converts pmu->lock to raw_spinlock_t, but i915_pmu_gt_parked() ca=
lls
into a path that acquires a regular spinlock_t while this raw lock is held:

i915_pmu_gt_parked()
  raw_spin_lock_irq(&pmu->lock);
  park_rc6()
    __get_rc6()
      intel_rc6_residency_ns()
        spin_lock_irqsave(&uncore->lock, flags);

Because uncore->lock is still a standard spinlock_t, it can sleep on PREEMP=
T_RT
kernels. Acquiring it while holding the raw pmu->lock violates the lock
hierarchy and can cause a sleep-in-atomic panic during normal power managem=
ent
operations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002161137.2973=
65-1-ashelat@redhat.com?part=3D1
