Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC066F33812
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5680D10E553;
	Tue, 17 Mar 2026 08:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RTdgNrSj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E64C10E5A2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773737121; x=1805273121;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=jMMxrwAh674yw97C/91unhdcVn9hvs22lW8Q+fk0LnM=;
 b=RTdgNrSjtaK7n9AyAXovWJHuH8CgyHR8RUgXq32UqGJbozrsvEl7jfX2
 CF8rtEJhf/H0LG51mi/GQ6FPaGwuLAZRYjqFahx2gf1ajCUKCHMhC0QjH
 kHHOa536Se26sRU04KP1aTlkozFrriE5wmDFKWrAjKV/mMx1NsQzBfson
 XCRG1fWVtm2AcEyRAILU4c2ZWRXjuRJqgLlDFLilX23t5gULLJ3ZxQjup
 4DBAQa4eS6PuW8GQlBdt/WTOT9mfk69B9JFLYmPmqMn8DUFWUscOsjDbj
 hhVG02nZcGcTOTLdGYZ76hO8BcytlnYWnlXBh31a+DOLl8GQHgL2BGNDI g==;
X-CSE-ConnectionGUID: Qkes4JQuQhatDDP2Z1hmmg==
X-CSE-MsgGUID: sQzlWbP7S++g+uTbhcoEsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78616834"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78616834"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:45:21 -0700
X-CSE-ConnectionGUID: BlaRi9rHSwGjM6AATKw2qA==
X-CSE-MsgGUID: KKsPbO94Q1Cplk00WHJXqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="216582035"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.32])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 01:45:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 alexander.deucher@amd.com
Subject: Re: [PATCH] drm/edid: fix off-by-2 byte offsets in HF-SCDB parsing
In-Reply-To: <20260316204907.3852592-1-aurabindo.pillai@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260316204907.3852592-1-aurabindo.pillai@amd.com>
Date: Tue, 17 Mar 2026 10:45:14 +0200
Message-ID: <e5b8b6f910578d33220476045899f4199286add8@intel.com>
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

On Mon, 16 Mar 2026, Aurabindo Pillai <aurabindo.pillai@amd.com> wrote:
> drm_parse_hdmi_forum_scds() used HF-VSDB byte offsets for both HF-VSDB
> and HF-SCDB block types. HF-VSDB has a 4-byte header (1 tag_len +
> 3 OUI) while HF-SCDB has a 2-byte header (1 tag_len + 1 ext_tag), so
> all field accesses were off by 2 for the SCDB case.

HF-SCDB has tag + ext tag + 2 reserved bytes, making the SCDS start at
offset 4 in both cases.

BR,
Jani.


>
> This caused SCDC support, max TMDS clock, scrambling, FRL rate,
> YCbCr420 deep color, and DSC capabilities to be read from wrong byte
> positions when parsed from an HF-SCDB block.
>
> Fix by passing a pointer to the Version byte (first field after
> block-specific headers) and an explicit length to the parsing
> functions, so both block types use the same normalized layout:
>  - HF-VSDB: data + 4, payload_len - 3 (skip tag_len + 3-byte OUI)
>  - HF-SCDB: data + 2, payload_len - 1 (skip tag_len + 1-byte ext_tag)
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 59 +++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 26bb7710a462..13174876b04c 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6143,45 +6143,45 @@ void drm_get_max_frl_rate(int max_frl_rate, u8 *max_lanes, u8 *max_rate_per_lane
>  }
>  
>  static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
> -					       const u8 *db)
> +					       const u8 *hf_scds)
>  {
>  	u8 dc_mask;
>  	struct drm_hdmi_info *hdmi = &connector->display_info.hdmi;
>  
> -	dc_mask = db[7] & DRM_EDID_YCBCR420_DC_MASK;
> +	dc_mask = hf_scds[3] & DRM_EDID_YCBCR420_DC_MASK;
>  	hdmi->y420_dc_modes = dc_mask;
>  }
>  
>  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
> -			       const u8 *hf_scds)
> +			       const u8 *hf_scds, int hf_scds_len)
>  {
> -	hdmi_dsc->v_1p2 = hf_scds[11] & DRM_EDID_DSC_1P2;
> +	hdmi_dsc->v_1p2 = hf_scds[7] & DRM_EDID_DSC_1P2;
>  
>  	if (!hdmi_dsc->v_1p2)
>  		return;
>  
> -	hdmi_dsc->native_420 = hf_scds[11] & DRM_EDID_DSC_NATIVE_420;
> -	hdmi_dsc->all_bpp = hf_scds[11] & DRM_EDID_DSC_ALL_BPP;
> +	hdmi_dsc->native_420 = hf_scds[7] & DRM_EDID_DSC_NATIVE_420;
> +	hdmi_dsc->all_bpp = hf_scds[7] & DRM_EDID_DSC_ALL_BPP;
>  
> -	if (hf_scds[11] & DRM_EDID_DSC_16BPC)
> +	if (hf_scds[7] & DRM_EDID_DSC_16BPC)
>  		hdmi_dsc->bpc_supported = 16;
> -	else if (hf_scds[11] & DRM_EDID_DSC_12BPC)
> +	else if (hf_scds[7] & DRM_EDID_DSC_12BPC)
>  		hdmi_dsc->bpc_supported = 12;
> -	else if (hf_scds[11] & DRM_EDID_DSC_10BPC)
> +	else if (hf_scds[7] & DRM_EDID_DSC_10BPC)
>  		hdmi_dsc->bpc_supported = 10;
>  	else
>  		/* Supports min 8 BPC if DSC 1.2 is supported*/
>  		hdmi_dsc->bpc_supported = 8;
>  
> -	if (cea_db_payload_len(hf_scds) >= 12 && hf_scds[12]) {
> +	if (hf_scds_len >= 9 && hf_scds[8]) {
>  		u8 dsc_max_slices;
>  		u8 dsc_max_frl_rate;
>  
> -		dsc_max_frl_rate = (hf_scds[12] & DRM_EDID_DSC_MAX_FRL_RATE_MASK) >> 4;
> +		dsc_max_frl_rate = (hf_scds[8] & DRM_EDID_DSC_MAX_FRL_RATE_MASK) >> 4;
>  		drm_get_max_frl_rate(dsc_max_frl_rate, &hdmi_dsc->max_lanes,
>  				     &hdmi_dsc->max_frl_rate_per_lane);
>  
> -		dsc_max_slices = hf_scds[12] & DRM_EDID_DSC_MAX_SLICES;
> +		dsc_max_slices = hf_scds[8] & DRM_EDID_DSC_MAX_SLICES;
>  
>  		switch (dsc_max_slices) {
>  		case 1:
> @@ -6219,13 +6219,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
>  		}
>  	}
>  
> -	if (cea_db_payload_len(hf_scds) >= 13 && hf_scds[13])
> -		hdmi_dsc->total_chunk_kbytes = hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
> +	if (hf_scds_len >= 10 && hf_scds[9])
> +		hdmi_dsc->total_chunk_kbytes = hf_scds[9] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
>  }
>  
>  /* Sink Capability Data Structure */
>  static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
> -				      const u8 *hf_scds)
> +				      const u8 *hf_scds, int hf_scds_len)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	struct drm_hdmi_info *hdmi = &info->hdmi;
> @@ -6236,9 +6236,9 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  
>  	info->has_hdmi_infoframe = true;
>  
> -	if (hf_scds[6] & 0x80) {
> +	if (hf_scds[2] & 0x80) {
>  		hdmi->scdc.supported = true;
> -		if (hf_scds[6] & 0x40)
> +		if (hf_scds[2] & 0x40)
>  			hdmi->scdc.read_request = true;
>  	}
>  
> @@ -6251,11 +6251,11 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  	 * Lets check it out.
>  	 */
>  
> -	if (hf_scds[5]) {
> +	if (hf_scds[1]) {
>  		struct drm_scdc *scdc = &hdmi->scdc;
>  
>  		/* max clock is 5000 KHz times block value */
> -		max_tmds_clock = hf_scds[5] * 5000;
> +		max_tmds_clock = hf_scds[1] * 5000;
>  
>  		if (max_tmds_clock > 340000) {
>  			info->max_tmds_clock = max_tmds_clock;
> @@ -6265,21 +6265,21 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  			scdc->scrambling.supported = true;
>  
>  			/* Few sinks support scrambling for clocks < 340M */
> -			if ((hf_scds[6] & 0x8))
> +			if ((hf_scds[2] & 0x8))
>  				scdc->scrambling.low_rates = true;
>  		}
>  	}
>  
> -	if (hf_scds[7]) {
> -		max_frl_rate = (hf_scds[7] & DRM_EDID_MAX_FRL_RATE_MASK) >> 4;
> +	if (hf_scds[3]) {
> +		max_frl_rate = (hf_scds[3] & DRM_EDID_MAX_FRL_RATE_MASK) >> 4;
>  		drm_get_max_frl_rate(max_frl_rate, &hdmi->max_lanes,
>  				     &hdmi->max_frl_rate_per_lane);
>  	}
>  
>  	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
>  
> -	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
> -		drm_parse_dsc_info(hdmi_dsc, hf_scds);
> +	if (hf_scds_len >= 8 && hf_scds[7]) {
> +		drm_parse_dsc_info(hdmi_dsc, hf_scds, hf_scds_len);
>  		dsc_support = true;
>  	}
>  
> @@ -6444,9 +6444,14 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
>  
>  		if (cea_db_is_hdmi_vsdb(db))
>  			drm_parse_hdmi_vsdb_video(connector, data);
> -		else if (cea_db_is_hdmi_forum_vsdb(db) ||
> -			 cea_db_is_hdmi_forum_scdb(db))
> -			drm_parse_hdmi_forum_scds(connector, data);
> +		else if (cea_db_is_hdmi_forum_vsdb(db))
> +			drm_parse_hdmi_forum_scds(connector,
> +						  data + 4,
> +						  cea_db_payload_len(db) - 3);
> +		else if (cea_db_is_hdmi_forum_scdb(db))
> +			drm_parse_hdmi_forum_scds(connector,
> +						  data + 2,
> +						  cea_db_payload_len(db) - 1);
>  		else if (cea_db_is_microsoft_vsdb(db))
>  			drm_parse_microsoft_vsdb(connector, data);
>  		else if (cea_db_is_y420cmdb(db))

-- 
Jani Nikula, Intel
