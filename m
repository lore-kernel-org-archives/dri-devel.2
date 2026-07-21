Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28C1C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E7310EAC4;
	Tue, 21 Jul 2026 17:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W53qLrMv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECCF10EAC4;
 Tue, 21 Jul 2026 17:00:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BE8F600D8;
 Tue, 21 Jul 2026 17:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D771F1F000E9;
 Tue, 21 Jul 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784653237;
 bh=4u3yqzBlcqOhlH1BxlMM1UKVS718nzSRJ+577jUOt+8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=W53qLrMvh8bxOI6nOYXWdSeOqDGoBU4O5TvmuTeUM7eaPzdeFlwdanJfIA0ZjEKi3
 yUPQnBkeUKMead5VmH6RNVGQOUEJ74qMzwf8DJIKKahirQe/0Jbcud1UI0lwJfsel1
 p8IOYJ4TyVRR7l+ePt4QUVTfOYQcPTMKhZB1lOTE8f6R3nZZE8TgNjZTlhv6L6ZyXC
 uvM9vKsOpQgY1/7fYjZBDitwa235pixG98kwl+9XvggI85+TTj4H4aka/NyD85OlWP
 iy8lO37gCNLEtwVDoOflCs0NLYE02qjf8+s3WiyKsnbf2PMhTqa1MemEtamqrq2fkc
 pGtKPntjos9Gg==
Message-ID: <0c3920b2-781d-47b8-a3dd-82a2667ba7df@kernel.org>
Date: Tue, 21 Jul 2026 12:00:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh range
Content-Language: en-US
To: Alex Huang <Alex.Huang2@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, alex.hung@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
 <20260721164430.2121326-2-Alex.Huang2@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260721164430.2121326-2-Alex.Huang2@amd.com>
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

On 7/21/26 11:44, Alex Huang wrote:
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
> ---
>   drivers/gpu/drm/drm_edid.c  | 134 ++++++++++++++++++++++++++++--------
>   include/drm/drm_connector.h |  22 +++++-
>   2 files changed, 126 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac761..c9452066b9be 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -101,20 +101,58 @@ enum drm_edid_internal_quirk {
>   #define MICROSOFT_IEEE_OUI	0xca125c
>   #define AMD_IEEE_OUI        0x00001A
>   
> +#define AMD_VSDB_V1_PAYLOAD_LEN 8
> +#define AMD_VSDB_V2_PAYLOAD_LEN 13
>   #define AMD_VSDB_V3_PAYLOAD_MIN_LEN 15
> -#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 20
> +#define AMD_VSDB_V3_PAYLOAD_MAX_LEN 21
> +
> +#define AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN 21
> +
> +struct amd_vsdb_common_payload {
> +	u8 oui[3];
> +	u8 version;
> +} __packed;
> +
> +struct amd_vsdb_v1_payload {
> +	u8 oui[3];
> +	u8 version;

Since this is just the common header would it be helpful to have here:

	struct amd_vsdb_common_payload common;

> +	u8 feature_caps;
> +	u8 min_vfreq;
> +	u8 max_vfreq;
> +	u8 freesync_vcp_code;
> +} __packed;
> +
> +struct amd_vsdb_v2_payload {
> +	u8 oui[3];
> +	u8 version;
> +	u8 feature_caps;
> +	u8 min_vfreq;
> +	u8 max_vfreq;
> +	u8 freesync_vcp_code;

Similarly would it be helpful to have here:

	struct amd_vsdb_common_payload v1;

> +	u8 cs_eotf_support;
> +	u8 lum1_max;
> +	u8 lum1_min;
> +	u8 lum2_max;
> +	u8 lum2_min;
> +} __packed;
>   
>   struct amd_vsdb_v3_payload {
>   	u8 oui[3];
>   	u8 version;
>   	u8 feature_caps;
> -	u8 rsvd0[3];
> +	u8 min_vfreq;
> +	u8 max_vfreq;
> +	u8 freesync_vcp_code;
>   	u8 cs_eotf_support;
>   	u8 lum1_max;
>   	u8 lum1_min;
>   	u8 lum2_max;
>   	u8 lum2_min;

And then

	struct amd_vsdb_common_payload v2;

> -	u8 rsvd1[2];
> +	u8 max_vfreq_ext_low;
> +	/*
> +	 * byte 14: bits 0-1 extend MSB of max refresh rate
> +	 */
> +	u8 max_vfreq_ext_high;
>   	/*
>   	 * Bytes beyond AMD_VSDB_V3_PAYLOAD_MIN_LEN are optional; a
>   	 * monitor may provide a payload as short as 15 bytes.  Always
> @@ -5231,7 +5269,7 @@ static bool cea_db_is_microsoft_vsdb(const struct cea_db *db)
>   static bool cea_db_is_amd_vsdb(const struct cea_db *db)
>   {
>   	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
> -		cea_db_payload_len(db) >= AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
> +		cea_db_payload_len(db) >= AMD_VSDB_V1_PAYLOAD_LEN &&
>   		cea_db_payload_len(db) <= AMD_VSDB_V3_PAYLOAD_MAX_LEN;
>   }
>   
> @@ -6431,43 +6469,81 @@ static void drm_parse_microsoft_vsdb(struct drm_connector *connector,
>   		    connector->base.id, connector->name, version, db[5]);
>   }
>   
> +static void drm_parse_amd_vsdb_v1(struct drm_display_info *info,
> +				  const u8 *data)
> +{
> +	const struct amd_vsdb_v1_payload *p =
> +		(const struct amd_vsdb_v1_payload *)data;
> +
> +	info->amd_vsdb.freesync_supported = p->feature_caps & 0x1;
> +	info->amd_vsdb.min_frame_rate = p->min_vfreq;
> +	info->amd_vsdb.max_frame_rate = p->max_vfreq;
> +	info->amd_vsdb.freesync_vcp_code = p->freesync_vcp_code;
> +}
> +
> +static void drm_parse_amd_vsdb_v2(struct drm_display_info *info,
> +				  const u8 *data)
> +{
> +	const struct amd_vsdb_v2_payload *p =
> +		(const struct amd_vsdb_v2_payload *)data;
> +
> +	info->amd_vsdb.luminance_range1.max_luminance = p->lum1_max;
> +	info->amd_vsdb.luminance_range1.min_luminance = p->lum1_min;
> +	info->amd_vsdb.luminance_range2.max_luminance = p->lum2_max;
> +	info->amd_vsdb.luminance_range2.min_luminance = p->lum2_min;
> +}
> +
> +static void drm_parse_amd_vsdb_v3(struct drm_display_info *info,
> +				  const u8 *data, int payload_len)
> +{
> +	const struct amd_vsdb_v3_payload *p =
> +		(const struct amd_vsdb_v3_payload *)data;
> +	u16 max_frame_rate;
> +
> +	info->amd_vsdb.replay_mode = p->feature_caps & 0x40;
> +	info->amd_vsdb.panel_type = (p->cs_eotf_support & 0xC0) >> 6;
> +
> +	/* vfreq is provded in a different set of fields for v3. */
> +	max_frame_rate = p->max_vfreq_ext_low |
> +			 (p->max_vfreq_ext_high & 0x3) << 8;
> +
> +	/*
> +	 * The AMD VSDB v3 payload length is variable (15..21 bytes).
> +	 * All fields through max_vfreq_ext_high (byte 14) are always
> +	 * present, but p->extra[] (bytes 15+) may not be, so any access
> +	 * to extra[] must be guarded with a runtime length check to
> +	 * avoid out-of-bounds reads on shorter (but spec-valid) payloads.
> +	 */
> +	if (payload_len >= AMD_VSDB_V3_MAX_VFREQ_EXT2_LEN)
> +		max_frame_rate |= (p->extra[5] & 0x3) << 10;
> +
> +	info->amd_vsdb.max_frame_rate = max_frame_rate;
> +}
> +

If you follow my suggestions  you might be able to do a ladder where
drm_parse_amd_vsdb_v3() calls drm_parse_amd_vsdb_v2() with those pieces 
and that calls drm_parse_amd_vsdb_v1() and that calls 
drm_parse_amd_vsdb_common() or similar.


>   static void drm_parse_amd_vsdb(struct drm_connector *connector,
>   			       const struct cea_db *db)
>   {
>   	struct drm_display_info *info = &connector->display_info;
>   	const u8 *data = cea_db_data(db);
> -	const struct amd_vsdb_v3_payload *p;
> -
> -	p = (const struct amd_vsdb_v3_payload *)data;
> +	const struct amd_vsdb_common_payload *common =
> +		(const struct amd_vsdb_common_payload *)data;
>   
> -	if (p->version != 0x03) {
> +	if (common->version < 1 || common->version > 3) {
>   		drm_dbg_kms(connector->dev,
>   			    "[CONNECTOR:%d:%s] Unsupported AMD VSDB version %u\n",
> -			    connector->base.id, connector->name, p->version);
> +			    connector->base.id, connector->name, common->version);
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
> +	info->amd_vsdb.version = common->version;
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
> +	drm_parse_amd_vsdb_v1(info, data);
> +
> +	if (common->version >= 2)
> +		drm_parse_amd_vsdb_v2(info, data);
> +
> +	if (common->version >= 3)
> +		drm_parse_amd_vsdb_v3(info, data, cea_db_payload_len(db));
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

