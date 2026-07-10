Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BEAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0C010F9A1;
	Fri, 10 Jul 2026 22:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fbD/R5Um";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EB010F9A1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:27:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51C6360051;
 Fri, 10 Jul 2026 22:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B63C1F000E9;
 Fri, 10 Jul 2026 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722474;
 bh=XAfYz4BhzGHaDMUpv73K2B+cLZqlY8nuLX+xxBz8oRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fbD/R5UmXn1JKub0edRUkJ9Oq5uppX8udyadE6qu6C1JVjQoGPL6hnRpM4REl8XFV
 FccLR8pthy3ft4KDyrDJJV1a1gCBaubDAadE567qNDNRSn8+OZ2fLqTmjD/Dhh+2OW
 /N5NsYI6E3+a1q8EWcuCRkKGxuQV2KqVDgV5076a7aokW3q3C4qqyCkxxjZ3gXarqj
 ccQQtWgPQIRMKR86GQKpwnMLSFpsiU4GncuUyjfmKoQo3lWv6cwyZ2turqHR/dyDsr
 /umVk/I85CQB5wSMd8IDj6yv8DMHWDDV7gdq23Rt9KXWYunDu7xbpcqVLBoTpYIWm6
 GjHTZMDcjFK7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 29/33] drm/xe: Add per-device dependency scheduler
 for IOVA defrag finalize
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-30-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-30-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:27:52 +0000
Message-Id: <20260710222753.1B63C1F000E9@smtp.kernel.org>
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
- [High] If `xe_dep_scheduler_create()` fails, `xe_bo_defrag_init()` return=
s early and skips registering the `xe_bo_defrag_fini()` devm action. This l=
eaves the `xe->mem.defrag.worker` active, which can result in a use-after-f=
ree when the device struct is freed on probe failure.
--

--- Patch [29]: [PATCH v2 29/33] drm/xe: Add per-device dependency schedule=
r for IOVA defrag finalize ---
commit 5ebeeff5cf94ad2658593973ac47acd35100efa7
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Add per-device dependency scheduler for IOVA defrag finali=
ze

This patch adds a per-device xe_dep_scheduler dedicated to IOVA defrag
finalize jobs. It initializes this scheduler in xe_bo_defrag_init() and
cleans it up in xe_bo_defrag_fini().

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index f3d76ad9a1050..ec034518e2eae 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -1336,6 +1341,16 @@ void xe_bo_defrag_init_early(struct xe_device *xe)
>   */
>  int xe_bo_defrag_init(struct xe_device *xe)
>  {
> +#define XE_BO_MAX_IOVA_DEFRAG_JOBS	16	/* Picking a reasonable value */
> +	struct xe_dep_scheduler *iova_sched;
> +
> +	iova_sched =3D xe_dep_scheduler_create(xe, NULL, "xe_iova_defrag",
> +					     XE_BO_MAX_IOVA_DEFRAG_JOBS);
> +	if (IS_ERR(iova_sched))
> +		return PTR_ERR(iova_sched);

[Severity: High]
If xe_dep_scheduler_create() fails, returning early here skips the
registration of the xe_bo_defrag_fini() devm action below.

Does this leave the xe->mem.defrag.worker active on this probe error path?
If the worker was already queued during earlier device initialization, it
appears this could result in a use-after-free when the timer fires and the
worker accesses the freed xe_device structure.

> +	xe->mem.defrag.iova_sched =3D iova_sched;
> +#undef XE_BO_MAX_IOVA_DEFRAG_JOBS
> +
>  	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D29
