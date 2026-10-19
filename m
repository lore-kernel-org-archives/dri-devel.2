Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6A3CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D94F10ED3A;
	Mon, 19 Oct 2026 13:28:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C8610E0F6
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792416529; x=1823952529;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=GMqklCenpFaYaxcJvPNUFIppL+AjgLQQ3Ow/FoEWGV0=;
 b=RXO4FDENirKyR5irl2MznkiNeWeLGn/AgOIj8b9bpDsA2YkbDPFs0Sxg
 fZ1RDE/RquJVlpzwJpbtN0NaRqAW+wV13gbddr9e/85lQBcMMamm1o28A
 efJamao0bXNA76qDqLitrgppbSFksDLEGuQquxXnNiSN1nyXszRoFUXQh
 CfPodU1tQ4RBUvc0tCt9TcVNosbIBEZ9BAncOhilsbeNgvLpthU+MytAE
 UprojQ31c/59sQmaaH9ahGUkXZgQfjjMvSyoZR38nmimpL+KZiONnZNSj
 E1RSuGpqS8P6TDPug5WrmJg0+obM7ZNkh6X/5pC1fh4E6CGzOlBLYqNVr w==;
X-CSE-ConnectionGUID: eT5okAVxRCOGYbj0cLlvvA==
X-CSE-MsgGUID: fJd/chd5TNOKlm/bKi1n8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="995806"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="995806"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:28:48 -0700
X-CSE-ConnectionGUID: BQpdfbZKRlu92tPvzvxVUg==
X-CSE-MsgGUID: 0qNzjuEDRCaKJgpO70C1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2413921"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.21])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:28:44 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, Chenyu Chen <chen-yu.chen@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: reduce update_display_info() stack usage
In-Reply-To: <20261013205223.2396822-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261013205223.2396822-1-arnd@kernel.org>
Date: Mon, 19 Oct 2026 16:28:41 +0300
Message-ID: <6c18da11310ced4a7c85ac7862c3f5c67b39891a@intel.com>
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

On Tue, 13 Oct 2026, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The drm_parse_cea_ext() calls into nine individual parser functions
> based on the data format. If all of those get inlined and KASAN_STACK
> is enabled, this can explode the combined stack usage beyond a
> reasonable amount:
>
> drivers/gpu/drm/drm_edid.c: In function 'update_display_info':
> drivers/gpu/drm/drm_edid.c:7040:1: error: the frame size of 1888 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>  7040 | }
>       | ^
>
> Mark all of the individual parser functions as noinline_for_stack
> to avoid this and keep their stack frames separate. This reduces
> the stack usage for update_display_info/drm_parse_cea_ext to
> a more manageable 744 bytes, while each parser only adds at most
> 200 bytes on top.

Is there really no way to tell the compiler to not do silly things in a
more generic way?

BR,
Jani.


>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/drm_edid.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 3148038747b6..913a8bbe8894 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -5341,8 +5341,9 @@ static int edid_hfeeodb_extension_block_count(const struct edid *edid)
>   * etc). For example, if the bit 0 in bitmap is set, first mode in VDB can
>   * support YCBCR420 output too.
>   */
> -static void parse_cta_y420cmdb(struct drm_connector *connector,
> -			       const struct cea_db *db, u64 *y420cmdb_map)
> +static noinline_for_stack void
> +parse_cta_y420cmdb(struct drm_connector *connector, const struct cea_db *db,
> +		   u64 *y420cmdb_map)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	int i, map_len = cea_db_payload_len(db) - 1;
> @@ -5515,7 +5516,7 @@ static uint8_t hdr_metadata_type(const u8 *edid_ext)
>  		BIT(HDMI_STATIC_METADATA_TYPE1);
>  }
>  
> -static void
> +static noinline_for_stack void
>  drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
>  {
>  	struct hdr_static_metadata *hdr_metadata =
> @@ -6070,7 +6071,8 @@ drm_default_rgb_quant_range(const struct drm_display_mode *mode)
>  EXPORT_SYMBOL(drm_default_rgb_quant_range);
>  
>  /* CTA-861 Video Data Block (CTA VDB) */
> -static void parse_cta_vdb(struct drm_connector *connector, const struct cea_db *db)
> +static noinline_for_stack void
> +parse_cta_vdb(struct drm_connector *connector, const struct cea_db *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	int i, vic_index, len = cea_db_payload_len(db);
> @@ -6136,8 +6138,8 @@ static bool cta_vdb_has_vic(const struct drm_connector *connector, u8 vic)
>  }
>  
>  /* CTA-861-H YCbCr 4:2:0 Video Data Block (CTA Y420VDB) */
> -static void parse_cta_y420vdb(struct drm_connector *connector,
> -			      const struct cea_db *db)
> +static noinline_for_stack void
> +parse_cta_y420vdb(struct drm_connector *connector, const struct cea_db *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	struct drm_hdmi_info *hdmi = &info->hdmi;
> @@ -6155,7 +6157,8 @@ static void parse_cta_y420vdb(struct drm_connector *connector,
>  	}
>  }
>  
> -static void drm_parse_vcdb(struct drm_connector *connector, const u8 *db)
> +static noinline_for_stack void
> +drm_parse_vcdb(struct drm_connector *connector, const u8 *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  
> @@ -6310,8 +6313,8 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
>  }
>  
>  /* Sink Capability Data Structure */
> -static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
> -				      const u8 *hf_scds)
> +static noinline_for_stack void
> +drm_parse_hdmi_forum_scds(struct drm_connector *connector, const u8 *hf_scds)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	struct drm_hdmi_info *hdmi = &info->hdmi;
> @@ -6451,7 +6454,7 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
>  }
>  
>  /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
> -static void
> +static noinline_for_stack void
>  drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
> @@ -6486,8 +6489,8 @@ drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
>   * See EDID extension for head-mounted and specialized monitors, specified at:
>   * https://docs.microsoft.com/en-us/windows-hardware/drivers/display/specialized-monitors-edid-extension
>   */
> -static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
> -				     const u8 *db)
> +static noinline_for_stack void
> +drm_parse_microsoft_vsdb(struct drm_connector *connector, const u8 *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	u8 version = db[4];
> @@ -6558,8 +6561,8 @@ static void drm_parse_amd_vsdb_v3(struct drm_display_info *info,
>  	info->amd_vsdb.max_frame_rate = max_frame_rate;
>  }
>  
> -static void drm_parse_amd_vsdb(struct drm_connector *connector,
> -			       const struct cea_db *db)
> +static noinline_for_stack void
> +drm_parse_amd_vsdb(struct drm_connector *connector, const struct cea_db *db)
>  {
>  	struct drm_display_info *info = &connector->display_info;
>  	const u8 *data = cea_db_data(db);

-- 
Jani Nikula, Intel
