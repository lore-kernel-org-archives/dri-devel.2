Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE3EC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA7410E24B;
	Fri, 10 Jul 2026 22:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Idz3cqrv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D05B10E24B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:08:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 932F260052;
 Fri, 10 Jul 2026 22:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DA91F000E9;
 Fri, 10 Jul 2026 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721313;
 bh=y6+ZQe74/l/M2O8tKwGBK5NI48tPJHtBfemkqvcWmM0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Idz3cqrvBiN8c7CPOY5kgrkuMDsIHwtsXGdtUUeCTNZBzK0bodCMo2q/VwmE7Or+4
 eCPDtYeFho8TMDWaUjMipGlxgDxgH8e1uk3ADE53gK1iqY1CDDjV9QbAPKZlTHpUly
 72vK0j5JYosmHA5kR/6+FmfhC7cpNBKEiUNWxUN/a6LTC4RRQSBYsmGMEulDyvDZn/
 AXTRoomGrPciJX+poVCxuc1f0GepV/UDeQ0P3r6opC7qWGWHq2ONdzL0pjyQjbj4Vc
 BvU6bVV3ZmKz4kjZu7dRmyORkIgQl7pzXdU8bVh5017+AEyOdzJbXEhS74gC6ZshtW
 /r7LIbt1Qoavg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/33] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-2-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:08:32 +0000
Message-Id: <20260710220833.13DA91F000E9@smtp.kernel.org>
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
- [Medium] `beneficial_reclaim_backoff` unintentionally disables reclaim fo=
r all non-zero orders if the pool has no beneficial order.
--

--- Patch [1]: [PATCH v2 01/33] drm/ttm/pool: Allow backing off reclaim at =
the beneficial order ---
commit 33813073a08d456967f60dbd0f79ceb761550bda
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm/pool: Allow backing off reclaim at the beneficial order

This commit adds a beneficial_reclaim_backoff flag to struct
ttm_operation_ctx. When set, it allows the allocator to skip reclaim and
compaction at the pool's beneficial order, falling back to smaller orders
quickly instead of stalling.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 3d5f2ae0a4564..dbe977412a811 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -165,10 +166,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_=
pool *pool, gfp_t gfp_flags,
>  	 * Do not add latency to the allocation path for allocations orders
>  	 * device tolds us do not bring them additional performance gains.
>  	 */
> -	if (order && beneficial_order && order !=3D beneficial_order)
> +	if (order && (beneficial_reclaim_backoff ||
> +		      (beneficial_order && order !=3D beneficial_order)))
>  		gfp_flags &=3D ~__GFP_RECLAIM;

[Severity: Medium]
Does this unintentionally disable reclaim for all non-zero orders if the
pool has no configured beneficial order?

If a caller sets ctx->beneficial_reclaim_backoff =3D true for an allocation
on a TTM pool where ttm_pool_beneficial_order(pool) =3D=3D 0, the condition
above evaluates to true for any order > 0. This unconditionally clears
__GFP_RECLAIM.

High-order page allocations would then completely skip direct and kswapd
reclaim, causing them to fail prematurely and fall back to order-0
allocations. This seems to defeat the purpose of high-order pools when
no beneficial order is specified.

Should this condition explicitly require beneficial_order to be non-zero
when evaluating beneficial_reclaim_backoff?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D1
