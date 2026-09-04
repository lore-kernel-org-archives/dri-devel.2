Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61607C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833DA10FAFB;
	Fri,  4 Sep 2026 12:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qd/LpseC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719E510FB07;
 Fri,  4 Sep 2026 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788523946; x=1820059946;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=E0lA48alQOV5DAKA7Dgq2IQfX7er/sDPIkAEhYWbWv8=;
 b=Qd/LpseC4CjENPCvNkb2JT6TRx9459y5B7+LQPZm1LZySSkiicgUD9m0
 ehi7gSx5vUCiHNrKneJXMIrMzXvImVbL8PvHaxNSljNC11kIerj1VqPFb
 OXgSBRYzcjngjXsYQa8MSyjgobXgjcx/BPCNtZdzu3bYWd1D+v8wPi+qQ
 zHYslxuA/CA3+Kwtx86ESEEYcbmPM1FZPi2564rqgyHgoAdVTzsWFIYMB
 DwQiiSS1QsCyZwRLAV7YHVAMxNkGBx1kk7lB2v9lf6g9H2vRN108u6c2c
 0/AFPp+WwOxbKAI3sX5DCg2zCiUGJyCOg2nORK/yWow9kcF9b9hkMNU4e g==;
X-CSE-ConnectionGUID: lg4lDsEsRZa6yHJf2rzZuw==
X-CSE-MsgGUID: j9q6wvNvQ2aCDJBNQbLZIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89045895"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="89045895"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:12:25 -0700
X-CSE-ConnectionGUID: 0KqlmyJER52VyyqMz2M5IQ==
X-CSE-MsgGUID: 7VeoqBnlQHmQVZBbtIer/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="269491621"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.29])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:12:22 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Zhenyu Wang <zhenyuw.linux@gmail.com>,
 Zhi Wang <zhi.wang.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/i915: fix repeated words in comments
In-Reply-To: <20260904120225.15868-3-hemanth.selam@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260904120225.15868-1-hemanth.selam@gmail.com>
 <20260904120225.15868-3-hemanth.selam@gmail.com>
Date: Fri, 04 Sep 2026 15:12:19 +0300
Message-ID: <4e651b9a124c47f5cbd07aee56f683c22252f172@intel.com>
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

On Fri, 04 Sep 2026, Hemanth Selam <hemanth.selam@gmail.com> wrote:
> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context_types.h | 2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc.c            | 2 +-
>  drivers/gpu/drm/i915/gvt/scheduler.c              | 2 +-
>  drivers/gpu/drm/i915/i915_gem_evict.c             | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> index 0267c924634b..2c1f81d9c0d7 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
> @@ -208,7 +208,7 @@ struct i915_gem_proto_context {
>  	/** @legacy_rcs_sseu: Client-set SSEU parameters for the legacy RCS */
>  	struct intel_sseu legacy_rcs_sseu;
>  
> -	/** @single_timeline: See See &i915_gem_context.syncobj */
> +	/** @single_timeline: See &i915_gem_context.syncobj */
>  	bool single_timeline;
>  
>  	/** @uses_protected_content: See &i915_gem_context.uses_protected_content */
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
> index 1c2764440323..c007faa54f2d 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
> @@ -769,7 +769,7 @@ int intel_guc_resume(struct intel_guc *guc)
>   * This is a wrapper to create an object for use with the GuC. In order to
>   * use it inside the GuC, an object needs to be pinned lifetime, so we allocate
>   * both some backing storage and a range inside the Global GTT. We must pin
> - * it in the GGTT somewhere other than than [0, GUC ggtt_pin_bias) because that
> + * it in the GGTT somewhere other than [0, GUC ggtt_pin_bias) because that
>   * range is reserved inside GuC.
>   *
>   * Return:	A i915_vma if successful, otherwise an ERR_PTR.
> diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
> index 15fdd514ca83..3c3c9b695487 100644
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@ -201,7 +201,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
>  			workload->ring_context_gpa);
>  
>  	/* only need to ensure this context is not pinned/unpinned during the
> -	 * period from last submission to this this submission.
> +	 * period from last submission to this submission.
>  	 * Upon reaching this function, the currently submitted context is not
>  	 * supposed to get unpinned. If a misbehaving guest driver ever does
>  	 * this, it would corrupt itself.
> diff --git a/drivers/gpu/drm/i915/i915_gem_evict.c b/drivers/gpu/drm/i915/i915_gem_evict.c
> index c02ebd6900ae..11855d9a1210 100644
> --- a/drivers/gpu/drm/i915/i915_gem_evict.c
> +++ b/drivers/gpu/drm/i915/i915_gem_evict.c
> @@ -273,7 +273,7 @@ i915_gem_evict_something(struct i915_address_space *vm,
>  	goto search_again;
>  
>  found:
> -	/* drm_mm doesn't allow any other other operations while
> +	/* drm_mm doesn't allow any other operations while
>  	 * scanning, therefore store to-be-evicted objects on a
>  	 * temporary list and take a reference for all before
>  	 * calling unbind (which may remove the active reference

-- 
Jani Nikula, Intel
