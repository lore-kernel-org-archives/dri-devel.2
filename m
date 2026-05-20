Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59505CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B437810E128;
	Wed, 20 May 2026 13:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jght+Hfs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A59510E128;
 Wed, 20 May 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779283862; x=1810819862;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=QZYoI+VQgQ2Nuf+G4GfEMCrOLYQjkwJ7NXjD7ev4TWo=;
 b=jght+HfsWFU6Txu05IlmgCBg7N5H4YJGUWmIB757QNA/YK+C0gFjwRJZ
 ncZTHJqR3rvqulMfoswi3aAzLsgjkZTgGf6Bvj6R77YMljZgPbhePW2Ul
 y5eVV1ryMHHKs0YYVtkSzL5I6cfmb/O0SLBuxObTTqhDt1emExxCICMYL
 YCpdByO8g+aShenjkvEPNFW5iDG9hwrWrD88d+al60lGQzcRQWFhylvA+
 n5AwqBUcdIFFiFUWz7s7yMi8fN4IKwJ9CbJAwDsrMYW1DxjGdrt1DwlT3
 JjpZqx15wgv5RMkjomf6SCBAAWH3pQIfEEZcFxfI8rBZIqbhUox1YACuY g==;
X-CSE-ConnectionGUID: yR6jcgKqTV6sLOcbxuXlBg==
X-CSE-MsgGUID: 46SrWJ2XQ22FbmuX/JpJMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="102859133"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="102859133"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 06:31:02 -0700
X-CSE-ConnectionGUID: WdO4FvWuRgKrtTgCvGISHQ==
X-CSE-MsgGUID: IuQ6JddYQz6Sh8lRhPG17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244177950"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.148])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 06:30:58 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v2 2/3] drm/edid: parse panel type from DisplayID 2.x
 Display Parameters
In-Reply-To: <20260520021432.1301326-3-chen-yu.chen@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
 <20260520021432.1301326-3-chen-yu.chen@amd.com>
Date: Wed, 20 May 2026 16:30:55 +0300
Message-ID: <4ca47af4a86601462cf5c0e723b2055005118762@intel.com>
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

On Wed, 20 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
> Parse the Display Parameters Data Block (tag 0x21) defined in
> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
> field from payload byte 27 bits [6:4], which indicates whether the
> panel uses LCD (001b) or OLED (010b) technology.
>
> Add a did_panel_type field to struct drm_display_info and populate it
> during DisplayID iteration so downstream drivers can use it for
> panel-type-dependent behavior. Add DRM_MODE_PANEL_TYPE_LCD to the
> UAPI constants for use as an internal communication value between
> DRM core and drivers.
>
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++++++
>  drivers/gpu/drm/drm_edid.c               | 44 ++++++++++++++++++++++++
>  include/drm/drm_connector.h              |  6 ++++
>  include/uapi/drm/drm_mode.h              |  1 +
>  4 files changed, 76 insertions(+)
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

Please drop the comment...

> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
> +
> +struct displayid_display_params_block {
> +	struct displayid_block base;
> +	u8 payload[27];
> +	u8 device_tech_byte; /* bits [6:4] = Display Device Technology */
> +	u8 reserved;

...and actually define the information here.

Sure, you're only interested in one thing, but don't leave the rest for
someone who comes after you, since you clearly have access to the spec,
and whoever reviews this also needs to have access to the spec.

> +} __packed;
> +
> +#define DISPLAYID_DISPLAY_PARAMS_MIN_LEN	\
> +	(sizeof(struct displayid_display_params_block) -	\
> +	 sizeof(struct displayid_block))

Is this helpful? Do you suggest we should add the define for all of the
blocks? What about when there's a minimum, and you can optionally have
more?

> +
>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>  
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 04878478ab78..d1de1a398677 100644
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
>  static void drm_displayid_process_section_header(struct drm_connector *connector,
> @@ -6731,6 +6733,44 @@ static void drm_displayid_process_section_header(struct drm_connector *connector
>  		info->non_desktop = true;
>  }
>  
> +static void
> +drm_displayid_parse_display_params(struct drm_connector *connector,
> +				   const struct displayid_block *block)
> +{
> +	struct drm_display_info *info = &connector->display_info;
> +	const struct displayid_display_params_block *params =
> +		(const struct displayid_display_params_block *)block;
> +

Superfluous blank line.

> +	u8 tech;
> +
> +	if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
> +			    connector->base.id, connector->name,
> +			    block->num_bytes,
> +			    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
> +		return;
> +	}
> +
> +	tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
> +			 params->device_tech_byte);
> +
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
> +		    connector->base.id, connector->name, tech);

It would be more useful to print LCD or OLED, not the number.

> +
> +	switch (tech) {
> +	case 1: /* LCD */
> +		info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
> +		break;
> +	case 2: /* OLED */

The comments above are useless.

> +		info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void update_displayid_info(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> @@ -6744,6 +6784,10 @@ static void update_displayid_info(struct drm_connector *connector,
>  			drm_displayid_process_section_header(connector, &iter);
>  			header_processed = true;
>  		}
> +
> +		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
> +			drm_displayid_parse_display_params(connector, block);
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

What does the did_ prefix give us?

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

This is a UABI header.

Should we add this to the panel type property too?


BR,
Jani.


>  
>  /*
>   * DRM_MODE_ROTATE_<degrees>

-- 
Jani Nikula, Intel
