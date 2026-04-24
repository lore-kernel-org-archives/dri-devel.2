Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920B9FED3CF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB6010E3B4;
	Fri, 24 Apr 2026 14:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G5Prosa2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9EB10E3B4
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777039998; x=1808575998;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=y5xWrYfVQJGD1c2gpGmxsIdJlpuZuKi2LVj4vQlZ1vg=;
 b=G5Prosa2QF1SNoaP7BHCwtNeRqcTHbsg5Aj5bG9doxbAF1IblN/m1oaI
 3IX/ZwUmwFGO4bHxl0eU/lAoU2y2WxTrptFDfS24eR4HQ1I38OSDNSjtn
 qlyfRJntFJzcxY1tEvzgod19e475y8f7payIn0+5/MnszJnaJ11FeIvSE
 sTnzxVm/dfq+HLoEEgZsVVhDGlBKLDmSOWZ0IHf9n0f6vuqBmccLZCUHL
 5qb4IihHcB7iCAsNKYGzBMsV4BU0pWwrYgMXnpC4DGPYqd0tWrwwrVSOP
 7/hFlupzOE2ZpyXQ73g7FvuZS8JrW/Mb7PvZh8TShu2N+fjrg+t4GbIn9 g==;
X-CSE-ConnectionGUID: DT8lLctHS/+hV9u007yDPg==
X-CSE-MsgGUID: soidyz5mRByuQhVZcIdg8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89404187"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="89404187"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 07:13:17 -0700
X-CSE-ConnectionGUID: OPVmvdFdQBysKWD+deWhVg==
X-CSE-MsgGUID: FaMhVWedT+C/YuLkKYmTow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="230318504"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.89])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 07:13:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha
 <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Laurent
 Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 07/28] drm/bridge: Implement atomic_print_state
In-Reply-To: <20260423-drm-state-readout-v2-7-8549f87cb978@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
 <20260423-drm-state-readout-v2-7-8549f87cb978@kernel.org>
Date: Fri, 24 Apr 2026 17:13:10 +0300
Message-ID: <aa1ede131e4e3e8e98c684a4f1eeaf2cc8438a4c@intel.com>
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

On Thu, 23 Apr 2026, Maxime Ripard <mripard@kernel.org> wrote:
> Bridges have some fields in their state worth printing, but we don't
> provide an atomic_print_state implementation to show those fields.
>
> Provide one.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 5b8e171afbe5..fba440bddcb3 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -506,14 +506,35 @@ drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
>  		return ERR_CAST(state);
>  
>  	return &state->base;
>  }
>  
> +static void
> +drm_bridge_atomic_print_priv_state(struct drm_printer *p,
> +				   const struct drm_private_state *s)
> +{
> +	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
> +	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
> +
> +	if (bridge->of_node)
> +		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
> +	else
> +		drm_printf(p, "bridge: %ps\n", bridge->funcs);
> +
> +	drm_printf(p, "\tinput bus configuration:");
> +	drm_printf(p, "\t\tcode: %04x", state->input_bus_cfg.format);
> +	drm_printf(p, "\t\tflags: %08x", state->input_bus_cfg.flags);
> +	drm_printf(p, "\toutput bus configuration:");
> +	drm_printf(p, "\t\tcode: %04x", state->output_bus_cfg.format);
> +	drm_printf(p, "\t\tflags: %08x", state->output_bus_cfg.flags);

Nitpick, please see drm_printf_indent(). Not having the \t's in the
format strings makes them easier on the eyes.

BR,
Jani.

> +}
> +
>  static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
>  	.atomic_create_state = drm_bridge_atomic_create_priv_state,
>  	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
>  	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
> +	.atomic_print_state = drm_bridge_atomic_print_priv_state,
>  };
>  
>  /**
>   * drm_private_obj_is_bridge - check if a private object backs a bridge
>   * @obj: private object to check

-- 
Jani Nikula, Intel
