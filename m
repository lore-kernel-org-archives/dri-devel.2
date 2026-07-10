Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB28C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE5410E260;
	Fri, 10 Jul 2026 22:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="elVCtIpW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8B310E260
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:16:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84A2843960;
 Fri, 10 Jul 2026 22:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3081F000E9;
 Fri, 10 Jul 2026 22:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721809;
 bh=AA8jfCHNaCfGmcaGFa/bpV/pxdrgbim7j0CpdaPRsRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=elVCtIpWebPQ/ianKAVYYNITDQJnkTdtpg/WGC7inel6QMW8JF4ttW22eJNSH3XTP
 eSkvljm9XhIpwOUBl2TD1l1FbfgA4ek5KF0zTesb5XcGggaHq78m/+dHdrLIzMTiJN
 rKNk/s4NmZEiLcMQ5jFhVLFUdNcjMmOjf84f4qXkb88JAlFyxU4UnVLypifeOo1Upe
 g7JY4TGO6IYQPd8J4ol6YqCKL6eFmSvbJsuZgeZBnyY5jbProSLU9JtfaAvudpn8Db
 Q9OfIYcfHKCsGrJAyuxC8k3f3On3eWPuXz1I/5WouIwj5JSpveIIeGncWUMjL2UtgN
 j8A94FvInGtMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/33] drm/xe: Add defrag GT stats
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-22-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-22-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:16:48 +0000
Message-Id: <20260710221649.3D3081F000E9@smtp.kernel.org>
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
- [Medium] The statistic `XE_GT_STATS_ID_DEFRAG_MB_MOVED` systematically un=
dercounts data moved because it truncates the byte count to megabytes *befo=
re* accumulating it into the global counter. Any defragmentation move small=
er than 1 MiB (e.g., re-backing a 64 KiB page) will evaluate to 0 and not b=
e counted at all. Additionally, the sub-megabyte remainders of larger moves=
 are permanently lost.
--

--- Patch [21]: [PATCH v2 21/33] drm/xe: Add defrag GT stats ---
commit a152b345237256025e6e622bf740f0941373de67
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add defrag GT stats

This commit introduces observability for the page defragmentation worker by
adding several primary-GT statistics counters. These counters track the
success, failure, and amount of data moved during defragmentation attempts.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6a847e42946ce..c1bbcf0d21edb 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -1264,6 +1267,20 @@ static int xe_bo_defrag_one(struct xe_device *xe, =
struct xe_bo *bo,
>  	xe_dbg(xe, "Defrag attempt on BO size=3D%zu: ret=3D%pe consumed=3D%llu\=
n",
>  	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
> =20
> +	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
> +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> +				 XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
> +				 1);
> +	else
> +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> +				 ret ? XE_GT_STATS_ID_DEFRAG_FAILED_COUNT :
> +				       XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT, 1);
> +
> +	if (!ret)
> +		xe_gt_stats_incr(xe_root_mmio_gt(xe),
> +				 XE_GT_STATS_ID_DEFRAG_MB_MOVED,
> +				 *consumed >> 20);

[Severity: Medium]
Will this undercount the data moved if we truncate to megabytes before
accumulation?=20

If the consumed amount is less than 1 MiB (e.g. re-backing a 64 KiB page),
this evaluates to 0 and nothing is added to the global counter. The
sub-megabyte remainders of larger moves also appear to be permanently lost
on every function call.

Would it be better to accumulate the exact value in bytes (or kilobytes)
and only perform the division when presenting the statistic to user-space?

>  unlock:
>  	xe_bo_unlock(bo);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D21
