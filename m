Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E66C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAFE10F9F4;
	Fri, 25 Sep 2026 10:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kp6UKKd3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AD010F9F1;
 Fri, 25 Sep 2026 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790333497; x=1821869497;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=WAW0S/Brrg83EOdfEMItMeNz6SXm46WLO8vmwxxMgIQ=;
 b=kp6UKKd3Iui8JvBupgDknbZnOAhEDjQkTiW71quKa4k7OGUEGaCkUwRY
 msjBS4ZwkCbnAH4nJeFUNRKWttrdd0VwNhTMBgQYq9ur4P5fxrnj/OjLK
 abdL0Z3ssAUlBrw1+ciKG/i4TRb9ovVA9YgyrkKg2BtYvUsQlKofhWwI7
 1OX5AlUx7keWv0N4jnDueZ+Lw+XvmF6B1JFXdz5FMOIxTRYjz7xulJr5D
 eV+wZ521V4NaeUy0T0aaDWnKgZv/aiyujoPzoK6WUgn81uzUivLsrhpJy
 V4fV1NbFsgDKJwe7JMOnQnuocWuPwFwyBmU2YO7cOTtDMt6FOT8lqohvZ g==;
X-CSE-ConnectionGUID: UoAtCeVeRISnCFOGA9/9rw==
X-CSE-MsgGUID: 5EaGFkDWS96OROINzuPCLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116645622"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="116645622"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:51:37 -0700
X-CSE-ConnectionGUID: JFZ9nu+7RNy2DCJ5+nXOrg==
X-CSE-MsgGUID: 4EYoVE1aQy+U9zAW0BlkNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273397540"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:51:35 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: Re: [PATCH v4 7/7] drm/i915/selftests: Use i915_* prints in
 i915_selftest.c
In-Reply-To: <20260924120147.1305127-8-krzysztof.karas@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
 <20260924120147.1305127-8-krzysztof.karas@intel.com>
Date: Fri, 25 Sep 2026 13:51:32 +0300
Message-ID: <50d3e5960b31018d569a4cbb15cd7e5b3858606d@intel.com>
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

On Thu, 24 Sep 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> Move away from generic pr prints to drm device context aware
> i915_* versions.

So I think moving away from pr_* to drm_* logging is fine, and there's a
limited amount of that.

But the i915_* macros just open the door to an insane amount of churn
converting drm_* to i915_* everywhere in a driver that's essentially in
maintenance mode now, for no real benefit to anyone.

BR,
Jani.

>
> Assisted-by: GitHub-Copilot:claude-opus-5
> Assisted-by: GitHub-Copilot:claude-sonnet-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v4:
> - renamed from "Use drm_* prints in selftest headers" (the title
>   did not match the change) and switched to the new i915_*
>   prints instead of drm_*;
>
>  drivers/gpu/drm/i915/selftests/i915_selftest.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
> index 3adcfdab75ae..4e2566189879 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
> @@ -23,6 +23,8 @@
>  
>  #include <linux/random.h>
>  
> +#include "i915_printk.h"
> +
>  #include "gt/intel_gt.h"
>  #include "gt/intel_gt_pm.h"
>  #include "gt/intel_gt_regs.h"
> @@ -47,7 +49,7 @@ int i915_mock_sanitycheck(void)
>  
>  int i915_live_sanitycheck(struct drm_i915_private *i915)
>  {
> -	pr_info("%s: %s() - ok!\n", i915->drm.driver->name, __func__);
> +	i915_info(i915, "%s() - ok!\n", __func__);
>  	return 0;
>  }
>  
> @@ -154,7 +156,7 @@ __wait_gsc_proxy_completed(struct drm_i915_private *i915)
>  
>  	if (need_to_wait && wait_for(!__gsc_proxy_init_progressing(&i915->media_gt->uc.gsc),
>  				     timeout_ms))
> -		pr_warn(DRIVER_NAME "Timed out waiting for gsc_proxy_completion!\n");
> +		i915_warn(i915, "Timed out waiting for gsc_proxy_completion!\n");
>  }
>  
>  static void
> @@ -178,7 +180,7 @@ __wait_gsc_huc_load_completed(struct drm_i915_private *i915)
>  
>  	if (need_to_wait &&
>  	    wait_for(i915_sw_fence_done(&huc->delayed_load.fence), timeout_ms))
> -		pr_warn(DRIVER_NAME "Timed out waiting for huc load via GSC!\n");
> +		i915_warn(i915, "Timed out waiting for huc load via GSC!\n");
>  }
>  
>  static struct mm_struct *get_selftest_mm(int u_pid_nr)

-- 
Jani Nikula, Intel
