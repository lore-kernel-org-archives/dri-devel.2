Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE631C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE8210F231;
	Thu,  2 Jul 2026 08:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HNhqFxgq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6915B10F230;
 Thu,  2 Jul 2026 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782980862; x=1814516862;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=l9ruhvFSYqkoWruuhV72DO4aLyvjkW3Muv3iPgWyt44=;
 b=HNhqFxgqNYvRMIJ8dqY6ZXuFWzpP/J6HQfO14atFueimJJJP1MN3FETy
 N2kJrTsKdm1CWUHKr9zeJFY2pXKh9UFIQmPrIpZMshKEC1GlP61pGnxwg
 rSewGRPEqYfYAoOB+PECsDUeXJoB/WneSm6Tg/4oUxjQoW/NV1RX1Bbvd
 332SbDJE8JhWs70U79LafsLgQbHNFCnm+xXeOdQ4kXvSblHOnaW+hQ21r
 xBhVqX1pXdwRLMOw+5kr6906Ce6fF6gbehT9AZ0i1t3Qe0bRZxvlhKyCq
 RPnMOaxBtDNXRMGuZjt4hSBlyhF+pcUGErwkuCFddWYA4FBqAfA3IdJRW w==;
X-CSE-ConnectionGUID: k8Uil0PgRG+mebREIAELzg==
X-CSE-MsgGUID: cEJVPSc8SmC8V47rTiTe5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94083684"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="94083684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 01:27:42 -0700
X-CSE-ConnectionGUID: YME+UwnASW+PhAGsNCJCIA==
X-CSE-MsgGUID: 8+Ggm9/4T0iCxgSN2rCswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="257138064"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.209])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 01:27:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH 1/4] drm/i915/display: Make icl_dsi_frame_update use _fw
 too
In-Reply-To: <20260702080346.431508-2-dev@lankhorst.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260702080346.431508-1-dev@lankhorst.se>
 <20260702080346.431508-2-dev@lankhorst.se>
Date: Thu, 02 Jul 2026 11:27:37 +0300
Message-ID: <7d7cf653c4be0d88e69486e224c781bf4e73c730@intel.com>
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

On Thu, 02 Jul 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
> Don't use the dmc lock inside the vblank critical section,
> not even as last call.

The commit message should explain the why.

> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index ea0cdb7822f39..f1ccbc5efd6ea 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -242,8 +242,8 @@ void icl_dsi_frame_update(struct intel_crtc_state *crtc_state)
>  	else
>  		return;
>  
> -	intel_de_rmw(display, DSI_CMD_FRMCTL(port), 0,
> -		     DSI_FRAME_UPDATE_REQUEST);
> +	intel_de_rmw_fw(display, DSI_CMD_FRMCTL(port), 0,
> +			DSI_FRAME_UPDATE_REQUEST);
>  }
>  
>  static void dsi_program_swing_and_deemphasis(struct intel_encoder *encoder)

-- 
Jani Nikula, Intel
