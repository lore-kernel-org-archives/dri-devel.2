Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90C0C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4232D10F01B;
	Thu, 27 Aug 2026 13:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gmVmT2mP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E7810F018;
 Thu, 27 Aug 2026 13:04:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE5DC40651;
 Thu, 27 Aug 2026 13:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B05F1F000E9;
 Thu, 27 Aug 2026 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787835856;
 bh=QTVEQRzLQF7U2Xp/PSUHL9wdhvUgwFRkJu+ql5gvkMU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gmVmT2mPggbX+LodhGe1tJ78Bwsq8ZTDh0zqPdF0EokiMr070je4JS0RWQDBIJTt7
 UfLes6ExbIQjFr8DJsiXPm4RdqXhDyb+HlkD+DBZIycJp7qGi2U/mMmhsFu3jF5p07
 +pR152GfItZH7EvjtPwljY7T1Vw3yP0OU+cpT8FVkjM1Yd3NKfdGO4bW9HHylZK0Ro
 CNUDJ5XHJZ59qslU9wtUBEJfGC4apK/fwkd+V600Ke8XBJjENHcHJ8r06K08yIkN1a
 qywy7SqaMVHuAX9J2xeThDD1GM+Y7HFv7Sy6UlgSd8ujkAfMzAL+riYqYKIGBpHkiP
 RumeCL9R46BZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] drm/xe: Use dma_resv_alloc for lockdep annotation
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-8-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:04:16 +0000
Message-Id: <20260827130416.7B05F1F000E9@smtp.kernel.org>
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
- [Low] Early return on dma_resv_alloc() failure unintentionally skips unre=
lated lockdep annotations.
--

commit 2c2f2285d05d44caf485778222c036bce79fbb3f
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/xe: Use dma_resv_alloc for lockdep annotation

This patch replaces the stack-allocated dma_resv in
xe_pm_runtime_lockdep_prime() with a dynamically allocated one to align with
the move towards reference-counted dynamic allocation.

> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index a5289a9df8d25..13f25d15f5482 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -764,15 +764,20 @@ static void xe_rpm_might_enter_cb(const struct xe_d=
evice *xe)
>   */
>  static void xe_pm_runtime_lockdep_prime(void)
>  {
> -	struct dma_resv lockdep_resv;
> +	struct dma_resv *lockdep_resv;
> +
> +	lockdep_resv =3D dma_resv_alloc();
> +	if (!lockdep_resv)
> +		return;

[Severity: Low]
Does this unconditional early return unintentionally skip the unrelated
lockdep annotations that follow?

If dma_resv_alloc() fails, it looks like we abort the entire
xe_pm_runtime_lockdep_prime() function. This skips the completely
independent shrinker and nod3cold annotations below. Could this lead to
incomplete lockdep coverage under memory pressure?

> =20
> -	dma_resv_init(&lockdep_resv);
>  	lock_map_acquire(&xe_pm_runtime_d3cold_map);
>  	/* D3Cold takes the dma_resv locks to evict bos */
> -	dma_resv_lock(&lockdep_resv, NULL);
> -	dma_resv_unlock(&lockdep_resv);
> +	dma_resv_lock(lockdep_resv, NULL);
> +	dma_resv_unlock(lockdep_resv);
>  	lock_map_release(&xe_pm_runtime_d3cold_map);
> =20
> +	dma_resv_put(lockdep_resv);
> +
>  	/* Shrinkers might like to wake up the device under reclaim. */
>  	fs_reclaim_acquire(GFP_KERNEL);
>  	lock_map_acquire(&xe_pm_runtime_nod3cold_map);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D7
