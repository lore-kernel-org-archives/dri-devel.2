Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956D9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0127A10E716;
	Sat, 11 Jul 2026 03:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QEEyClGq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922DD10E716
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:21:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16968600C3;
 Sat, 11 Jul 2026 03:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FD31F000E9;
 Sat, 11 Jul 2026 03:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783740063;
 bh=rYB4ZFzK306PwQ7JoW8K6xL/61MKI1H0sg4oASK4vUY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QEEyClGqO3rdpbbfTR7Te9RepVbwNnvUxX5D5tSHJPnEF561KM5F5mwMr3+A1NNja
 J96XI7VARMHx6iYUxnDoYWqJuVNsS0dnnZwzsWzKMo6OUag6IlcMCDz0hpWKow5si7
 78J5rwVOv3RvEirO6G2Xkk84rbCXOM1nsuATCvRMspgzDrogErKCQFsYqDDkEoCIV3
 MmHdoMN7Mx4KFqv0hOmtmTdyQS0WbP+eM+YfP76v9FiuEtlptLN5KaudFyK8gwCX8n
 DS9xj8lqSzJB8xoBYIEY3pTBMbBDzcoP3UUU4de6Ka/iTrzVjpPAF11ay38wjAg8VW
 0WN35hExru+qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 29/33] drm/xe: Add per-device dependency scheduler
 for IOVA defrag finalize
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-30-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-30-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:21:03 +0000
Message-Id: <20260711032103.96FD31F000E9@smtp.kernel.org>
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
- [High] Early return on xe_dep_scheduler_create() failure skips registerin=
g the devm teardown action for the defrag worker, leading to a use-after-fr=
ee.
--

--- Patch [29]: [PATCH v3 29/33] drm/xe: Add per-device dependency schedule=
r for IOVA defrag finalize ---
commit 4091ca99808dbd61930846733ec6c77fcca46fe9
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add per-device dependency scheduler for IOVA defrag finalize

This commit adds a per-device dependency scheduler for IOVA defrag finalize
jobs, which tears down temporary copy mappings and links new backing memory.
The scheduler is created in xe_bo_defrag_init() and destroyed in
xe_bo_defrag_fini().

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index d54e69aefeba5..c5022c16411f6 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -1342,6 +1347,16 @@ void xe_bo_defrag_init_early(struct xe_device *xe)
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
If xe_dep_scheduler_create() fails and we return early, does this skip
registering the teardown action xe_bo_defrag_fini?

Since xe_bo_defrag_init_early() initializes the defrag delayed worker
earlier in device creation, could the worker already be armed via
schedule_delayed_work() if BOs hit sub-optimal page allocations during
other initializations?

If probe fails and devres unwinds, the xe_device struct is freed. Since
the early return bypasses devm_add_action_or_reset(), the worker is never
canceled. Could this lead to a use-after-free when the armed worker
eventually fires and dereferences the freed xe_device?

> +	xe->mem.defrag.iova_sched =3D iova_sched;
> +#undef XE_BO_MAX_IOVA_DEFRAG_JOBS
> +
>  	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D29
