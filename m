Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2370606A7CE
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NwtSlC4v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C33C10FCCB;
	Wed,  4 Nov 2026 15:18:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E8310FCE2;
 Wed,  4 Nov 2026 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793805498; x=1825341498;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=aZNTFXwM/wcgpwxafNC8PNs4ZQ3LDaLEX0ahb1iRUVk=;
 b=NwtSlC4vmxOB6wYHVp/ANm3dnQ7CnNRTIeybTw3lusJfceA3xaL8Atay
 turFrMgPXHg4ZR+Zv+u0npbfaZcam8a6QA4wQxXA88BEDUIdtnomDcABN
 PJ2VKpFYuDJxCC0nPKCnmYXWT/CF3LuGhXOJJkTalpQQxG7oxtXaCL65r
 bSHXEBYTscOqxoKnnYP7nA2NNgirYy4mhokLzHle3ief3a2XAvLDW/w+j
 R/wcKm6JghftXmWmdz2kOF/T7g5E9Fx7GLbvw6oLXFW6sdNyAIX+2IRpg
 l/jk+APxmqml1YO691Jgm7fp+WjdrLlT0hhunBKfQT0E9L2zktagWOwYv w==;
X-CSE-ConnectionGUID: sDtuiZY0RmeMU25RTagDGg==
X-CSE-MsgGUID: EUEGM45TT8egavMmcikYAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2577018"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2577018"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:18:12 -0800
X-CSE-ConnectionGUID: GQe38O66SFqTMGlAkUZJIA==
X-CSE-MsgGUID: o4n7ANsfRAuUtGmOVChJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6877305"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.86])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 07:18:09 -0800
Date: Wed, 4 Nov 2026 17:18:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
Message-ID: <autMrRaeVWRtBlMP@intel.com>
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
 <20261104073311.1617823-2-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104073311.1617823-2-lui2012qwq@gmail.com>
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

On Wed, Nov 04, 2026 at 03:33:10PM +0800, Chengyu Liu wrote:
> gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() into
> ppgtt->base.pd and, on failure, jumps to err_put with the ERR_PTR still
> in the field.  i915_vm_put() runs vm->cleanup = gen6_ppgtt_cleanup(),
> which calls gen6_ppgtt_free_pd(), where gen6_for_all_pdes() immediately
> dereferences pd - with an ERR_PTR that is an invalid dereference and a
> crash (in the async release worker).  The free_pd() right after is only
> guarded against NULL, not ERR_PTR.
> 
> Bail out of gen6_ppgtt_free_pd() for an invalid pd and skip free_pd()
> likewise, so an allocation failure under memory pressure stays a plain
> -ENOMEM instead of an oops.

The correct fix would be to not assign the error pointer
into ppgtt->base.pd in the first place.

Looks like a somwhat common bad pattern in this code that
received pointers are assigned directly into their final
location, and if the pointer is an error then the pointer is
cleared. IMO one should never do that because it's very easy
to forget the clearing part. Instead one should always use 
local variable first, and only assign the final pointer after
having checked that the pointer is valid.

> 
> Found by static analysis.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> index 438cd4724a..72a9ad4642 100644
> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> @@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
>  	struct i915_page_table *pt;
>  	u32 pde;
>  
> +	if (IS_ERR_OR_NULL(pd))
> +		return;
> +
>  	gen6_for_all_pdes(pt, pd, pde)
>  		if (pt)
>  			free_pt(&ppgtt->base.vm, pt);
> @@ -271,7 +274,7 @@ static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
>  	gen6_ppgtt_free_pd(ppgtt);
>  	free_scratch(vm);
>  
> -	if (ppgtt->base.pd)
> +	if (!IS_ERR_OR_NULL(ppgtt->base.pd))
>  		free_pd(&ppgtt->base.vm, ppgtt->base.pd);
>  
>  	mutex_destroy(&ppgtt->flush);
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
