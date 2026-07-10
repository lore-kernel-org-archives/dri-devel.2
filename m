Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140E6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A5B10E23F;
	Fri, 10 Jul 2026 22:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mr9dHryJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A70210E23F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:25:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00C5860051;
 Fri, 10 Jul 2026 22:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7613F1F000E9;
 Fri, 10 Jul 2026 22:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722328;
 bh=0dwpkbCAHW81qLp/BN09lp1FkzE5Sl/arLrv4TDgeFA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mr9dHryJQHlqTTj16zIIknEstEXinNbs2320jfD3I7o95aoeSY5nk6VQWNmbTMMrp
 nc100rd/7BfZEQU0bbIiBzEpKZdi4AUkzGA/5aPPUzA/fpPtxWXdVhO2xUBMw6hYWw
 h5filvYCi7SLomRpgCuMGmJ+bLR0JcfKkb6txEd+wy+kjuwIH/l3SXDlY2s9ghBy/a
 iRSiBU7oLulc/lrco+urrtDr0TM2rcYl29LcOeia5F5awzpmAhYFdYPWV6ZD+4x2Wo
 zdqjgQ1tsjEXzz1sa0LYpIUPVJTbpY++69jf79AlvefDfRWgowfdz4ikOEsm4CBX1I
 0g16nd2qeraVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/33] drm/xe: Handle defrag moves in xe_bo_move()
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-19-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-19-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:25:27 +0000
Message-Id: <20260710222528.7613F1F000E9@smtp.kernel.org>
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
- [High] Returning an error from xe_bo_move() after the move has been succe=
ssfully committed causes a Use-After-Free of the new resource in TTM core.
- [High] Live migration during an asynchronous move causes silent loss of V=
F CCS metadata.
--

--- Patch [18]: [PATCH v2 18/33] drm/xe: Handle defrag moves in xe_bo_move(=
) ---
commit dad45636f401d271e91aa77826c4290b4048e3c7
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Handle defrag moves in xe_bo_move()

This commit adds support for defrag moves in xe_bo_move(). It allows TTM
to reallocate a buffer object's backing at a beneficial order and handles
the relocation entirely on the GPU via xe_migrate_copy_defrag().

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 21d087170ef36..8e9fc8b3dffaf 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c

[ ... ]

> @@ -1309,13 +1325,13 @@ static int xe_bo_move(struct ttm_buffer_object *t=
tm_bo, bool evict,
>  	 * BBs from BO as it is no longer needed.
>  	 */
>  	if (IS_VF_CCS_READY(xe) && old_mem_type =3D=3D XE_PL_TT &&
> -	    new_mem->mem_type =3D=3D XE_PL_SYSTEM)
> +	    (new_mem->mem_type =3D=3D XE_PL_SYSTEM || ctx->defrag))
>  		xe_sriov_vf_ccs_detach_bo(bo);

[Severity: High]
This isn't a bug introduced by this patch, but if a live migration is
triggered concurrently with a BO defragmentation or eviction, does this
synchronous CPU detachment cause a loss of CCS metadata?

Because xe_sriov_vf_ccs_detach_bo() and xe_sriov_vf_ccs_attach_bo() are
called synchronously on the CPU before the GPU has finished copying the dat=
a,
they immediately point the host to the new memory for CCS save and restore
operations.

If a live migration occurs before the GPU copy finishes, the host might save
uninitialized CCS data from the new memory, and fail to save the valid CCS
data from the old memory. Upon VM restore, the GPU migrate job resumes and
copies the corrupted old CCS to the new memory.

> =20
>  	if (IS_VF_CCS_READY(xe) &&
>  	    ((move_lacks_source && new_mem->mem_type =3D=3D XE_PL_TT) ||
> -	     (old_mem_type =3D=3D XE_PL_SYSTEM && new_mem->mem_type =3D=3D XE_P=
L_TT)) &&
> -	    handle_system_ccs)
> +	     ((old_mem_type =3D=3D XE_PL_SYSTEM || ctx->defrag) &&
> +	      new_mem->mem_type =3D=3D XE_PL_TT)) && handle_system_ccs)
>  		ret =3D xe_sriov_vf_ccs_attach_bo(bo);

[Severity: High]
This is a pre-existing issue, but can returning an error code here trigger
a use-after-free in the TTM core?

If xe_bo_move() commits the memory move earlier in the function by calling
ttm_bo_move_accel_cleanup() or ttm_bo_move_null(), new_mem is assigned to
bo->resource and the old memory is handed to a ghost object.

If xe_sriov_vf_ccs_attach_bo(bo) fails with an error like -ENOMEM, or if
any subsequent timeout wait fails, the error code is returned to the TTM
core.

The TTM core assumes a failed move means the new resource was not adopted:

ttm_bo_validate()
  ttm_bo_handle_move_mem()
    ret =3D ttm_bo_move()
    if (ret) {
        ...
        ttm_resource_free(bo, &res);
    }

Since bo->resource already points to the new resource, would this leave
bo->resource pointing to freed memory?

> =20
>  out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D18
