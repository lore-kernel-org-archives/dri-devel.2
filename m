Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838FBC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995D110E365;
	Fri, 24 Jul 2026 16:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnrF2JkG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02BD110E062;
 Fri, 24 Jul 2026 16:30:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5216600AD;
 Fri, 24 Jul 2026 16:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E51F000E9;
 Fri, 24 Jul 2026 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784910610;
 bh=1eyJRYLHMiB/CEKvoentSUeYfCWIqtTg0TsHCSxwrT4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VnrF2JkGagbqNUmdl9nlGtO/tCOiYQfMHCM//HB/1CPx5DWWExln5rOhLE/ikh5o3
 CbY6+HI+T3PCebNYK8MXganqIk5O7Nly7gSmrZR09IoZbW0cyIpsJ2MIdL2WunaGfM
 v5td5N8+NJzjRl0rvSf2Xa0I4ScX2dtKNFftOhfBQliYLEMshEL309pLBSWgl/E/CQ
 BwrNxG3ibXrqESwQhNsShmQw8vs2LGZ+O+wIdJjC3ht0NPXvk4AWTxDDPaNIV+nfY6
 OODSlPT/P73PDI8qW1+Yx52bi006ju56Hjwh26VMaMu54SGerK7dUiEWhDG9iIMRT3
 pDC0efNwzcJgQ==
Message-ID: <aff1ea6c-791f-49c1-a233-9d5466a9aa32@kernel.org>
Date: Fri, 24 Jul 2026 11:30:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh range
Content-Language: en-US
To: Alex Huang <Alex.Huang2@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, alex.hung@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
 <20260724161713.119382-2-Alex.Huang2@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260724161713.119382-2-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/24/26 11:17, Alex Huang wrote:
> Commit 118362a96286 ("drm/edid: Parse AMD Vendor-Specific Data Block")
> added parsing of the AMD VSDB, but only for version 3 and only for the
> replay/panel-type/luminance fields. Monitors that only advertise
> FreeSync through a v1 or v2 AMD VSDB therefore get no variable refresh
> rate range from the common EDID parser.
> 
> Restructure drm_parse_amd_vsdb() and implement parsing for the FreeSync
> refresh range fields provided in the AMD VSDB.
> 
> Signed-off-by: Alex Huang <Alex.Huang2@amd.com>

Nice!  The ladder worked out great.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

One comment below to consider, but up to you on it.

> ---
>   drivers/gpu/drm/drm_edid.c  | 141 ++++++++++++++++++++++++++++--------
>   include/drm/drm_connector.h |  22 +++++-
>   2 files changed, 133 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac761..2abe85b76d33 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -101,20 +101,42 @@ enum drm_edid_internal_quirk {
>   #define MICROSOFT_IEEE_OUI	0xca125c
>   #define AMD_IEEE_OUI        0x00001A
>   
> +#define AMD_VSDB_V1_PAYLOAD_LEN 8
> +#define AMD_VSDB_V2_PAYLOAD_LEN 13
>   #define AMD_VSDB_V3_PAYLOAD_MIN_LEN 15
> -#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 20
> +#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 21
>   
> -struct amd_vsdb_v3_payload {
> +#define AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN 21
> +
> +struct amd_vsdb_common_payload {
>   	u8 oui[3];
>   	u8 version;
> +} __packed;
> +
> +struct amd_vsdb_v1_payload {
> +	struct amd_vsdb_common_payload common;
>   	u8 feature_caps;
> -	u8 rsvd0[3];
> +	u8 min_vfreq;
> +	u8 max_vfreq;
> +	u8 freesync_vcp_code;
> +} __packed;
> +
> +struct amd_vsdb_v2_payload {
> +	struct amd_vsdb_v1_payload v1;
>   	u8 cs_eotf_support;
>   	u8 lum1_max;
>   	u8 lum1_min;
>   	u8 lum2_max;
>   	u8 lum2_min;
> -	u8 rsvd1[2];
> +} __packed;
> +
> +struct amd_vsdb_v3_payload {
> +	struct amd_vsdb_v2_payload v2;
> +	u8 max_vfreq_ext_low;
> +	/*
> +	 * byte 14: bits 0-1 extend MSB of max refresh rate
> +	 */
> +	u8 max_vfreq_ext_high;
>   	/*
>   	 * Bytes beyond AMD_VSDB_V3_PAYLOAD_MIN_LEN are optional; a
>   	 * monitor may provide a payload as short as 15 bytes.  Always
> @@ -123,6 +145,12 @@ struct amd_vsdb_v3_payload {
>   	u8 extra[AMD_VSDB_V3_PAYLOAD_MAX_LEN - AMD_VSDB_V3_PAYLOAD_MIN_LEN];
>   } __packed;
>   
> +static const u8 amd_vsdb_min_len[] = {
> +	[1] = AMD_VSDB_V1_PAYLOAD_LEN,
> +	[2] = AMD_VSDB_V2_PAYLOAD_LEN,
> +	[3] = AMD_VSDB_V3_PAYLOAD_MIN_LEN,
> +};
> +
>   struct detailed_mode_closure {
>   	struct drm_connector *connector;
>   	const struct drm_edid *drm_edid;
> @@ -5231,7 +5259,7 @@ static bool cea_db_is_microsoft_vsdb(const struct cea_db *db)
>   static bool cea_db_is_amd_vsdb(const struct cea_db *db)
>   {
>   	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
> -		cea_db_payload_len(db) >= AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
> +		cea_db_payload_len(db) >= AMD_VSDB_V1_PAYLOAD_LEN &&
>   		cea_db_payload_len(db) <= AMD_VSDB_V3_PAYLOAD_MAX_LEN;
>   }
>   
> @@ -6431,43 +6459,98 @@ static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
>   		    connector->base.id, connector->name, version, db[5]);
>   }
>   
> +static void drm_parse_amd_vsdb_common(struct drm_display_info *info,
> +				  const struct amd_vsdb_common_payload *data)
> +{
> +	info->amd_vsdb.version = data->version;
> +}
> +
> +static void drm_parse_amd_vsdb_v1(struct drm_display_info *info,
> +				  const struct amd_vsdb_v1_payload *data)
> +{
> +	info->amd_vsdb.freesync_supported = data->feature_caps & 0x1;
> +	info->amd_vsdb.min_frame_rate = data->min_vfreq;
> +	info->amd_vsdb.max_frame_rate = data->max_vfreq;
> +	info->amd_vsdb.freesync_vcp_code = data->freesync_vcp_code;
> +
> +	drm_parse_amd_vsdb_common(info, &data->common);
> +}
> +
> +static void drm_parse_amd_vsdb_v2(struct drm_display_info *info,
> +				  const struct amd_vsdb_v2_payload *data)
> +{
> +	info->amd_vsdb.luminance_range1.max_luminance = data->lum1_max;
> +	info->amd_vsdb.luminance_range1.min_luminance = data->lum1_min;
> +	info->amd_vsdb.luminance_range2.max_luminance = data->lum2_max;
> +	info->amd_vsdb.luminance_range2.min_luminance = data->lum2_min;
> +
> +	drm_parse_amd_vsdb_v1(info, &data->v1);
> +}
> +
> +static void drm_parse_amd_vsdb_v3(struct drm_display_info *info,
> +				  const struct amd_vsdb_v3_payload *data,
> +				  int payload_len)
> +{
> +	u16 max_frame_rate;
> +
> +	info->amd_vsdb.replay_mode = data->v2.v1.feature_caps & 0x40;
> +	info->amd_vsdb.panel_type = (data->v2.cs_eotf_support & 0xC0) >> 6;
> +
> +	drm_parse_amd_vsdb_v2(info, &data->v2);
> +
> +	/* vfreq is provided in a different set of fields for v3. */
> +	max_frame_rate = data->max_vfreq_ext_low |
> +			 (data->max_vfreq_ext_high & 0x3) << 8;
> +
> +	/*
> +	 * The AMD VSDB v3 payload length is variable (15..21 bytes).
> +	 * All fields through max_vfreq_ext_high (byte 14) are always
> +	 * present, but data->extra[] (bytes 15+) may not be, so any access
> +	 * to extra[] must be guarded with a runtime length check to
> +	 * avoid out-of-bounds reads on shorter (but spec-valid) payloads.
> +	 */
> +	if (payload_len >= AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN)
> +		max_frame_rate |= (data->extra[5] & 0x3) << 10;
> +
> +	info->amd_vsdb.max_frame_rate = max_frame_rate;
> +}
> +
>   static void drm_parse_amd_vsdb(struct drm_connector *connector,
>   			       const struct cea_db *db)
>   {
>   	struct drm_display_info *info = &connector->display_info;
>   	const u8 *data = cea_db_data(db);
> -	const struct amd_vsdb_v3_payload *p;
> +	int payload_len = cea_db_payload_len(db);
> +	u8 version;
>   
> -	p = (const struct amd_vsdb_v3_payload *)data;
> +	version = ((const struct amd_vsdb_common_payload *)data)->version;
>   
> -	if (p->version != 0x03) {
> +	if (version < 1 || version > 3) {
>   		drm_dbg_kms(connector->dev,
>   			    "[CONNECTOR:%d:%s] Unsupported AMD VSDB version %u\n",
> -			    connector->base.id, connector->name, p->version);
> +			    connector->base.id, connector->name, version);
>   		return;
>   	}
>   
> -	info->amd_vsdb.version = p->version;
> -	info->amd_vsdb.replay_mode = p->feature_caps & 0x40;
> -	info->amd_vsdb.panel_type = (p->cs_eotf_support & 0xC0) >> 6;
> -	info->amd_vsdb.luminance_range1.max_luminance = p->lum1_max;
> -	info->amd_vsdb.luminance_range1.min_luminance = p->lum1_min;
> -	info->amd_vsdb.luminance_range2.max_luminance = p->lum2_max;
> -	info->amd_vsdb.luminance_range2.min_luminance = p->lum2_min;
> +	if (payload_len < amd_vsdb_min_len[version]) {
> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] AMD VSDB v%u payload too short (%d bytes)\n",
> +			    connector->base.id, connector->name, version, payload_len);
> +		return;
> +	}
>   
> -	/*
> -	 * The AMD VSDB v3 payload length is variable (15..20 bytes).
> -	 * All fields through p->rsvd1 (byte 14) are always present,
> -	 * but p->extra[] (bytes 15+) may not be.  Any future access to
> -	 * extra[] must be guarded with a runtime length check to avoid
> -	 * out-of-bounds reads on shorter (but spec-valid) payloads.
> -	 * For example:
> -	 *
> -	 *   int len = cea_db_payload_len(db);
> -	 *
> -	 *   if (len > AMD_VSDB_V3_PAYLOAD_MIN_LEN)
> -	 *       info->amd_vsdb.foo = p->extra[0];
> -	 */
> +	switch (version) {
> +	case 3:
> +		drm_parse_amd_vsdb_v3(info, (const struct amd_vsdb_v3_payload *)data,
> +				      payload_len);
> +		break;
> +	case 2:
> +		drm_parse_amd_vsdb_v2(info, (const struct amd_vsdb_v2_payload *)data);
> +		break;
> +	case 1:
> +		drm_parse_amd_vsdb_v1(info, (const struct amd_vsdb_v1_payload *)data);
> +		break;

Since we can parse as a ladder a hypothetical future v4 would /probably/ 
start with a v3 block.

How would you feel about adding a default block here to handle the case 
of a newer version?  Maybe show a loud warning that it's being treated 
as v3 and then call drm_parse_amd_vsdb_v3()?

> +	}
>   }
>   
>   static void drm_parse_cea_ext(struct drm_connector *connector,
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 5f5ca023cd65..0914a2bd8ef1 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -697,7 +697,7 @@ enum drm_bus_flags {
>    * struct drm_amd_vsdb_info - AMD-specific VSDB information
>    *
>    * This structure holds information parsed from the AMD Vendor-Specific Data
> - * Block (VSDB) version 3.
> + * Block (VSDB) versions 1 to 3.
>    */
>   struct drm_amd_vsdb_info {
>   	/**
> @@ -705,6 +705,26 @@ struct drm_amd_vsdb_info {
>   	 */
>   	u8 version;
>   
> +	/**
> +	 * @freesync_supported: FreeSync (variable refresh rate) supported by panel
> +	 */
> +	bool freesync_supported;
> +
> +	/**
> +	 * @min_frame_rate: FreeSync minimum refresh rate in Hz
> +	 */
> +	u16 min_frame_rate;
> +
> +	/**
> +	 * @max_frame_rate: FreeSync maximum refresh rate in Hz
> +	 */
> +	u16 max_frame_rate;
> +
> +	/**
> +	 * @freesync_vcp_code: MCCS VCP code for FreeSync
> +	 */
> +	u8 freesync_vcp_code;
> +
>   	/**
>   	 * @replay_mode: Panel Replay supported
>   	 */

