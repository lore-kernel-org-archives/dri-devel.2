Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65664606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RcQFyetm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCDB11223B;
	Thu, 29 Oct 2026 12:01:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D334811223B;
 Thu, 29 Oct 2026 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793275271; x=1824811271;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Sg99qBSYPrQ/dvhBMnxG7AV2h/mgImJ/LtHy20Vj8R4=;
 b=RcQFyetmjjAuZ89X/lZqjlnO/9AfaO3FSpcw2YzFyWJ3v+fZLwfAjuId
 ysqEcSa2pAmhB8R0eS7fPPUPRyVUHggR1dmLbE6ZrnVtbIUNt1NDd1EQK
 aDGvkYoclQuYFNzIadIvLhf3TyogorTItrpBgY584srh1yzdxM0UP1qXC
 ARVHOTh9WHs1IrVtKQ0TBK8ERr7LBuCXz2aNjliyqJQqCAy+P7163p7xD
 jyr1CljPoOpba31KQBbNXnyjhiTPHSdr6QBB5OmtjPa9D4/qJOTQ+1RGg
 RTJP4dCgxVXuYKfmoYTPjr9T3gx9aXx+UU7SpJUjpd/gFJCALvnCornWY w==;
X-CSE-ConnectionGUID: Qyr9sgxSSrO5MhtEJKZ4UQ==
X-CSE-MsgGUID: tezwPZDjRL+CEGYxyG10Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1908944"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1908944"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 05:01:10 -0700
X-CSE-ConnectionGUID: 5EX7hURQSrqLzZCP6wxP0w==
X-CSE-MsgGUID: c117/tVSTQiEeJx+aVTUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6889781"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.145])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 05:01:04 -0700
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
Subject: Re: [PATCH v2 3/5] drm/bridge: it6505: Use drm_dp_enhanced_frame_cap()
In-Reply-To: <20261029101826.72773-4-dmitrymalovanyy@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
 <20261029101826.72773-4-dmitrymalovanyy@gmail.com>
Date: Thu, 29 Oct 2026 14:01:00 +0200
Message-ID: <77d3b5f1643531134754303befe9ee2c3c13d5f6@intel.com>
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
> Use the helper instead of checking DP_ENHANCED_FRAME_CAP directly, so
> enhanced framing is used for all DPCD r1.2+ sinks as the spec requires.
>
> Compile tested only.
>
> Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Here too the driver should probably use drm_dp_read_dpcd_caps(), but
again beyond the patch.

> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index e136ac71e..d798a3db7 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1651,7 +1651,7 @@ static void it6505_parse_link_capabilities(struct it6505 *it6505)
>  	link->rate = drm_dp_bw_code_to_link_rate(it6505->dpcd[1]);
>  	link->num_lanes = it6505->dpcd[2] & DP_MAX_LANE_COUNT_MASK;
>  
> -	if (it6505->dpcd[2] & DP_ENHANCED_FRAME_CAP)
> +	if (drm_dp_enhanced_frame_cap(it6505->dpcd))
>  		link->capabilities = DP_ENHANCED_FRAME_CAP;
>  
>  	DRM_DEV_DEBUG_DRIVER(dev, "DPCD Rev.: %d.%d",

-- 
Jani Nikula, Intel
