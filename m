Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47B606A336
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FRs/uYCC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19A810F155;
	Thu,  5 Nov 2026 14:58:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC4B10F155;
 Thu,  5 Nov 2026 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793890725; x=1825426725;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wbKZFsLDsWJlK/KOM5Fab8+bmKrfik5VlS3uY6KYKRo=;
 b=FRs/uYCCeL0O3R5I8SDu7zHwkKmCdFeU2rynTmez4lo9T2+fII3x4zGa
 unO+OQLCZI0G0mNeKOXyEiTNVnbt63gnQx87SIIyvgCgIfi+EOROKhzC7
 MrP4YHl7HpuMzhemmU9ulj2SxHGYeC6oxfXnPIvz1fkzMeYiSfrRbf9zN
 VzjneAKvEZ+i/eR2H00xInZcCuv9KGVts9Ypp27iM4GhMnKPTws6kD588
 a5fYEIx0QkUS4ygmI/FpP6AFoEULH00xaIbqLXBuvpkM3xV/ppYIkJvie
 8Ej4VEXJCRPZaOPke72Z422z9smYXg9RZXifZnh7VVjbwKARIDe3urtdo A==;
X-CSE-ConnectionGUID: jPE/zyeYRBaVq6mYuQSCzg==
X-CSE-MsgGUID: aPZyGrKVSPe8ihMnRy/GRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2580397"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2580397"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:58:45 -0800
X-CSE-ConnectionGUID: e4BJZBi3RgmWLDISOTQFjw==
X-CSE-MsgGUID: tBTyXX1hTF2d9cXZT0ARdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7369312"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.198])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:58:42 -0800
Date: Thu, 5 Nov 2026 16:58:39 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: Hanson Wang <hanson.wang@ugreen.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/dsb: Fill all padding before GOSUB
Message-ID: <auyZnxZNyPcpjeYI@intel.com>
References: <20261105134658.3724628-1-hanson.wang@ugreen.com>
 <sashiko-outbox-199210@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-199210@kernel.org>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 02:12:40PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] drm/i915/dsb: intel_dsb_gosub_align() duplicates intel_dsb_align_tail()
> --
> 
> commit 9778ee8e90748be72ffe6e979a8d71a200d84540
> Author: Hanson Wang <hanson.wang@ugreen.com>
> 
> drm/i915/dsb: Fill all padding before GOSUB
> 
> This commit updates intel_dsb_gosub_align() to zero all bytes skipped when
> aligning free_pos to a cacheline boundary before emitting a GOSUB
> instruction, rather than only zeroing the gap when at most two QW slots
> remain.
> 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
> > index 299d778520a22..83aeb3fc89425 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dsb.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dsb.c
> > @@ -608,8 +608,13 @@ static void intel_dsb_gosub_align(struct intel_dsb *dsb)
> >  	/*
> >  	 * Wa_16024917128
> >  	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-7)"
> > +	 *
> > +	 * free_pos always advances to the next cacheline, so the skipped
> > +	 * bytes remain inside the programmed command range. Fill the whole
> > +	 * gap with NOPs; clearing only slots 6 and 7 leaves a larger gap
> > +	 * uninitialized.
> >  	 */
> > -	if (aligned_tail - tail <= 2 * 8)
> > +	if (aligned_tail > tail)
> >  		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
> >  
> >  	dsb->free_pos = aligned_tail / 4;
> 
> [Severity: Low]
> Wa_16024917128 states that GOSUB must not be placed in cacheline QW slot 6
> or 7 (where 0 < aligned_tail - tail <= 2 * 8). When tail is in QW slots 0
> through 5, GOSUB is allowed at that slot, and the trailing
> intel_dsb_align_tail(dsb) call at the end of intel_dsb_gosub() already pads
> the instructions following GOSUB within that cacheline with NOPs:
> 
> drivers/gpu/drm/i915/display/intel_dsb.c:intel_dsb_gosub() {
> 	...
> 	intel_dsb_gosub_align(dsb);
> 	...
> 	intel_dsb_emit(dsb, lower_32_bits(head_tail),
> 		       (DSB_OPCODE_GOSUB << DSB_OPCODE_SHIFT) |
> 		       upper_32_bits(head_tail));
> 
> 	/*
> 	 * "NOTE: the instructions within the cacheline
> 	 *  FOLLOWING the GOSUB instruction must be NOPs."
> 	 */
> 	intel_dsb_align_tail(dsb);
> }
> 
> In commit 2c41d62f6fb1, intel_dsb_gosub_align() checked
> if (aligned_tail - tail <= 2 * 8) to detect QW slots 6 and 7, but left
> dsb->free_pos = aligned_tail / 4 outside the conditional block, which caused
> free_pos to advance to the next cacheline without zeroing the skipped bytes
> when tail was in QW slots 1 through 5.
> 
> With this change to if (aligned_tail > tail), intel_dsb_gosub_align()
> becomes an exact duplicate of intel_dsb_align_tail() defined immediately
> above it:
> 
> static void intel_dsb_align_tail(struct intel_dsb *dsb)
> {
> 	u32 aligned_tail, tail;
> 
> 	intel_dsb_ins_align(dsb);
> 
> 	tail = dsb->free_pos * 4;
> 	aligned_tail = ALIGN(tail, CACHELINE_BYTES);
> 
> 	if (aligned_tail > tail)
> 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
> 
> 	dsb->free_pos = aligned_tail / 4;
> }
> 
> Should dsb->free_pos = aligned_tail / 4 instead be moved inside the
> if (aligned_tail - tail <= 2 * 8) block so that free_pos only advances to
> the next cacheline when GOSUB would land in QW slot 6 or 7, 

This ^. And please also adjust intel_dsb_align() the same way
so that the two functions will remain nearly identical.

> or if
> unconditional cacheline alignment before GOSUB is intended, should
> intel_dsb_gosub() call intel_dsb_align_tail() directly instead of
> duplicating it?

-- 
Ville Syrjälä
Intel
