Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DAFC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5560D10E2B8;
	Mon, 31 Aug 2026 15:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B4SGTFWC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E3610E2B8
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:59:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77C6243D46
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263E11F000E9;
 Mon, 31 Aug 2026 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788191957;
 bh=oOLWruVPTTP7uahjoEb5eJZJMNQ3e+6BT7n+JnBh3KQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B4SGTFWCyMoGN5wTWwgvIphpl6nsGoQQ9CuT6aMwney8EcjQIaulfCdutxrrXiWND
 ZSimkbitjfJTXfsUEwz3W4zU5QixMq+UekYisXNUp2HUne35M4C6xN6i6I43Et3kw2
 FSf5xcjLhr2+t2o+SCEH1w1or83hvpFEkvkGq6mmexrXy2vNiHA7urXp/UpgvkZElU
 dxf8p51L2hcwttwwuKUPo4dvyox+AW1SSO8KpILSUmddKQtWGCavx2KLOSIFY2AGlX
 d8oUQlzzEtiVHPPFObwoSGbnB9/rL95MVGoD8tIKI9KWT1+Kf4wqTXJPCc68xQTOYS
 d0ZFM3QSSZ5nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/gem: Consider GEM object
 reclaimable if shrinking fails
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-357-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-357-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:59:16 +0000
Message-Id: <20260831155917.263E11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] msm_gem_shrinker_scan loses freed count by returning SHRINK_STOP w=
hen remaining is 0.
- [High] drm_gem_lru_scan fails to account for unscanned objects in the rem=
aining counter, causing catastrophic early aborts.
--

commit 9ce73904f0ad62a66be5eff7808ac4a6af7edc46
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/gem: Consider GEM object reclaimable if shrinking fails

If the object wasn't moved to a different LRU after the shrink callback
returns, it means the buffer is still reclaimable. Update the remaining
counter to reflect that.

Link: https://patch.msgid.link/20260401134854.2275433-2-boris.brezillon@col=
labora.com

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index f884d155a832a..6e778939acae4 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1574,6 +1574,16 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>  			 */
>  			WARN_ON(obj->lru =3D=3D &still_in_lru);
>  			WARN_ON(obj->lru =3D=3D lru);
> +		} else if (obj->lru =3D=3D &still_in_lru) {
> +			/*
> +			 * If the object wasn't moved and wasn't shrunk either,
> +			 * it's still remaining as reclaimable. Note that
> +			 * obj->lru is supposed to be checked with the LRU lock
> +			 * held for an accurate result, but we don't care about
> +			 * accuracy here. Worst thing that could happen is an
> +			 * extra scan.
> +			 */
> +			*remaining +=3D obj->size >> PAGE_SHIFT;

[Severity: High]
This isn't a bug introduced by this patch, but does this manual accumulation
fully fix the remaining counter?

In drivers/gpu/drm/drm_gem.c:drm_gem_lru_scan(), when the shrinker
successfully frees enough objects to satisfy nr_to_scan, the loop
terminates early:

	while (freed < nr_to_scan) {
		...
	}

The objects still left in lru->list are never scanned, and their sizes are
not added to *remaining. If no objects failed to shrink before the loop
terminated, *remaining stays 0.

This missing count triggers a severe pre-existing issue in=20
drivers/gpu/drm/msm/msm_gem_shrinker.c:msm_gem_shrinker_scan():

	return (freed > 0 && remaining > 0) ? freed : SHRINK_STOP;

When remaining is incorrectly 0, this logic swallows the freed count by
returning SHRINK_STOP. The core VM shrinker then drops the count of freed
pages, causing under-reporting of reclaimed memory which can mislead
kswapd and trigger premature OOM.

Should lru->count + still_in_lru.count be added to *remaining before return=
ing
from drm_gem_lru_scan(), rather than manually accumulating sizes inside the
loop?

>  		}
> =20
>  		dma_resv_unlock(obj->resv);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-357-sashal@kernel.org?part=3D1
