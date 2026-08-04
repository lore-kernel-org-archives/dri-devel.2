Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29617C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C83310E909;
	Tue,  4 Aug 2026 08:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wh02DiHe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C386310E149
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:40:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 371F5600AA;
 Tue,  4 Aug 2026 08:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B71D1F000E9;
 Tue,  4 Aug 2026 08:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785832847;
 bh=L79m/LbSPk6X8SgowI4lKtqYpnsB3tHP1d321PMomMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wh02DiHeukfTA/4lp391ULWuMgetL4KXSBt4ESK2yx/ZHjE7IKWeJg/bu3T+ZiTS0
 ljCJ5h093uuEvs4g3L+1iGVfA++xrWT5Bs2FUnvOWhtUBfqNlaDxHT2IAFe7qnAUX4
 i8Oqv1gxjZ2S7Jdeb+zoH/ch3alWTRIXIeQykRxcjl8+OJVfR8ImLZCmyxkRAozvOF
 OfvhaJ/D36gCDcmAN+P+rkR2AK9nKvpfAy6t6NqJwsnmByUbqw1WPcf7+FmjCRmQ+8
 jau1z9sZ1if49qY1vPqAJ1AO1i+RKInAh/uN9Bm5BjA/DWEa+1Wx7kJeB54o8LcTZp
 VAU4YTI0PBi5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] drm/ttm: Be more aggressive when allocating
 below protection limit
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: tj@kernel.org, dri-devel@lists.freedesktop.org, mkoutny@suse.com,
 hannes@cmpxchg.org
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-5-07af96681bf8@gmx.de>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
 <20260804-dmemcg-aggressive-protect-v8-5-07af96681bf8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:40:46 +0000
Message-Id: <20260804084047.8B71D1F000E9@smtp.kernel.org>
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
- [High] Allocations protected by the dmem cgroup `min` limit will incorrec=
tly evict their own cgroup's buffers during the early eviction pass, preven=
ting the cgroup from reaching its `min` guarantee.
--

--- Patch [5]: [PATCH v8 5/6] drm/ttm: Be more aggressive when allocating b=
elow protection limit ---
commit 30d3ed5047eb42c7b72fcb6f1d1973210be68163
Author: Natalie Vock <nat@pixelcluster.dev>

drm/ttm: Be more aggressive when allocating below protection limit
   =20
When the cgroup's memory usage is below the low/min limit and allocation
fails, try evicting some unprotected buffers to make space. Otherwise,
application buffers may be forced to go into GTT even though usage is
below the corresponding low/min limit, if other applications filled VRAM
with their allocations first.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3becddd2c43b8..6bbea148838e4 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -537,12 +541,50 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_=
object *bo,
[ ... ]
> +	/*
> +	 * Buffers protected by 'min' will never be considered for eviction
> +	 * anyway, so the regular eviction path should be triggered here.
> +	 * Buffers protected by 'low' but not 'min' will take a special
> +	 * eviction path that only evicts buffers covered by neither 'low' or
> +	 * 'min' protections.
> +	 */
> +	if (!alloc_state->in_evict) {
> +		may_evict |=3D dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
> +		alloc_state->may_try_low =3D may_evict;
> +
> +		may_evict |=3D dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
> +	}

[Severity: High]
Does this code inadvertently allow a cgroup to evict its own buffers when i=
t is
below the min limit?

When dmem_cgroup_below_min() returns true, alloc_state->may_try_low is set
to true here.

Later in ttm_bo_evict_cb(), this causes the self-eviction skip check to be
bypassed:

	if (!evict_walk->alloc_state->may_try_low &&
			bo->resource->css =3D=3D evict_walk->alloc_state->charge_pool)
		return 0;

Because dmem_cgroup_state_evict_valuable() allows a pool to evict from itse=
lf,
this means the cgroup will evict its own buffers instead of unprotected buf=
fers
from other cgroups. Will this prevent the cgroup from reaching its min limit
guarantee?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-dmemcg-agg=
ressive-protect-v8-0-07af96681bf8@gmx.de?part=3D5
