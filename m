Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0732606A322
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QtlXh4HB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951BF10E7E7;
	Thu, 29 Oct 2026 12:04:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDD810E113;
 Thu, 29 Oct 2026 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793275443; x=1824811443;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=/oBe4m0YLZywxlXPUaO71KbtVZmDBPNp0Bo+RUOGUyA=;
 b=QtlXh4HBcZRMd6Hqk470+0P9ZUNkHdg289pJ5GghCQOXNal92q83XyUK
 abWMFXUBUDGO+yCIkw9ezuzNB0oyU3vm6APenpcBHZyf983TAW0e8Nphb
 sqSmoKUJUHGxXRfLd5ZXthaygjEaGbnC2IWG3BLIjlS5tNVCvLExVAuB/
 wxygBk2BbYZZNMcNpSdGpOPDaf2+2Uuz/kNT3xW82xGCZp0LeiqiF4GYI
 vPkXgrh874+naHdJoYnM8Nr672Qc/RYkPduuhHIkonEgOc7lzjQ6vuSaa
 sVeSFvwheoxOXvyNrJSRwHspcRQRIbKKdkJtyHOQCkt4PJ5yNnn8Shahz Q==;
X-CSE-ConnectionGUID: Djo5EHGrRJmsxMu+G/2z2A==
X-CSE-MsgGUID: x9sZBSNBRO6LUeEH61099Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1921908"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1921908"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 05:04:02 -0700
X-CSE-ConnectionGUID: o3cZccRnTY6iVlX7c2yjog==
X-CSE-MsgGUID: MwZM0ZfbRSO/mxbxVGNxYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5252995"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.145])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 05:03:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Maarten
 Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Patrik Jakobsson
 <patrik.r.jakobsson@gmail.com>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dmytro
 Malovanyi <dmitrymalovanyy@gmail.com>
Subject: Re: [PATCH v2 4/5] drm/gma500: Use drm_dp_enhanced_frame_cap()
In-Reply-To: <20261029101826.72773-5-dmitrymalovanyy@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
 <20261029101826.72773-5-dmitrymalovanyy@gmail.com>
Date: Thu, 29 Oct 2026 14:03:53 +0200
Message-ID: <ffac172bea7c82b9fddf8fa3949d62e9f62af497@intel.com>
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

On Thu, 29 Oct 2026, Dmytro Malovanyi <dmitrymalovanyy@gmail.com> wrote:
> Use the helper instead of open coding the check, so enhanced framing is
> used for all DPCD r1.2+ sinks as the spec requires.
>
> The helper takes DP_RECEIVER_CAP_SIZE bytes and gcc warns about reading
> past dpcd[4] (-Wstringop-overread), so read the full receiver caps like
> the other drivers do. That is 15 bytes, it fits in one AUX transfer.
>
> Compile tested only.
>
> Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Ditto about drm_dp_read_dpcd_caps() usage.

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index 8d0626ddf..0973598c7 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -262,7 +262,7 @@ struct cdv_intel_dp {
>  	uint32_t color_range;
>  	uint8_t link_bw;
>  	uint8_t lane_count;
> -	uint8_t dpcd[4];
> +	uint8_t dpcd[DP_RECEIVER_CAP_SIZE];
>  	struct gma_encoder *encoder;
>  	struct i2c_adapter adapter;
>  	struct i2c_algo_dp_aux_data algo;
> @@ -1070,11 +1070,7 @@ cdv_intel_dp_mode_set(struct drm_encoder *encoder, struct drm_display_mode *mode
>  	intel_dp->link_configuration[0] = intel_dp->link_bw;
>  	intel_dp->link_configuration[1] = intel_dp->lane_count;
>  
> -	/*
> -	 * Check for DPCD version > 1.1 and enhanced framing support
> -	 */
> -	if (intel_dp->dpcd[DP_DPCD_REV] >= 0x11 &&
> -	    (intel_dp->dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP)) {
> +	if (drm_dp_enhanced_frame_cap(intel_dp->dpcd)) {
>  		intel_dp->link_configuration[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
>  		intel_dp->DP |= DP_ENHANCED_FRAMING;
>  	}

-- 
Jani Nikula, Intel
