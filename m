Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EF5C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BF510E52F;
	Tue, 28 Jul 2026 06:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N4TMvi6y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0608C10E52F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:31:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 041556013A;
 Tue, 28 Jul 2026 06:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB881F000E9;
 Tue, 28 Jul 2026 06:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785220264;
 bh=/h4QgnWMamG/lYDMui0YhGVEV27Fiz99sgQ8jwPFSJE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N4TMvi6yW0J9Qg3XPaCPGJuSbN4LF3/YkwtrpQIqfTKARNu9bfr5s4VRcv/WeEt7l
 dZ3RxhrJaVUkKCuoRcDoDG4v6XvOvt1ioE9y6ebsGIAXsCSPGGwjZEZSzWOHrBH8Vl
 UWOBJDjTuXPPcxEprzqHneoaSi18jRLkZm/tHIX7/1t+J4zZ1K5hUxV7r8HLo5tJpC
 USYPYvCJ2UrSMMZgeZeEXVM8jhswEyvsKLIW05INm5eiZ+NM3qxaIUEsBzZQtuIA/g
 axd3bzJ+m1AbKU5omsLYxlKNZGduDJHZLb+/zfohZZwatUQgQBy6FFLbM/KajKNqDv
 kqJfC4QMlc62A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
To: "Neil Zhong" <neil.zhong@ugreen.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <4BF27CE161436C73+20260728061443.33616-2-neil.zhong@ugreen.com>
References: <20260728061443.33616-1-neil.zhong@ugreen.com>
 <4BF27CE161436C73+20260728061443.33616-2-neil.zhong@ugreen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 06:31:03 +0000
Message-Id: <20260728063104.3EB881F000E9@smtp.kernel.org>
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
- [High] Unconditional dereference of `ttm_bo->ttm` in `xe_shrinker_skip_bo=
und_wc` can cause a kernel panic due to a NULL pointer dereference.
--

--- Patch [1]: [RFC PATCH 1/1] drm/xe: keep VM-bound WC BOs resident during=
 reclaim ---
commit 1cd578b99da153c47f4b384eb842462aba8d14d3
Author: Neil Zhong <neil.zhong@ugreen.com>

drm/xe: keep VM-bound WC BOs resident during reclaim

This commit adds logic to prevent the shrinker from reclaiming VM-bound
write-combined (WC) buffer objects to avoid expensive restore operations.
It introduces a module parameter to control this behavior and trades
reclaimable memory for lower latency.

> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shr=
inker.c
> index 83374cd576608..caa39f39cd155 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
[ ... ]
> @@ -54,6 +55,30 @@ xe_shrinker_mod_pages(struct xe_shrinker *shrinker, lo=
ng shrinkable, long purgea
>  	write_unlock(&shrinker->lock);
>  }
> =20
> +static bool xe_shrinker_skip_bound_wc(struct ttm_buffer_object *ttm_bo,
> +				      const struct xe_bo_shrink_flags flags)
> +{
> +	struct xe_bo *bo;
> +
> +	if (flags.purge || xe_modparam.allow_bound_wc_shrink ||
> +	    !xe_bo_is_xe_bo(ttm_bo))
> +		return false;
> +
> +	bo =3D ttm_to_xe_bo(ttm_bo);
> +
> +	/*
> +	 * Restoring a backed-up WC BO changes freshly allocated WB pages to WC.
> +	 * On x86 that runs CPA cache/TLB flushes synchronously while validation
> +	 * holds this BO's dma-resv. A VM-bound BO is also likely to be reused =
by
> +	 * a following EXEC, so reclaiming it can turn moderate memory pressure
> +	 * into a multi-client reservation-lock stall. Keep that working set
> +	 * resident; purgeable objects and objects after VM_UNBIND remain
> +	 * reclaimable.
> +	 */
> +	return ttm_bo->ttm->caching =3D=3D ttm_write_combined &&
> +		xe_bo_is_vm_bound(bo);
> +}
> +
>  static s64 __xe_shrinker_walk(struct xe_device *xe,
>  			      struct ttm_operation_ctx *ctx,
>  			      const struct xe_bo_shrink_flags flags,
> @@ -75,6 +100,9 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
>  			continue;
> =20
>  		ttm_bo_lru_for_each_reserved_guarded(&curs, man, &arg, ttm_bo) {
> +			if (xe_shrinker_skip_bound_wc(ttm_bo, flags))
> +				continue;
> +
>  			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
>  				continue;

[Severity: High]
Does this code risk a NULL pointer dereference when accessing ttm_bo->ttm
inside xe_shrinker_skip_bound_wc()?

A buffer object can be on the LRU list with a NULL ttm pointer under
certain conditions, such as during early initialization or if pipeline
gutting removes it.

While ttm_bo_shrink_suitable() safely handles this by checking if
ttm_bo->ttm is populated, the new xe_shrinker_skip_bound_wc() check is
invoked prior to ttm_bo_shrink_suitable(). This leads to an unconditional
dereference of ttm_bo->ttm in xe_shrinker_skip_bound_wc() before the safety
check occurs.

Could the check be moved after ttm_bo_shrink_suitable(), or should
xe_shrinker_skip_bound_wc() explicitly verify ttm_bo->ttm before
dereferencing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4BF27CE161436C73+20=
260728061443.33616-2-neil.zhong@ugreen.com?part=3D1
