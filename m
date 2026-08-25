Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839A9C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC23E10EA26;
	Tue, 25 Aug 2026 12:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MJmdoSFd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B2810EA26;
 Tue, 25 Aug 2026 12:29:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC3824166E;
 Tue, 25 Aug 2026 12:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C531F000E9;
 Tue, 25 Aug 2026 12:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660983;
 bh=HRLWYJbKwOApKH+48tMVqFtRbkWoRJduhSjRZhl8sZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MJmdoSFdSQVvWCBIsA3hwzN5sM20Ysm4YrjHierT2Q4sYF/WPO+1VuSO6tmM32Fe1
 SOtNhXNwWIH+Ok/qYYo+GtX3p3s+lyS1eMIqZDtkjuUEdMz5bIJOxkqJdSmRz54y+x
 J1VOO9z9h88cGgruXT2724QA4iI+p73CpOActnv9gglXT2gbAvRsuLUC3CvOTofxWE
 EE+zfVN96OfwShbfjlv2E1GhC/vaYTlNQwW1Cjvnq5CG8UZ7mpj/hsIZD9t2J5h3VS
 X2GHYjLWhJgzem2FduVrQwj2rOGwUeXisTLqAp18xMD46qkakzGJeg2WaSgY9JuwRe
 YI/VRK/glL+GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] drm/i915/pmu: use the expiry injecting hrtimer
 callback
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260825-expires-v2-v1-2-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-2-90411c6217c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:29:42 +0000
Message-Id: <20260825122943.69C531F000E9@smtp.kernel.org>
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
- [High] Race condition in `i915_pmu_unregister()` allowing the timer to be=
 rearmed after cancellation, leading to a use-after-free.
--

--- Patch [2]: [PATCH 2/6] drm/i915/pmu: use the expiry injecting hrtimer c=
allback ---
commit 3544b866c523f970d22c7a2ae5ea50d0bc15978f
Author: Andreas Hindborg <a.hindborg@kernel.org>

drm/i915/pmu: use the expiry injecting hrtimer callback
   =20
The commit converts the i915 PMU sampling timer to use the expiry injecting
callback variant. This prevents a race condition between the timer callback
forwarding itself and concurrent timer restarts when the GT is unparked.

> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_=
pmu.c
> index 1c3bafda9c708..c18587e200c9f 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c

[ ... ]

> @@ -1157,7 +1159,7 @@ void i915_pmu_register(struct drm_i915_private *i91=
5)
>  	int ret =3D -ENOMEM;
> =20
>  	spin_lock_init(&pmu->lock);
> -	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_R=
EL);
> +	hrtimer_setup_ext(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);

[Severity: High]
This is a pre-existing issue, but is there a race condition between the PMU
unregistration and GT unparking that can lead to a use-after-free?

Looking at i915_pmu_gt_unparked() in drivers/gpu/drm/i915/i915_pmu.c, it
performs a lockless check on pmu->registered before acquiring the lock:

drivers/gpu/drm/i915/i915_pmu.c:i915_pmu_gt_unparked() {
	if (!pmu->registered)
		return;

	spin_lock_irq(&pmu->lock);

	/*
	 * Re-enable sampling timer when GPU goes active.
	 */
	if (pmu->unparked =3D=3D 0)
		__i915_pmu_maybe_start_timer(pmu);
    ...
}

Concurrently, i915_pmu_unregister() sets pmu->registered to false and
cancels the timer:

drivers/gpu/drm/i915/i915_pmu.c:i915_pmu_unregister() {
    ...
	/* Disconnect the PMU callbacks */
	pmu->registered =3D false;

	hrtimer_cancel(&pmu->timer);
    ...
}

If a user unparks the GT (e.g., by submitting a request) while the driver is
being removed, could i915_pmu_gt_unparked() read pmu->registered as true,
wait for the lock, and then rearm the timer after i915_pmu_unregister() has
already cancelled it?

When the drm_i915_private struct is later freed, would the rearmed timer
fire on freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-expires-v2=
-v1-0-90411c6217c7@kernel.org?part=3D2
