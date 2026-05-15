Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC39CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50FF10E627;
	Fri, 15 May 2026 08:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hifzMWH6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41C710E627;
 Fri, 15 May 2026 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778833439; x=1810369439;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=JooSF+Ek8Wh2AcqPvuqh7MQtdJ3jhfpYPcNoI0+xdrs=;
 b=hifzMWH69x8/RlK8Ri0iR1LVtV8xyF8k6z9YlUvWrD8XEpsCYChoCdoV
 kHjseIM6+f1B1FZZm8IRByyr2cVnRfSsmtNSbezeczA8VUXTHB6431Mbs
 0/++5KT2SBrl19eG3FCUUykhi1mr/29sj/uglauPCpAo0L6itOIumLBC/
 t6qeSqe/VA0o2yUardZ3e2e+Iyq0rTitD7gKdYL89wQXbKFnnuBM2qL02
 3Iw6KLx8Ba15AejLouYPevrhH8VSCxoPr9RxSNp4uy69fK48soUYAVi0s
 yJg8Q8OqCcBf6y6Wq3XVABdfcjmNUliFfWtIGql64UnMErTFN/ty05LTY A==;
X-CSE-ConnectionGUID: lqC0zj79QLu5HgTWErz9TA==
X-CSE-MsgGUID: SN0z5ECLRxmM+RoicsAYnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78924230"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="78924230"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 01:23:59 -0700
X-CSE-ConnectionGUID: bRUy592fTIKJZZv9Wd+TfQ==
X-CSE-MsgGUID: TMsUi3iARk+Mw3GjQ8LJig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="235994718"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 01:23:56 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] drm/edid: parse panel type from DisplayID 2.x
 Display Parameters block
In-Reply-To: <20260514065606.1151834-2-chen-yu.chen@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260514065606.1151834-1-chen-yu.chen@amd.com>
 <20260514065606.1151834-2-chen-yu.chen@amd.com>
Date: Fri, 15 May 2026 11:23:54 +0300
Message-ID: <8e0c6356a570c55e3df54be6c2d7952dfcee2a06@intel.com>
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

On Thu, 14 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
> Parse the Display Parameters Data Block (tag 0x21) defined in
> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
> field from payload byte 27, bits [6:4], which indicates whether the
> panel is LCD (001b) or OLED (010b).
>
> Store the result in drm_display_info.did_panel_type so that downstream
> drivers can use it for panel-type-dependent behavior.
>
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++
>  drivers/gpu/drm/drm_edid.c               | 61 +++++++++++++++++++-----
>  include/drm/drm_connector.h              |  6 +++
>  include/uapi/drm/drm_mode.h              |  1 +
>  4 files changed, 82 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
> index 5b1b32f73516..e0f7c54d2987 100644
> --- a/drivers/gpu/drm/drm_displayid_internal.h
> +++ b/drivers/gpu/drm/drm_displayid_internal.h
> @@ -142,6 +142,31 @@ struct displayid_formula_timing_block {
>  	struct displayid_formula_timings_9 timings[];
>  } __packed;
>  
> +/*
> + * DisplayID v2.x Display Parameters Data Block (tag 0x21).
> + *
> + * Per VESA DisplayID v2.1a, Section 4.2.6, Table 4-14:
> + * Offset 0x1E (payload byte 27) contains Native Color Depth and
> + * Display Device Technology fields.
> + *   bits [2:0] = Native Color Depth
> + *   bit  [3]   = RESERVED
> + *   bits [6:4] = Display Device Technology
> + *     000b = not specified, 001b = LCD, 010b = OLED, others reserved
> + *   bit  [7]   = Display Device Theme Preference
> + */
> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
> +
> +struct displayid_display_params_block {
> +	struct displayid_block base;
> +	u8 payload[27];
> +	u8 device_tech_byte; /* bits [6:4] = Display Device Technology */
> +	u8 reserved;
> +} __packed;
> +
> +#define DISPLAYID_DISPLAY_PARAMS_MIN_LEN	\
> +	(sizeof(struct displayid_display_params_block) -	\
> +	 sizeof(struct displayid_block))
> +
>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>  
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 8031f021d4d0..9b160a878df4 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
>  
>  	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
> +
> +	info->did_panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
>  }
>  
>  static void update_displayid_info(struct drm_connector *connector,
> @@ -6721,24 +6723,61 @@ static void update_displayid_info(struct drm_connector *connector,
>  	struct drm_display_info *info = &connector->display_info;
>  	const struct displayid_block *block;
>  	struct displayid_iter iter;
> +	const u8 *section = NULL;
>  
>  	displayid_iter_edid_begin(drm_edid, &iter);
>  	displayid_iter_for_each(block, &iter) {
> +		if (section != iter.section) {
> +			drm_dbg_kms(connector->dev,
> +				    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> +				    connector->base.id, connector->name,
> +				    displayid_version(&iter),
> +				    displayid_primary_use(&iter));
> +			if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +			    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> +			     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> +				info->non_desktop = true;
> +			section = iter.section;
> +		}

What is this even supposed to do?

> +
>  		drm_dbg_kms(connector->dev,
> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> +			    "[CONNECTOR:%d:%s] DisplayID block tag 0x%02x, rev 0x%02x, size %u\n",
>  			    connector->base.id, connector->name,
> -			    displayid_version(&iter),
> -			    displayid_primary_use(&iter));
> +			    block->tag, block->rev, block->num_bytes);
> +
>  		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> -			info->non_desktop = true;
> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS) {
> +			const struct displayid_display_params_block *params =
> +				(const struct displayid_display_params_block *)block;
> +			u8 tech;
> +
> +			if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
> +				drm_dbg_kms(connector->dev,
> +					    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
> +					    connector->base.id, connector->name,
> +					    block->num_bytes,
> +					    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
> +				continue;
> +			}
>  
> -		/*
> -		 * We're only interested in the base section here, no need to
> -		 * iterate further.
> -		 */
> -		break;
> +			tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
> +					 params->device_tech_byte);
> +
> +			drm_dbg_kms(connector->dev,
> +				    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
> +				    connector->base.id, connector->name, tech);
> +
> +			switch (tech) {
> +			case 1: /* LCD */
> +				info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
> +				break;
> +			case 2: /* OLED */
> +				info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
> +				break;
> +			default:
> +				break;
> +			}
> +		}

Please tell copilot to not add so much crap in the iterator block. Add
functions. Add the first function as a refactor for non_desktop, add
more stuff on top, i.e. split this into multiple patches.

BR,
Jani.


>  	}
>  	displayid_iter_end(&iter);
>  }
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c398dbc68bbc..b95aec34ddb7 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -899,6 +899,12 @@ struct drm_display_info {
>  	 * @amd_vsdb: AMD-specific VSDB information.
>  	 */
>  	struct drm_amd_vsdb_info amd_vsdb;
> +
> +	/**
> +	 * @did_panel_type: Panel type from DisplayID Display Parameters
> +	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
> +	 */
> +	u8 did_panel_type;
>  };
>  
>  int drm_display_info_set_bus_formats(struct drm_display_info *info,
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 3693d82b5279..d7ca1040b92e 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -169,6 +169,7 @@ extern "C" {
>  /* Panel type property */
>  #define DRM_MODE_PANEL_TYPE_UNKNOWN	0
>  #define DRM_MODE_PANEL_TYPE_OLED	1
> +#define DRM_MODE_PANEL_TYPE_LCD		2
>  
>  /*
>   * DRM_MODE_ROTATE_<degrees>

-- 
Jani Nikula, Intel
