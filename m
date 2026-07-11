Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE6C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DBC710E703;
	Sat, 11 Jul 2026 03:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MHM7D4kE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5691910E6FF
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:12:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD9E660051;
 Sat, 11 Jul 2026 03:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EEA1F000E9;
 Sat, 11 Jul 2026 03:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739565;
 bh=vEpb7F7mOlcOXee2Z/XMbDIUWZxPI66+Xr0+/xXBbRQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MHM7D4kE6uD3EMANok/9BpJB2r2fueZXJselXzCFcnkc9q8rDUJwmq+W88tq4h2Z0
 5gb6VLzgxV7uW/u3BGkx2vyQ/08aFhbCnKpHVGJiunf541Q+KOMxwgdwSHCqQCpPIc
 e0wfpnYV1wE6BW6tG2XsXcRFRzls5RH0gSZcnJuEYj+szPEI9AHhyq2pn2/JF4Fd9/
 Be2NL7pYAquEAZQkwmZ3EYhwULlYUWeztD0g2Lwnz66Co87LqKoUJa7S0PrFxsaik9
 FsbnRjVSTfk5gl5l5azCL2OSWh3Wo08dzVTxwR2a+FLLzSWjmEdu7hb9RLlWZUKkFY
 VAI3MOUhPoOYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/33] drm/xe: Add defrag GT stats
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-22-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-22-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:12:44 +0000
Message-Id: <20260711031245.59EEA1F000E9@smtp.kernel.org>
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
- [Medium] The `defrag_mb_moved` counter loses precision and will significa=
ntly undercount the amount of data moved.
--

--- Patch [21]: [PATCH v3 21/33] drm/xe: Add defrag GT stats ---
commit 84ae24372375a8f7d60dca398232ca340eba4dd8
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Add defrag GT stats

This commit introduces observability for the page defragmentation worker by
adding GT statistics counters. It tracks counts for buffer objects added to
the defrag list, successful defragmentations, partial successes, failures,
and the amount of data moved in megabytes.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 907cfa57481f4..073d926ef9ace 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -1274,8 +1277,21 @@ static int xe_bo_defrag_one(struct xe_device *xe, =
struct xe_bo *bo,
>  	xe_dbg(xe, "Defrag attempt on BO size=3D%zu: ret=3D%pe consumed=3D%llu\=
n",
>  	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
> =20
> -	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
> +	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm)) {
>  		*needs_more =3D true;
> +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> +				 XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
> +				 1);
> +	} else {
> +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> +				 ret ? XE_GT_STATS_ID_DEFRAG_FAILED_COUNT :
> +				       XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT, 1);
> +	}
> +
> +	if (!ret)
> +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> +				 XE_GT_STATS_ID_DEFRAG_MB_MOVED,
> +				 *consumed >> 20);

[Severity: Medium]
Does this right-shift truncate the accumulation of data moved? If *consumed
is less than 1 MiB (for example, a 64 KiB chunk), *consumed >> 20 evaluates
to 0, meaning it will not be counted at all.

Could this lead to significantly undercounting the actual data moved? Would
it be better to accumulate raw bytes in the counter and only convert to
megabytes when formatting the output for userspace?

> =20
>  unlock:
>  	xe_bo_unlock(bo);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D21
