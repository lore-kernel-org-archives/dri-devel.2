Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B435C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5BD10F684;
	Fri, 26 Jun 2026 15:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oCqBGv2u";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3942C10F684;
 Fri, 26 Jun 2026 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782489353; x=1814025353;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=U/gjwRcby5HPhUf6tNl2cTSPH3fsDm/J33wljVCYVj0=;
 b=oCqBGv2uirYwro/OK78LpMw9o/rPIrAJTHXjDtl9c+VHiQZJU8ymhjQr
 mA6uQhTbVLdnUO5/+Ryh2P70mDzA4GjpHEUcq81EOJmx56HteqDkqkbTP
 odHSUzFfQgrTl7Ku1MrhUTYYJy3+pSlVh/+wgari4peTOdiGRzxttiF4o
 x3RPYj/kjEEq1oDUfDXFAph+t2CKIWpnxGrlpSdjy1HSdWERI2Kt3RRzB
 r3CEI46T/5+ZZLru3x0l//fzecG2nuGUXOfdHBP482B56zYhaGPBelkNJ
 N9NKjuGV6dy1RLYlv4I1dsH0jf2HIk27JwAngfOrtJaviOUA5w3F3fXLd A==;
X-CSE-ConnectionGUID: 6wcv3M7WQ56tGAfIUuCGtQ==
X-CSE-MsgGUID: tDCF/uUlQx6lVZi49NpPww==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="87183618"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="87183618"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 08:55:52 -0700
X-CSE-ConnectionGUID: S877QZZyQQOObyLatAhVgg==
X-CSE-MsgGUID: NBuwpKe6SnCUGibKYFd2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244958602"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 08:55:49 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: Re: [PATCH v3 2/3] drm/edid: parse panel type from DisplayID 2.x
 Display Parameters
In-Reply-To: <20260526030254.1460480-3-chen-yu.chen@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
 <20260526030254.1460480-3-chen-yu.chen@amd.com>
Date: Fri, 26 Jun 2026 18:55:47 +0300
Message-ID: <1957bee7418e347b9c548e3be2e2d90da551ff93@intel.com>
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
> Parse the Display Parameters Data Block (tag 0x21) defined in
> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
> field from the color depth and device technology byte, which indicates
> whether the panel uses LCD or OLED technology.
>
> Add a panel_type field to struct drm_display_info and populate it
> during DisplayID iteration so downstream drivers can use it for
> panel-type-dependent behavior. Add DRM_MODE_PANEL_TYPE_LCD to the UAPI
> panel type property alongside the existing OLED value.
>
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>

Some nitpicks inline, but regardless of whether you decide to do
something about them or not, overall,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_connector.c          |  3 +-
>  drivers/gpu/drm/drm_displayid_internal.h | 24 +++++++++++++
>  drivers/gpu/drm/drm_edid.c               | 45 ++++++++++++++++++++++++
>  include/drm/drm_connector.h              |  6 ++++
>  include/uapi/drm/drm_mode.h              |  1 +
>  5 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index aec05adbc889..f2ac4542a7d3 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1176,6 +1176,7 @@ static const struct drm_prop_enum_list drm_link_status_enum_list[] = {
>  static const struct drm_prop_enum_list drm_panel_type_enum_list[] = {
>  	{ DRM_MODE_PANEL_TYPE_UNKNOWN, "unknown" },
>  	{ DRM_MODE_PANEL_TYPE_OLED, "OLED" },
> +	{ DRM_MODE_PANEL_TYPE_LCD, "LCD" },
>  };
>  
>  /**
> @@ -1508,7 +1509,7 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
>   * 	never read back the value of "DPMS" because it can be incorrect.
>   * panel_type:
>   * 	Immutable enum property to indicate the type of connected panel.
> - * 	Possible values are "unknown" (default) and "OLED".
> + * 	Possible values are "unknown" (default), "OLED", and "LCD".
>   * PATH:
>   * 	Connector path property to identify how this sink is physically
>   * 	connected. Used by DP MST. This should be set by calling
> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
> index 5b1b32f73516..6f431aafafcf 100644
> --- a/drivers/gpu/drm/drm_displayid_internal.h
> +++ b/drivers/gpu/drm/drm_displayid_internal.h
> @@ -142,6 +142,30 @@ struct displayid_formula_timing_block {
>  	struct displayid_formula_timings_9 timings[];
>  } __packed;
>  
> +#define DISPLAYID_DEVICE_TECH_UNSPECIFIED	0
> +#define DISPLAYID_DEVICE_TECH_LCD		1
> +#define DISPLAYID_DEVICE_TECH_OLED		2
> +
> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)

For masks, I'd add _MASK suffix. There's GENMASK_U8() for 8-bit masks.

> +
> +struct displayid_display_params_block {
> +	struct displayid_block base;
> +	__le16 horiz_image_size;
> +	__le16 vert_image_size;
> +	__le16 horiz_pixel_count;
> +	__le16 vert_pixel_count;
> +	u8 features;
> +	u8 primary_color1[3];
> +	u8 primary_color2[3];
> +	u8 primary_color3[3];
> +	u8 white_point[3];
> +	__le16 max_luminance_full;
> +	__le16 max_luminance_10;
> +	__le16 min_luminance;
> +	u8 color_depth_and_tech;	/* [2:0] depth, [6:4] device tech, [7] theme */
> +	u8 gamma_eotf;
> +} __packed;
> +
>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>  
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 7ad3f939dbe6..a9d480981c8f 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
>  
>  	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
> +
> +	info->panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
>  }
>  
>  static void drm_displayid_process_base_section_header(struct drm_connector *connector,
> @@ -6731,6 +6733,45 @@ static void drm_displayid_process_base_section_header(struct drm_connector *conn
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
> +	u8 tech;
> +
> +	if (block->num_bytes < sizeof(*params) - sizeof(params->base)) {

I actually like using the size inline when it comes to parsing specs
like this. The point is, the spec may get amended, with more fields
added to the end, but we'll still need to be able to parse all sizes.

> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
> +			    connector->base.id, connector->name,
> +			    block->num_bytes,
> +			    sizeof(*params) - sizeof(params->base));
> +		return;
> +	}
> +
> +	tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
> +			 params->color_depth_and_tech);
> +
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %s\n",
> +		    connector->base.id, connector->name,
> +		    tech == DISPLAYID_DEVICE_TECH_LCD ? "LCD" :
> +		    tech == DISPLAYID_DEVICE_TECH_OLED ? "OLED" : "unspecified");
> +
> +	switch (tech) {
> +	case DISPLAYID_DEVICE_TECH_LCD:
> +		info->panel_type = DRM_MODE_PANEL_TYPE_LCD;
> +		break;
> +	case DISPLAYID_DEVICE_TECH_OLED:
> +		info->panel_type = DRM_MODE_PANEL_TYPE_OLED;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void update_displayid_info(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> @@ -6744,6 +6785,10 @@ static void update_displayid_info(struct drm_connector *connector,
>  			drm_displayid_process_base_section_header(connector, &iter);
>  			base_section_header_processed = true;
>  		}
> +
> +		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
> +			drm_displayid_parse_display_params(connector, block);
>  	}
>  	displayid_iter_end(&iter);
>  }
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c398dbc68bbc..745cd917fe40 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -899,6 +899,12 @@ struct drm_display_info {
>  	 * @amd_vsdb: AMD-specific VSDB information.
>  	 */
>  	struct drm_amd_vsdb_info amd_vsdb;
> +
> +	/**
> +	 * @panel_type: Panel type from DisplayID Display Parameters
> +	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
> +	 */
> +	u8 panel_type;
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
