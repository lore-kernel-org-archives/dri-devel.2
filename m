Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DEDC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E796C10F66C;
	Fri, 26 Jun 2026 15:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eMQ7hbLR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D21610F66C;
 Fri, 26 Jun 2026 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782488698; x=1814024698;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=xMf7ZXe6/RJ1KcAmvvmn4XDJn/rMypmeK3NrV2r53xY=;
 b=eMQ7hbLR6aJZF7akKt7lvo4NxI7aodGsjiwICKVaKgV9SO+ivypXoDbx
 /U3xbmeUYcIps1b0zxw1OWKEiszfiWRKNRyANvjvaJrtq9E0cvs/Sasmw
 y0bM7M5XQ84C0CHUXR3TiBq74tA2AP39iEuD6PMhDr+KZvG8Uj3GTMIuF
 uR/YKF5DZRE2aS605X0qhMrZuZTf6S0Yr+wOJo+51wgNW+jTBZ1JQuvvY
 WPvxZmZLboj3zGkzBeXHsYlytamB2R7gLPs8RRHRR2kq5ZCsfryJGKx3X
 opYDnnWFIMv41/myiL22k0UMmM/C61Zfu1ThKedzxCTdyHZqffw06a1jE Q==;
X-CSE-ConnectionGUID: NfO66PMFTKWP4OZB8cuCzw==
X-CSE-MsgGUID: c9pRPfJIQhml/Bpk24LIiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="82393832"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="82393832"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 08:44:58 -0700
X-CSE-ConnectionGUID: /+ZULXUWTbu+jD04U9RpNg==
X-CSE-MsgGUID: jDgl0zNmT/2sEVrVXZgVpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="253264255"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 08:44:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: Re: [PATCH v3 1/3] drm/edid: extract base section header processing
 into helper
In-Reply-To: <20260526030254.1460480-2-chen-yu.chen@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
 <20260526030254.1460480-2-chen-yu.chen@amd.com>
Date: Fri, 26 Jun 2026 18:44:46 +0300
Message-ID: <e559162c1eecf91493623fdc546262e9391c0821@intel.com>
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

On Tue, 26 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
> Extract the DisplayID base section header logging and non_desktop
> detection from update_displayid_info() into a dedicated helper,
> drm_displayid_process_base_section_header(). Remove the break so the
> iterator walks through all data blocks, preparing for future patches
> that will parse additional block types within the loop.
>
> The helper is called only once for the base section via a
> base_section_header_processed flag. Since version and primary_use are
> only captured from the base section, and extension sections carry a
> primary use of zero per spec, the non_desktop logic is unaffected.
>
> No functional change.
>
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_edid.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 8031f021d4d0..7ad3f939dbe6 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6715,30 +6715,35 @@ static void drm_reset_display_info(struct drm_connector *connector)
>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>  }
>  
> +static void drm_displayid_process_base_section_header(struct drm_connector *connector,
> +						      const struct displayid_iter *iter)
> +{
> +	struct drm_display_info *info = &connector->display_info;
> +
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> +		    connector->base.id, connector->name,
> +		    displayid_version(iter),
> +		    displayid_primary_use(iter));
> +	if (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +	    (displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> +	     displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> +		info->non_desktop = true;
> +}
> +
>  static void update_displayid_info(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> -	struct drm_display_info *info = &connector->display_info;
>  	const struct displayid_block *block;
>  	struct displayid_iter iter;
> +	bool base_section_header_processed = false;
>  
>  	displayid_iter_edid_begin(drm_edid, &iter);
>  	displayid_iter_for_each(block, &iter) {
> -		drm_dbg_kms(connector->dev,
> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> -			    connector->base.id, connector->name,
> -			    displayid_version(&iter),
> -			    displayid_primary_use(&iter));
> -		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> -			info->non_desktop = true;
> -
> -		/*
> -		 * We're only interested in the base section here, no need to
> -		 * iterate further.
> -		 */
> -		break;
> +		if (!base_section_header_processed) {
> +			drm_displayid_process_base_section_header(connector, &iter);
> +			base_section_header_processed = true;
> +		}
>  	}
>  	displayid_iter_end(&iter);
>  }

-- 
Jani Nikula, Intel
