Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD50C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEBC10F370;
	Tue, 15 Sep 2026 08:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K6jBLJcB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8389910F36A;
 Tue, 15 Sep 2026 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789461613; x=1820997613;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=jFjveW8PB+QZMNIKa9P54Bs9pN+9LGE8+b6VWPfMmqo=;
 b=K6jBLJcBbco5kTw4XjNtNrthut4rE7i/l+lgX7ctrM4gyLKT/GZrbLd9
 gZ5s+GrcMVLe3ZuN7PQ0TYbl24/jQxLwcvlwbcM7ImbxJYlbgnv3QYYdd
 PQuc0LdV6ftFQ+BDu98J9AhQdlpp+7EQjR45nQW2L9Hlb29wQW0bLHXU+
 OVTegrXROVnHEuTthPQ6wOAvYOH/JSWXH8Amf4tI3/1PCKWW8YhPMjMZF
 tU1qKuG40xJw/ldG/9kAH/ix2iXq8F1Y9MAzEuqBst+k5F/HapFMD9HdM
 aRKDBSUh4hn4G2SdGvKm+oL9pY1W4r5Qea4saqwi6tisGFAJcYbc5VNpR w==;
X-CSE-ConnectionGUID: dJnAsFggRP6B7eYYuOquIg==
X-CSE-MsgGUID: NRg2LzIyTz+4LNWl8lSumw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89832897"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89832897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:40:13 -0700
X-CSE-ConnectionGUID: ET3mCVQ4QXapkN+A4YO/IQ==
X-CSE-MsgGUID: GaHvSp/KQeKSqK07P2kT6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="274838912"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.243])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 01:40:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andrew Zhou <zhoulol888@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andrew Zhou <zhoulol888@gmail.com>,
 ville.syrjala@linux.intel.com, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Matthew Brost
 <matthew.brost@intel.com>
Subject: Re: [PATCH v2] drm/xe/display: Remove invalid initial plane PTE
 check for iGPU
In-Reply-To: <20260915064200.23171-1-zhoulol888@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260905142500.17666-1-zhoulol888@gmail.com>
 <20260915064200.23171-1-zhoulol888@gmail.com>
Date: Tue, 15 Sep 2026 11:40:08 +0300
Message-ID: <69d0f3f3566521e516e439e818a619766561567c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 15 Sep 2026, Andrew Zhou <zhoulol888@gmail.com> wrote:
> Pantherlake integrated graphics can have the XE_GGTT_PTEDM bit set in
> the BIOS-initialised framebuffer PTE. The validation rejects this and
> fails to create the initial framebuffer, resulting in static.
>
> Remove the too-strict validation. Since this was the only caller of
> need_pte_local() outside the DGFX path, the helper is now
> unconditionally true there; fold the check and drop the dead
> need_pte_local() and has_lmembar() helpers.
>
> Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
> Tested-by: Andrew Zhou <zhoulol888@gmail.com>
> Tested-on: Intel Core Ultra X7 358H, integrated graphics, B0 stepping

This is basically a revert of 0d5d5d0c2c72 ("drm/xe: Check the PTE local
memory bit for initial FB in stolen"). You'd do well to dig a bit of git
blame and see what changed, why, and by whom.

Cc: Ville, Maarten, Matthew


BR,
Jani.

> ---
> v1 -> v2:
> - Drop need_pte_local() and has_lmembar(), now dead after removing the
>   iGPU validation (sashiko)
> ---
>  drivers/gpu/drm/xe/display/xe_initial_plane.c | 20 +------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
> index 0f86b7303..3484b3033 100644
> --- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
> +++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
> @@ -27,16 +27,6 @@ static bool is_pte_local(u64 pte)
>  	return pte & XE_GGTT_PTE_DM;
>  }
>  
> -static bool has_lmembar(struct xe_device *xe)
> -{
> -	return GRAPHICS_VERx100(xe) >= 1270;
> -}
> -
> -static bool need_pte_local(struct xe_device *xe)
> -{
> -	return IS_DGFX(xe) || has_lmembar(xe);
> -}
> -
>  static struct xe_bo *
>  initial_plane_bo(struct xe_device *xe,
>  		 struct intel_initial_plane_config *plane_config)
> @@ -60,7 +50,7 @@ initial_plane_bo(struct xe_device *xe,
>  	if (IS_DGFX(xe)) {
>  		u64 pte = xe_ggtt_read_pte(tile0->mem.ggtt, base);
>  
> -		if (is_pte_local(pte) != need_pte_local(xe)) {
> +		if (!is_pte_local(pte)) {
>  			drm_err(&xe->drm, "Initial plane PTE has bad local memory bit\n");
>  			return NULL;
>  		}
> @@ -85,7 +75,6 @@ initial_plane_bo(struct xe_device *xe,
>  			    &phys_base);
>  	} else {
>  		struct ttm_resource_manager *stolen;
> -		u64 pte;
>  
>  		stolen = ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
>  		if (!stolen) {
> @@ -93,13 +82,6 @@ initial_plane_bo(struct xe_device *xe,
>  			return NULL;
>  		}
>  
> -		pte = xe_ggtt_read_pte(tile0->mem.ggtt, base);
> -
> -		if (is_pte_local(pte) != need_pte_local(xe)) {
> -			drm_err(&xe->drm, "Initial plane PTE has bad local memory bit\n");
> -			return NULL;
> -		}
> -
>  		phys_base = base;
>  		flags |= XE_BO_FLAG_STOLEN;

-- 
Jani Nikula, Intel
