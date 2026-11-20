Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C023606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nd0MW7AQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E713710E566;
	Fri, 20 Nov 2026 09:14:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52DF10E566;
 Fri, 20 Nov 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795166038; x=1826702038;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=6u1JnrIesR1G82fQF15PMeN+1EsD+TC0aLsY9JIn0+s=;
 b=Nd0MW7AQsfa3AfQal/WdknjjAkhzabosf8HowCzGTOjv8FUpTi0CSmhG
 oyfjN/ldiLHXOpqYngdL4hWrWImavSJZER10rgH6/IszMYYQkZpMEAXzG
 +ZyaU/cfYuirGvMjNT1QTFLrsC8eZkmHJNONCwOg93KU9wbn3olx8bVTw
 7puJweIWqpqKcKehXxlnvRR7/rou+LqzGUwfxTn83DEo4eD9vjJBNPTCd
 +peNfgvaSa5ouqfwyRQXBYEgkQAOiUfw72zScbEc8Uvm9zvXuXljVZhuk
 fvVkHjHLx3fmoEGytsyykZy2STOjMBHATnQ4nYPFiW5/XOUWxJf4cWaIg Q==;
X-CSE-ConnectionGUID: bcvwJJo7T3eGrwaod/O2FA==
X-CSE-MsgGUID: 9BcnzIifSRegcBXTMhX51Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4048896"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4048896"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 01:13:58 -0800
X-CSE-ConnectionGUID: BMiW046+RbqUuFRgouMGPQ==
X-CSE-MsgGUID: 0CUbDhZHTeihwFq+Or78jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="11088863"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.250])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 01:13:53 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ian Rogers <irogers@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>, Ian Rogers
 <irogers@google.com>, Mika Kahola <mika.kahola@intel.com>
Subject: Re: [PATCH] drm/i915/display: Pass crtc->pipe to
 intel_pmdemand_update_port_clock()
In-Reply-To: <20261119170642.1521198-1-irogers@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261119170642.1521198-1-irogers@google.com>
Date: Fri, 20 Nov 2026 11:13:51 +0200
Message-ID: <bc01cd57f349fa647fb0e38bfbbcba108ff8289e@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, 19 Nov 2026, Ian Rogers <irogers@google.com> wrote:
> In intel_modeset_readout_hw_state(), 'pipe' is only populated inside the
> earlier for_each_intel_encoder() loop. Later, inside
> for_each_intel_crtc(), intel_pmdemand_update_port_clock() is called with
> 'pipe' instead of 'crtc->pipe'.
>
> When the encoder list is empty (for example on headless SKUs or VBT
> configurations with all display outputs disabled), 'pipe' is completely
> uninitialized and indexes out-of-bounds into pmdemand_state->ddi_clocks[].
> Even when encoders are present, every CRTC iteration overwrites the slot
> for the last encoder's pipe rather than updating crtc->pipe.
>
> Scope 'pipe' locally to for_each_intel_encoder() and pass crtc->pipe to
> intel_pmdemand_update_port_clock().
>
> Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
> -Wconditional-uninitialized enabled; fix and changelog drafted with an AI
> coding assistant. Build-tested for both i915 and xe under LLVM=1 W=1
> (-Werror) and -Wconditional-uninitialized; not runtime-tested on Intel
> Xe_LPD+ hardware.
>
> Fixes: 4c4cc7ac207f ("drm/i915/mtl: Add support for PM DEMAND")
> Signed-off-by: Ian Rogers <irogers@google.com>

Cc: <stable@vger.kernel.org> # v6.5+
Cc: Mika Kahola <mika.kahola@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_modeset_setup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> index 6aed88173770..e5d7c05e006a 100644
> --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> @@ -695,7 +695,6 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
>  {
>  	struct intel_pmdemand_state *pmdemand_state =
>  		to_intel_pmdemand_state(display->pmdemand.obj.state);
> -	enum pipe pipe;
>  	struct intel_crtc *crtc;
>  	struct intel_encoder *encoder;
>  	struct intel_connector *connector;
> @@ -726,8 +725,7 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
>  
>  	for_each_intel_encoder(display->drm, encoder) {
>  		struct intel_crtc_state *crtc_state = NULL;
> -
> -		pipe = 0;
> +		enum pipe pipe = PIPE_A;
>  
>  		if (encoder->get_hw_state(encoder, &pipe)) {
>  			crtc = intel_crtc_for_pipe(display, pipe);
> @@ -869,7 +867,8 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
>  		drm_dbg_kms(display->drm, "[CRTC:%d:%s] min_cdclk %d kHz\n",
>  			    crtc->base.base.id, crtc->base.name, crtc_state->min_cdclk);
>  
> -		intel_pmdemand_update_port_clock(display, pmdemand_state, pipe,
> +		intel_pmdemand_update_port_clock(display, pmdemand_state,
> +						 crtc->pipe,
>  						 crtc_state->port_clock);
>  	}

-- 
Jani Nikula, Intel
