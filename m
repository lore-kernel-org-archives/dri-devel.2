Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD88C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325D210E2C5;
	Sat, 11 Jul 2026 03:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XG4V5Dvx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4B310E2C5
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:21:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F7A5416EE;
 Sat, 11 Jul 2026 03:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2A1F000E9;
 Sat, 11 Jul 2026 03:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783740085;
 bh=YDzECF50kCqCVXfg0jQ/HE7Knz6JGScdZDWaZDQ1fVA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XG4V5Dvxaa7FYYbl4M3f1eXXzYz9YDkZcQ/yuDSutnjOAiSvzfEhSPYc7/seutkte
 VtAtksOp/YXCudh2bZP2gzvMILSDRbuc+3aPASzS5+y0rdnsv4lktq5EeqMATRp1K6
 mX+bh4jQYQ+20FVm1u+mPqubx8ptkIY1KEJJbIpUkm+Zs04ttKfTxo0w8H8FGP0nVH
 LWFVIhNe0mcUQ06vk1TrTzT+VWTs7li4uZYEhV8rynunBN2MGw0SZxnzn42I3hzqbQ
 ogr9gyFbB7k4qZ/bpAh3KqLE0nq1WMxij5XTvgNDqBpFkKIMc2mbQLZuNJ0ab3RVw1
 r0DgeCuJgp/Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/33] drm/xe: Handle defrag moves in xe_bo_move()
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-19-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-19-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:21:25 +0000
Message-Id: <20260711032125.C6F2A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Pipelined defrag move detaches VF CCS metadata before the GPU copy=
 completes, risking CCS metadata corruption on VF migration.
- [Medium] Using `ctx->defrag` to identify a defrag move incorrectly applie=
s defrag-specific VF CCS attach/detach logic to unrelated victim BOs evicte=
d during a defrag operation.

Pre-existing issues:
- [Critical] Returning an error from `xe_bo_move()` after successfully comm=
itting the move causes TTM to free the new resource, leaving `bo->resource`=
 as a dangling pointer.
--

--- Patch [18]: [PATCH v3 18/33] drm/xe: Handle defrag moves in xe_bo_move(=
) ---
commit 22e925edd18b0faf0ff581a79813091d539553b8
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Handle defrag moves in xe_bo_move()

This commit modifies xe_bo_move() to handle defragmentation moves, allowing
TTM to reallocate a BO's backing at an optimal order while copying existing
contents. It introduces a fast path for defrag moves via GPU relocation,
pipelines the teardown asynchronously, and extends VF CCS attach/detach
logic to cover defrag transitions.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 02395968d613b..bdcc9bed5d36b 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -1315,13 +1331,13 @@ static int xe_bo_move(struct ttm_buffer_object *t=
tm_bo, bool evict,
>  	 * BBs from BO as it is no longer needed.
>  	 */
>  	if (IS_VF_CCS_READY(xe) && old_mem_type =3D=3D XE_PL_TT &&
> -	    new_mem->mem_type =3D=3D XE_PL_SYSTEM)
> +	    (new_mem->mem_type =3D=3D XE_PL_SYSTEM || ctx->defrag))
>  		xe_sriov_vf_ccs_detach_bo(bo);

[Severity: High]
Does this code synchronously detach VF CCS metadata before the GPU copy
completes?

Since a defrag move is pipelined asynchronously (evict is false, so
ttm_bo_move_accel_cleanup() delegates to a ghost object without waiting for
the fence), xe_bo_move() immediately calls xe_sriov_vf_ccs_detach_bo(bo).

This synchronously clears the GuC CCS save/restore batch buffers for the
old TT. If a VF migration triggers while the async GPU copy job is still in
flight, the GuC won't save the old TT's CCS state because its batch buffers
were detached.

When the copy job resumes, can it copy uninitialized or garbage data from
the old hardware CCS region into the new TT, leading to CCS metadata
corruption?

>  	if (IS_VF_CCS_READY(xe) &&
>  	    ((move_lacks_source && new_mem->mem_type =3D=3D XE_PL_TT) ||
> -	     (old_mem_type =3D=3D XE_PL_SYSTEM && new_mem->mem_type =3D=3D XE_P=
L_TT)) &&
> -	    handle_system_ccs)
> +	     ((old_mem_type =3D=3D XE_PL_SYSTEM || ctx->defrag) &&
> +	      new_mem->mem_type =3D=3D XE_PL_TT)) && handle_system_ccs)
>  		ret =3D xe_sriov_vf_ccs_attach_bo(bo);

[Severity: Medium]
Does checking ctx->defrag instead of ttm_bo->defrag_old_tt misclassify
victim BOs?

TTM passes the original ttm_operation_ctx down to all evictions triggered
by an allocation, which means ctx->defrag is true for any victim BO evicted
during a defrag pass.

If unrelated BOs (such as those evicted from STOLEN to TT) have VF CCS
logic applied to them because ctx->defrag is true, will this modify their
hardware CCS tracking unexpectedly and break standard eviction flows?

[Severity: Critical]
This is a pre-existing issue, but returning an error from xe_bo_move()
after successfully committing the move causes TTM to free the new resource,
leaving bo->resource as a dangling pointer.

In xe_bo_move(), the move is successfully committed via
ttm_bo_move_accel_cleanup() which assigns the new resource to bo->resource.
If a subsequent operation like xe_sriov_vf_ccs_attach_bo(bo) fails (e.g.
returns -ENOMEM), xe_bo_move() propagates this error back to TTM.

TTM's error recovery in ttm_bo_validate() then unconditionally calls
ttm_resource_free(bo, &res) for the new allocation. Since bo->resource
already points to this new allocation, does this free the memory while
leaving bo->resource as a dangling pointer, creating a use-after-free risk?

> =20
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D18
