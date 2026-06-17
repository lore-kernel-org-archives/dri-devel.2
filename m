Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA19CD98E1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 03:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E76010E043;
	Wed, 17 Jun 2026 03:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LNSxBYeR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111CC10E043
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:28:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9B87440C2;
 Wed, 17 Jun 2026 03:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C841F000E9;
 Wed, 17 Jun 2026 03:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781666933;
 bh=YCzxViVlN5X6a64AfqlJbDlg8QQD5U9eKNq2e49JQ2E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LNSxBYeRVdgo0HGemfgdOxeAZBqkwgKwauHroXWIadiymkMCW2Hdndb2gWPJ26fR7
 GUmGhog1KGx4kWd26MaWHhzbcuNw4Zpu5+IIvlP4iYF6ORYj7WYO7SIhYcPt1vx7zx
 6bwb9YJeDmrn0K61ysYBF4RR9ISlkOI1NrcJQTEhFa/TYVS7+LqVFccUoeROLe5/y7
 fUCy8PwSd2Nkp4NKKGq3Nd8I+2DyeGc6gqdikfDecPEoo6tKBikTsADWSKImKknuyn
 yzcEcVJYZJAKiaiDvF/ODCF1gShL/NNerBP559rOMGa9fhuvPUBRK1/NbL7jm2gWXa
 7tXJc31up9dVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/xe: Make use of
 shrink_control::opportunistic_compaction hint
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617032218.1165929-3-matthew.brost@intel.com>
References: <20260617032218.1165929-1-matthew.brost@intel.com>
 <20260617032218.1165929-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 03:28:53 +0000
Message-Id: <20260617032853.76C841F000E9@smtp.kernel.org>
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
- [Medium] Spurious runtime PM wakeups during opportunistic compaction recl=
aim.
--

commit 9d2dcd5b46c4108efa18e04768837bf386796338
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Make use of shrink_control::opportunistic_compaction hint

This patch uses the new opportunistic_compaction hint in the Xe shrinker
to avoid backing up GPU memory during high-order fragmentation-driven
reclaim attempts. This prevents reclaim/rebind ping-pong behavior
without affecting order-0 reclaim.

> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shr=
inker.c
> index 83374cd576608..198149f266c60 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
[ ... ]
> @@ -233,7 +240,14 @@ static unsigned long xe_shrinker_scan(struct shrinke=
r *shrink, struct shrink_con
>  	}
> =20
>  	sc->nr_scanned =3D nr_scanned;
> -	if (nr_scanned >=3D nr_to_scan || !can_backup)
> +	/*
> +	 * Stop after the purge pass for opportunistic high-order reclaim:
> +	 * the subsequent backup/writeback pass works at native page order
> +	 * and is unlikely to free a contiguous high-order block, so doing
> +	 * it here would just churn working sets for no compaction benefit.
> +	 */
> +	if (nr_scanned >=3D nr_to_scan || !can_backup ||
> +	    sc->opportunistic_compaction)
>  		goto out;

[Severity: Medium]
Does this cause a spurious runtime PM wakeup during opportunistic compactio=
n?

Looking earlier in xe_shrinker_scan(), xe_shrinker_runtime_pm_get() is call=
ed
to eagerly wake up the device based on the can_backup flag:

	/* Might need runtime PM. Try to wake early if it looks like it. */
	runtime_pm =3D xe_shrinker_runtime_pm_get(shrinker, false, nr_to_scan, can=
_backup);

Since the early exit above skips the backup phase when opportunistic compac=
tion
is requested, an asynchronous worker might still be queued to wake the GPU
from suspend even though the backup pass will never run.

Could the can_backup flag be updated to also incorporate the
sc->opportunistic_compaction state to prevent these wakeups?

> =20
>  	/* If we didn't wake before, try to do it now if needed. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617032218.1165=
929-1-matthew.brost@intel.com?part=3D2
