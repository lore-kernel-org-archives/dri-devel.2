Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F2C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22C210F99F;
	Fri, 10 Jul 2026 22:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MuuQ13my";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2159C10F99F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:27:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB31140736;
 Fri, 10 Jul 2026 22:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E4F1F000E9;
 Fri, 10 Jul 2026 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722451;
 bh=fa+R3ve0hY2rQpi7cI2ENjCajAxG6wsVxRqTw1hot2E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MuuQ13myrUBJSa5DgCiQY9YatoF+RWQs44m/Do83hLCyyvMUOuDPV+UkSfvRuoD7Q
 IbQ346RGBrHyHUN6Xp8zsKYZEKauQBlXzwukVyZUmD608sEnsWtRkpsEeKMi4k/URC
 K2vmk568gnpShVY3+47YJIsFdElBhjGuCBsxOSIXQbyDtzBsi4rs9W+YBkC9nRWsi+
 VDR+1vVYeU64gKbU0hXLTPKm589cjCkQgUIXaP3GYS8JsChfyIhDOMWhjW46leiXny
 mIZ7DlOs/NDv0pzy4pPSBLLc1BXlLsOWDuTMiXgsD5nJkPqr35Vd21nttQEzQtn2tr
 VCYg42EXJ6SYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/33] drm/xe: Defrag using out-of-lock page
 preallocation
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-24-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-24-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:27:31 +0000
Message-Id: <20260710222731.81E4F1F000E9@smtp.kernel.org>
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

New issues:
- [Low] 64-bit division using the '/' operator causes a link-time build fai=
lure on 32-bit architectures (missing __udivdi3).

Pre-existing issues:
- [High] Accessing `bo->ttm.ttm` without holding the BO's dma-resv lock can=
 lead to a NULL pointer dereference or UAF if the BO is concurrently evicte=
d or destroyed.
--

--- Patch [23]: [PATCH v2 23/33] drm/xe: Defrag using out-of-lock page prea=
llocation ---
commit d11ab210d871e5fedb57edb2f956ed1814f6d5a4
Author: Matthew Brost <matthew.brost@intel.com>
Date:   Fri Jul 10 21:54:32 2026 +0000

    drm/xe: Defrag using out-of-lock page preallocation
   =20
    Convert xe_bo_defrag_one() to a three-phase scheme that moves the
    expensive beneficial-order allocations out of the BO dma-resv lock.
    This hoists allocation and caching out to reduce BO-lock held time.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 405316d0d116b..2f014fc9f988e 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -1249,15 +1249,55 @@ static int xe_bo_defrag_one(struct xe_device *xe,=
 struct xe_bo *bo,

[ ... ]

> +	if (order && ttm_bo->ttm) {
> +		u32 suboptimal =3D ttm_tt_suboptimal_pages(ttm_bo->ttm);
> +		u64 cap =3D min_t(u64, budget, xe_bo_size(bo)) >> PAGE_SHIFT;
> +
> +		/* Prealloc only the beneficial-order chunks the move replaces. */
> +		want =3D DIV_ROUND_UP(min_t(u64, suboptimal, cap), 1UL << order);
                 ^^^^^^^^^^^^

[Severity: Low]
Does this code cause a link-time build failure on 32-bit architectures?

The first argument to DIV_ROUND_UP() is a u64, and the second evaluates
to an unsigned long (32-bit integer) and is not a compile-time constant.
This results in a 64-bit division using the '/' operator, which emits a
call to __udivdi3 on 32-bit GCC. Because the kernel doesn't provide this
intrinsic, it will break the build.

Could DIV_ROUND_UP_ULL() be used here instead?

> +	}
> +	xe_bo_unlock(bo);

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
xe_bo_defrag_worker() regarding how the BO is accessed after unlocking:

drivers/gpu/drm/xe/xe_bo.c:xe_bo_defrag_worker() {
	...
		ret =3D xe_bo_defrag_one(xe, bo, XE_BO_DEFRAG_SIZE_LIMIT - defrag_bytes,
				       &consumed);
		defrag_bytes +=3D consumed;

		if (ret || ttm_tt_is_beneficial_order_failed(bo->ttm.ttm)) {
	...
}

[Severity: High]
Can accessing bo->ttm.ttm here without holding the BO's dma-resv lock lead
to a NULL pointer dereference or use-after-free?

xe_bo_defrag_worker() calls xe_bo_defrag_one(), which acquires the BO lock,
performs the move, and then unlocks the BO before returning. After returnin=
g,
the worker evaluates ttm_tt_is_beneficial_order_failed(bo->ttm.ttm) without
holding the BO lock.

If another thread concurrently evicts the BO to VRAM, the system memory
ttm_tt is destroyed and bo->ttm.ttm is set to NULL. Additionally, if
xe_bo_defrag_one() finds the BO no longer needs defragmentation, it removes
it from the list and returns 0, and bo->ttm.ttm could also be NULL at this
point.

Should this check be performed while the BO lock is still held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D23
