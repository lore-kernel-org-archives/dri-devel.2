Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77681CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 10:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B93E10E18D;
	Tue, 26 May 2026 10:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PPhnhVCM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A502510E18D
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779792761; x=1811328761;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ttkr2+0dIaHFtf//U2hQIElnpEpz3WPD5vAJ8wxCnq0=;
 b=PPhnhVCMsZL3mwYwd4xihMU+TpqMkM4jc3+W32cic8uFSjoojrC6A31N
 FOvhaGnX1tqyXbWVKpM9n2VWgLkEobTV9fCEIE3MoRVy9at77Phq5vV0o
 Z+lvAS9hbhug+o11zH6v7eVYaIuHi4a2CGT+KS0Rz0ctu0cmVT55UIQax
 hhxIdVh+ARSVsQ3ju1pg+0ECHarAF697zb/czgQqDlWefg/Z4Tu0sAjs0
 4TMHQJqAod+AUFgqq+lRWmJ35A+VWv6y2elhiyq1Tpr5lgWC37ZLdwUhD
 rWdaNsIjAIC8KMqsgDDHhXAzxtkQVnN9vwNdTWnPe5aTPIGGwSjFe4jH7 g==;
X-CSE-ConnectionGUID: IeNmeM3rSCSyOVsI06CZtA==
X-CSE-MsgGUID: fV7qeWZiTMualhq+TJ3umw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="79748353"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="79748353"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 03:52:40 -0700
X-CSE-ConnectionGUID: q8yNucOFQpKAtsW/f4s2Fg==
X-CSE-MsgGUID: DchafCYYTqWf0NNxqXDEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="241946828"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.244.104])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 03:52:34 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v3 4/4] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
In-Reply-To: <20260526-scdc-link-health-v3-4-59e4a4aaead1@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com>
 <20260526-scdc-link-health-v3-4-59e4a4aaead1@collabora.com>
Date: Tue, 26 May 2026 13:52:31 +0300
Message-ID: <a14c938ec67d501967873622e5d2c3c40765cc1d@intel.com>
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

On Tue, 26 May 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> HDMI 2.1 redefines previously reserved fields in SCDC for various new
> uses. No version check needs to be performed, as an HDMI 2.0 sink's
> reserved SCDC fields are well-defined to be 0, and any zero-ness of
> these fields for an HDMI 2.0 sink is not a surprise for SCDC parsers for
> HDMI 2.1.
>
> Implement reading and outputting these fields over debugfs.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_scdc_helper.c | 154 ++++++++++++++++++++++++++----
>  include/drm/display/drm_scdc.h            |   9 ++
>  include/drm/display/drm_scdc_helper.h     |  85 ++++++++++++++---
>  3 files changed, 218 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> index 75a59c6fc7a5..b5a866372b0f 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> @@ -21,6 +21,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/export.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> @@ -63,6 +64,38 @@ struct scdc_debugfs_priv {
>  	struct drm_scdc_state state;
>  };
>  
> +static __pure const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)

There are a total of only 71 __pure usages in the kernel. Is this
helpful for a static function where the compiler can figure it out by
itself?

> +{
> +	switch (rate) {
> +	case SCDC_FRL_RATE_OFF:
> +		return "Off";
> +	case SCDC_FRL_RATE_3X3:
> +		return "3 Gbit/s x 3 lanes";
> +	case SCDC_FRL_RATE_6X3:
> +		return "6 Gbit/s x 3 lanes";
> +	case SCDC_FRL_RATE_6X4:
> +		return "6 Gbit/s x 4 lanes";
> +	case SCDC_FRL_RATE_8X4:
> +		return "8 Gbit/s x 4 lanes";
> +	case SCDC_FRL_RATE_10X4:
> +		return "10 Gbit/s x 4 lanes";
> +	case SCDC_FRL_RATE_12X4:
> +		return "12 Gbit/s x 4 lanes";
> +	case SCDC_FRL_RATE_RESV_7:
> +	case SCDC_FRL_RATE_RESV_8:
> +	case SCDC_FRL_RATE_RESV_9:
> +	case SCDC_FRL_RATE_RESV_10:
> +	case SCDC_FRL_RATE_RESV_11:
> +	case SCDC_FRL_RATE_RESV_12:
> +	case SCDC_FRL_RATE_RESV_13:
> +	case SCDC_FRL_RATE_RESV_14:
> +	case SCDC_FRL_RATE_RESV_15:
> +		return "(Reserved)";
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  /**
>   * drm_scdc_read - read a block of data from SCDC
>   * @adapter: I2C controller
> @@ -309,10 +342,57 @@ int drm_scdc_read_status0_flags(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_scdc_read_status0_flags);
>  
> +/**
> + * drm_scdc_read_status1_2_flags - Read SCDC "Status Flags" 1 and 2 Registers
> + * @connector: pointer to &struct drm_connector to issue the scdc request on
> + * @flags: pointer to the caller's &struct drm_scdc_status_flags to output to
> + *
> + * Reads the SCDC Status Flags 1 and 2 registers, and outputs their contents to
> + * the destination @flags. Contents of @flags.status1 and @flags.status2 are
> + * only valid if function returns 0.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int drm_scdc_read_status1_2_flags(struct drm_connector *connector,
> +				  struct drm_scdc_status_flags *flags)
> +{
> +	int ret;
> +
> +	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_FLT_UPDATE);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_1, &flags->status1.data);
> +	if (ret)
> +		return ret;
> +
> +	return drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_2, &flags->status2.data);
> +}
> +EXPORT_SYMBOL(drm_scdc_read_status1_2_flags);
> +
> +#define ERR_DET_OFF(x) ((x) - SCDC_ERR_DET_0_L)
> +
> +static int __pure scdc_err_cnt_buf_idx(unsigned int lane)
> +{
> +	switch (lane) {
> +	case 0:
> +		return ERR_DET_OFF(SCDC_ERR_DET_0_L);
> +	case 1:
> +		return ERR_DET_OFF(SCDC_ERR_DET_1_L);
> +	case 2:
> +		return ERR_DET_OFF(SCDC_ERR_DET_2_L);
> +	case 3:
> +		return ERR_DET_OFF(SCDC_ERR_DET_3_L);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  /**
>   * drm_scdc_read_error_counters - Read and clear SCDC error counters
>   * @connector: pointer to &struct drm_connector to issue the scdc request on
> - * @counter: Caller's u16 array with 3 elements to write the counter values into
> + * @counter: Caller's u16 array with 4 elements to write the counter values into
> + * @num_lanes: number of active lanes, either 3 or 4
>   *
>   * Read the SCDC channel error counters. If the count of channel *n* is valid,
>   * write it into counter[n]. Otherwise, set counter[n] to 0. Reads all counters
> @@ -320,18 +400,31 @@ EXPORT_SYMBOL(drm_scdc_read_status0_flags);
>   *
>   * Returns: %0 on success, negative errno on error.
>   */
> -int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3])
> +int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[4],
> +				 unsigned int num_lanes)
>  {
> -	u8 buf[7] = { 0 };
> +	unsigned int buf_sz;
> +	u8 buf[9] = { 0 };

I'd use {} for initialization.

>  	int ret;
>  	u8 sum = 0;
> -	int i;
> +	int i, idx;
> +
> +	switch (num_lanes) {
> +	case 3:
> +		buf_sz = 7;
> +		break;
> +	case 4:
> +		buf_sz = 9;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
>  	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_CED_UPDATE);
>  	if (ret)
>  		return ret;
>  
> -	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
> +	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, buf_sz);
>  	if (ret)
>  		return ret;
>  
> @@ -339,24 +432,23 @@ int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]
>  	 * Verify the "checksum", i.e. sum up everything including the checksum
>  	 * register as a wrapping unsigned 8-bit addition and verify it's 0.
>  	 */
> -	for (i = 0; i < ARRAY_SIZE(buf); i++)
> +	for (i = 0; i < buf_sz; i++)
>  		sum = wrapping_add(u8, sum, buf[i]);
>  
>  	if (sum)
>  		return -EPROTO;
>  
> -	for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
> -		if (buf[i + 1] & SCDC_CHANNEL_VALID)
> -			counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
> +	for (i = 0; i < num_lanes; i++) {
> +		idx = scdc_err_cnt_buf_idx(i);
> +		if (buf[idx + 1] & SCDC_CHANNEL_VALID)
> +			counter[i] = buf[idx] | (buf[idx + 1] & ~SCDC_CHANNEL_VALID) << 8;
>  		else
> -			counter[i / 2] = 0;
> -
> -		buf[i] = 0;
> -		buf[i + 1] = 0;
> +			counter[i] = 0;
>  	}
> -	buf[ARRAY_SIZE(buf) - 1] = 0;
>  
> -	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
> +	memset(buf, 0, buf_sz);
> +
> +	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, buf_sz);
>  }
>  EXPORT_SYMBOL(drm_scdc_read_error_counters);
>  
> @@ -376,6 +468,7 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
>  	u8 upd_flags[2] = { 0 };
>  	struct i2c_adapter *ddc;
>  	struct drm_scdc *scdc;
> +	int num_lanes;
>  	int ret;
>  	u8 val;
>  
> @@ -397,6 +490,19 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
>  
>  	state->scrambling_detected = drm_scdc_get_scrambling_status(connector);
>  
> +	ret = drm_scdc_readb(ddc, SCDC_CONFIG_1, &val);
> +	if (ret)
> +		return ret;
> +
> +	state->rate = FIELD_GET(SCDC_FRL_RATE, val);
> +	num_lanes = drm_scdc_num_frl_lanes(state->rate);
> +	if (num_lanes < 0)
> +		return num_lanes;
> +	if (!num_lanes)
> +		num_lanes = 3;
> +
> +	state->ffe_levels = FIELD_GET(SCDC_FFE_LEVELS, val);
> +
>  	ret = drm_scdc_read(ddc, SCDC_UPDATE_0, &upd_flags, sizeof(upd_flags));
>  	if (ret)
>  		return ret;
> @@ -407,8 +513,15 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
>  			return ret;
>  	}
>  
> +	if (upd_flags[0] & SCDC_FLT_UPDATE) {
> +		ret = drm_scdc_read_status1_2_flags(connector, &state->stf);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (upd_flags[0] & SCDC_CED_UPDATE) {
> -		ret = drm_scdc_read_error_counters(connector, state->error_count);
> +		ret = drm_scdc_read_error_counters(connector, state->error_count,
> +						   num_lanes);
>  		if (ret)
>  			return ret;
>  	}
> @@ -456,6 +569,8 @@ static int scdc_status_show(struct seq_file *m, void *data)
>  
>  	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
>  	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
> +	scdc_print_str(m, "FRL Rate", drm_scdc_frl_rate_str(st->rate));
> +	scdc_print_dec(m, "FFE Levels", st->ffe_levels);
>  
>  	if (st->tmds_bclk_x40)
>  		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
> @@ -466,10 +581,17 @@ static int scdc_status_show(struct seq_file *m, void *data)
>  	scdc_print_flag(m, "Channel 0 Locked", st->stf.status0.flags.ch0_locked);
>  	scdc_print_flag(m, "Channel 1 Locked", st->stf.status0.flags.ch1_locked);
>  	scdc_print_flag(m, "Channel 2 Locked", st->stf.status0.flags.ch2_locked);
> +	if (drm_scdc_num_frl_lanes(st->rate) == 4)
> +		scdc_print_flag(m, "Lane 3 Locked", st->stf.status0.flags.ln3_locked);
> +
> +	scdc_print_flag(m, "Sink Ready For Link Training", st->stf.status0.flags.flt_ready);
> +	scdc_print_flag(m, "Sink Failed To Decode DSC", st->stf.status0.flags.dsc_fail);
>  
>  	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
>  	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
>  	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
> +	if (drm_scdc_num_frl_lanes(st->rate) == 4)
> +		scdc_print_dec(m, "Lane 3 Errors", st->error_count[3]);
>  
>  	return 0;
>  
> diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scdc.h
> index 3d58f37e8ed8..56cd909edac9 100644
> --- a/include/drm/display/drm_scdc.h
> +++ b/include/drm/display/drm_scdc.h
> @@ -29,6 +29,7 @@
>  #define SCDC_SOURCE_VERSION 0x02
>  
>  #define SCDC_UPDATE_0 0x10
> +#define  SCDC_FLT_UPDATE (1 << 5)
>  #define  SCDC_READ_REQUEST_TEST (1 << 2)
>  #define  SCDC_CED_UPDATE (1 << 1)
>  #define  SCDC_STATUS_UPDATE (1 << 0)
> @@ -46,6 +47,10 @@
>  #define SCDC_CONFIG_0 0x30
>  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
>  
> +#define SCDC_CONFIG_1 0x31
> +#define  SCDC_FRL_RATE   0x0f
> +#define  SCDC_FFE_LEVELS 0xf0
> +
>  #define SCDC_STATUS_FLAGS_0 0x40
>  #define  SCDC_CH2_LOCK (1 << 3)
>  #define  SCDC_CH1_LOCK (1 << 2)
> @@ -54,6 +59,7 @@
>  #define  SCDC_CLOCK_DETECT (1 << 0)
>  
>  #define SCDC_STATUS_FLAGS_1 0x41
> +#define SCDC_STATUS_FLAGS_2 0x42
>  
>  #define SCDC_ERR_DET_0_L 0x50
>  #define SCDC_ERR_DET_0_H 0x51
> @@ -65,6 +71,9 @@
>  
>  #define SCDC_ERR_DET_CHECKSUM 0x56
>  
> +#define SCDC_ERR_DET_3_L 0x57
> +#define SCDC_ERR_DET_3_H 0x58
> +
>  #define SCDC_TEST_CONFIG_0 0xc0
>  #define  SCDC_TEST_READ_REQUEST (1 << 7)
>  #define  SCDC_TEST_READ_REQUEST_DELAY(x) ((x) & 0x7f)
> diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
> index c066c1158275..a1b73f0be73f 100644
> --- a/include/drm/display/drm_scdc_helper.h
> +++ b/include/drm/display/drm_scdc_helper.h
> @@ -24,6 +24,7 @@
>  #ifndef DRM_SCDC_HELPER_H
>  #define DRM_SCDC_HELPER_H
>  
> +#include <linux/errno.h>
>  #include <linux/types.h>
>  
>  #include <drm/display/drm_scdc.h>
> @@ -40,10 +41,10 @@ struct drm_scdc_status_flags {
>  			bool ch0_locked : 1;
>  			bool ch1_locked : 1;
>  			bool ch2_locked : 1;
> -			bool rsvd_4 : 1;
> +			bool ln3_locked : 1;
>  			bool rsvd_5 : 1;
> -			bool rsvd_6 : 1;
> -			bool rsvd_7 : 1;
> +			bool flt_ready : 1;
> +			bool dsc_fail : 1;
>  		} flags __packed;
>  		u8 data;
>  	} status0;
> @@ -51,19 +52,68 @@ struct drm_scdc_status_flags {
>  	/* Status Register 1 */
>  	union {
>  		struct {
> -			bool rsvd_0 : 1;
> -			bool rsvd_1 : 1;
> -			bool rsvd_2 : 1;
> -			bool rsvd_3 : 1;
> -			bool rsvd_4 : 1;
> -			bool rsvd_5 : 1;
> -			bool rsvd_6 : 1;
> -			bool rsvd_7 : 1;
> +			u8 ln0_training_pattern : 4;
> +			u8 ln1_training_pattern : 4;
>  		} flags __packed;
>  		u8 data;
>  	} status1;
> +
> +	/* Status Register 2 */
> +	union {
> +		struct {
> +			u8 ln2_training_pattern : 4;
> +			u8 ln3_training_pattern : 4;
> +		} flags __packed;
> +		u8 data;
> +	} status2;

Here too, bitfield bit order is implementation defined. See my other
reply in the thread.

BR,
Jani.

> +};
> +
> +enum drm_scdc_frl_rate {
> +	SCDC_FRL_RATE_OFF = 0,
> +	SCDC_FRL_RATE_3X3 = 1,
> +	SCDC_FRL_RATE_6X3 = 2,
> +	SCDC_FRL_RATE_6X4 = 3,
> +	SCDC_FRL_RATE_8X4 = 4,
> +	SCDC_FRL_RATE_10X4 = 5,
> +	SCDC_FRL_RATE_12X4 = 6,
> +	SCDC_FRL_RATE_RESV_7 = 7,
> +	SCDC_FRL_RATE_RESV_8 = 8,
> +	SCDC_FRL_RATE_RESV_9 = 9,
> +	SCDC_FRL_RATE_RESV_10 = 10,
> +	SCDC_FRL_RATE_RESV_11 = 11,
> +	SCDC_FRL_RATE_RESV_12 = 12,
> +	SCDC_FRL_RATE_RESV_13 = 13,
> +	SCDC_FRL_RATE_RESV_14 = 14,
> +	SCDC_FRL_RATE_RESV_15 = 15
>  };
>  
> +/**
> + * drm_scdc_num_frl_lanes - get number of lanes for a given FRL rate
> + * @rate: one of &enum drm_scdc_frl_rate
> + *
> + * For a given @rate, return the number of lanes it uses.
> + *
> + * Returns: %-EINVAL if @rate is not a valid FRL rate, or the number of lanes
> + * for a given &enum drm_scdc_frl_rate on success (including %0 for "off")
> + */
> +static inline __pure int drm_scdc_num_frl_lanes(enum drm_scdc_frl_rate rate)
> +{
> +	switch (rate) {
> +	case SCDC_FRL_RATE_OFF:
> +		return 0;
> +	case SCDC_FRL_RATE_3X3:
> +	case SCDC_FRL_RATE_6X3:
> +		return 3;
> +	case SCDC_FRL_RATE_6X4:
> +	case SCDC_FRL_RATE_8X4:
> +	case SCDC_FRL_RATE_10X4:
> +	case SCDC_FRL_RATE_12X4:
> +		return 4;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  struct drm_scdc_state {
>  	/** @stf: contents of the status flag registers */
>  	struct drm_scdc_status_flags stf;
> @@ -76,8 +126,12 @@ struct drm_scdc_state {
>  	 * clock period, false if it's 1/10th of the clock period.
>  	 */
>  	bool tmds_bclk_x40;
> -	/** @error_count: character error counts for each channel */
> -	u16 error_count[3];
> +	/** @rate: FRL rate set by the source */
> +	enum drm_scdc_frl_rate rate : 4;
> +	/** @ffe_levels: The FFE levels for @rate set by the source */
> +	u8 ffe_levels : 4;
> +	/** @error_count: character error counts for each channel/link */
> +	u16 error_count[4];
>  };
>  
>  int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
> @@ -128,9 +182,12 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool se
>  
>  int drm_scdc_read_status0_flags(struct drm_connector *connector,
>  				struct drm_scdc_status_flags *flags);
> +int drm_scdc_read_status1_2_flags(struct drm_connector *connector,
> +				  struct drm_scdc_status_flags *flags);
>  int drm_scdc_read_state(struct drm_connector *connector,
>  			struct drm_scdc_state *state);
> -int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]);
> +int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[4],
> +				 unsigned int num_lanes);
>  void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
>  
>  #endif

-- 
Jani Nikula, Intel
