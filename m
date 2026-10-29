Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7470606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZK1wMuIa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57AFA1120C6;
	Thu, 29 Oct 2026 08:28:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009CB10E79B;
 Thu, 29 Oct 2026 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793262517; x=1824798517;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=TnvN80Bf0n4uB+bI5HoU0LqShnpFVKfan1khsGEPCec=;
 b=ZK1wMuIan5NHOy41vVhFvjiNLSWklhitH33d7hm7e+EZ6tPsPsTWWeSt
 RLEZXPbYmIKXXhR6qFwC4bI3X4WCw6/RymyZM6Bp5hVeJSq+sAfxLF+l4
 ZjsCAVyONAEIl6yyQ/kuhVqZWDFsPZqxYeOj6aljAa8Ze+b9XdEtQ+kEE
 uh+VSmlB0ZKtqaNoijiVmRd5Vp3EN9lk60Iu349+1D7mEDA543zJjJKlU
 Cylxp9+jKjqeT4vwMRtYqfXFBIJkJHgbD4ivCZ0QQY6/mt00prJ3dO0nK
 IPydquZFooJl/0XjZorwUd0HiHfZqYpH3sJEY38uflJcZdbePpAPUtG5I w==;
X-CSE-ConnectionGUID: luF2fcYmQJefW7JQ7yphfA==
X-CSE-MsgGUID: TW/ZHjf+Q+edw5oykPHElQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1881882"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1881882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 01:28:36 -0700
X-CSE-ConnectionGUID: ALAye2J5Rzqe0qufoBBAeQ==
X-CSE-MsgGUID: Tm637KQpT3Cy8k7HwhNIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5071725"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.74])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 01:28:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Fangzhi Zuo <jerry.zuo@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo
 Li <sunpeng.li@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Alex Hung <alex.hung@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Fangzhi
 Zuo <jerry.zuo@amd.com>
Subject: Re: [PATCH 1/2] drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
In-Reply-To: <20261029004457.40545-2-jerry.zuo@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261029004457.40545-1-jerry.zuo@amd.com>
 <20261029004457.40545-2-jerry.zuo@amd.com>
Date: Thu, 29 Oct 2026 10:28:29 +0200
Message-ID: <36178559c2d18ea397f8d2afa8c3f4a9ffaec6fc@intel.com>
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

On Wed, 28 Oct 2026, Fangzhi Zuo <jerry.zuo@amd.com> wrote:
> [Why]
> drm_get_max_frl_rate() only decodes Max_FRL_Rate values 1-6, so a sink
> advertising an HDMI 2.2 rate (7, 8 or 9) falls into the default case and
> is reported as having no FRL support at all.
>
> [How]
> Decode the HDMI 2.2 Max_FRL_Rate values 7, 8 and 9 as 16, 20 and 24 Gbps
> per lane over 4 lanes.
>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_edid.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 42f4e41c459f..48d5c4bd4812 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6193,6 +6193,18 @@ void drm_get_max_frl_rate(int max_frl_rate, u8 *max_lanes, u8 *max_rate_per_lane
>  		*max_lanes = 4;
>  		*max_rate_per_lane = 12;
>  		break;
> +	case 7:
> +		*max_lanes = 4;
> +		*max_rate_per_lane = 16;
> +		break;
> +	case 8:
> +		*max_lanes = 4;
> +		*max_rate_per_lane = 20;
> +		break;
> +	case 9:
> +		*max_lanes = 4;
> +		*max_rate_per_lane = 24;
> +		break;
>  	case 0:
>  	default:
>  		*max_lanes = 0;

-- 
Jani Nikula, Intel
