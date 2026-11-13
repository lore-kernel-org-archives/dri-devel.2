Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAF606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LTAy6NSl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8881011264B;
	Fri, 13 Nov 2026 15:28:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA8C10E4BE;
 Fri, 13 Nov 2026 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794583693; x=1826119693;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7WrI4I1e6AA0i/3C39c8w4Prml7K97duiiPrHEPwGGk=;
 b=LTAy6NSlpgiw77Zs/fJ9+ZMb3loC4fZY/7cDwhDzmx5sd9UYnlV3/p00
 BDdz5ucC2Y8bzRyMbj3fe4vDmDZN7LWA/7hEkUJ+wcSs8wTT1QynvJbcS
 mUT7o+dHeDtExl9PZ/oelLaZSmhkvTvtKgI1BHQ36p3XkCo785o0VNfAU
 38dZwswUMFVU76v5QrhBRKdnO2lIxSgvASwlrqhayuoXbCtpx5Ny8WFLW
 9VbJlDSvbwtRHQwbrKC/OfSPY8Pa3u6d03HILTZKzIyAemzQ3gW3gBVKo
 tIHxmmFelUWONO8GEocDrJpZo0v0T2VQ06EDH0sULwKpXBFtQ1+JrSxZZ A==;
X-CSE-ConnectionGUID: cuuYJmdbTiaIDikeZUDLKA==
X-CSE-MsgGUID: UihUy3FNRJGe10AOf/kREg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3395678"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3395678"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:28:13 -0800
X-CSE-ConnectionGUID: S3qdHoYiQbCcBmAD1HnGKw==
X-CSE-MsgGUID: s7r55L+SR9a3/QHm3xhOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9492044"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:28:09 -0800
Date: Fri, 13 Nov 2026 17:28:06 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Animesh Manna <animesh.manna@intel.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7
Message-ID: <avcshtsLJ1_ugiaW@intel.com>
References: <20261105134658.3724628-1-hanson.wang@ugreen.com>
 <20261106102315.1361645-1-hanson.wang@ugreen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106102315.1361645-1-hanson.wang@ugreen.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 06:23:15PM +0800, Hanson Wang wrote:
> intel_dsb_gosub_align() moves free_pos to the next cacheline
> unconditionally, but only clears the skipped bytes when at most two
> QW slots remain. Wa_16024917128 forbids GOSUB in slots 6 and 7 only.
> A larger gap is still executed. A Panther Lake DSB dump showed
> nonzero data in that gap, with the tail at 0x58 and GOSUB at 0x80.
> 
> Advance free_pos only when the instruction would land in slot 6 or 7,
> and fill that gap with NOPs. Emit GOSUB in place for every other slot.
> intel_dsb_align_tail() still clears the rest of the cacheline.
> 
> Update free_pos inside the existing gap check in intel_dsb_align_tail()
> as well, so the two helpers keep the same shape.
> 
> Fixes: 2c41d62f6fb1 ("drm/i915/dsb: Implement intel_dsb_gosub()")
> Cc: stable@vger.kernel.org # v6.17+
> Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>

Thanks. Pushed to drm-intel-next.

> ---
> v2:
> - Advance free_pos only for QW slots 6 and 7, and NOP-fill that gap
>   (Ville)
> - Update free_pos inside the existing check in intel_dsb_align_tail()
>   so the two helpers stay in the same shape
> 
> Hardware: Intel Core Ultra 5 336H (Panther Lake), 6.18-based kernel
> Build:    6.18 backport; both xe and i915 intel_dsb.o
> Upstream: not built or booted
> Reboots:  7/100 DSB idle timeouts before either fix
>           v1 (always align): 0/200
>           v2 (this patch):   0/200
> 
>  drivers/gpu/drm/i915/display/intel_dsb.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
> index d9a270362a82..07d864039e82 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsb.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsb.c
> @@ -589,10 +589,10 @@ static void intel_dsb_align_tail(struct intel_dsb *dsb)
>  	tail = dsb->free_pos * 4;
>  	aligned_tail = ALIGN(tail, CACHELINE_BYTES);
>  
> -	if (aligned_tail > tail)
> +	if (aligned_tail > tail) {
>  		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
> -
> -	dsb->free_pos = aligned_tail / 4;
> +		dsb->free_pos = aligned_tail / 4;
> +	}
>  }
>  
>  static void intel_dsb_gosub_align(struct intel_dsb *dsb)
> @@ -607,11 +607,15 @@ static void intel_dsb_gosub_align(struct intel_dsb *dsb)
>  	/*
>  	 * Wa_16024917128
>  	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-7)"
> +	 *
> +	 * Move to the next cacheline only for those two slots. The skipped
> +	 * bytes stay in the programmed range, so fill them with NOPs. Any
> +	 * other slot can take the GOSUB directly.
>  	 */
> -	if (aligned_tail - tail <= 2 * 8)
> +	if (aligned_tail - tail <= 2 * 8) {
>  		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
> -
> -	dsb->free_pos = aligned_tail / 4;
> +		dsb->free_pos = aligned_tail / 4;
> +	}
>  }
>  
>  void intel_dsb_gosub(struct intel_dsb *dsb,
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
