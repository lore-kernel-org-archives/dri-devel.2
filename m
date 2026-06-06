Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A2CD8C8C
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 11:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02C6112DEA;
	Sat,  6 Jun 2026 11:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jYXVjPNh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34486112DEA
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 11:43:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F032040B2F;
 Sat,  6 Jun 2026 11:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239451F00893;
 Sat,  6 Jun 2026 11:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780746190;
 bh=I7ltkJ91HzIJ+nexwVW+w9dICcMV+8jdmBg+F4Qnwas=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=jYXVjPNh49t17HOaj3mtiHUw1w8MLv5Xe/k0iagaqImOhVdTcqK562Nydx20ai7/v
 /YvlXYVAEhv57faTA2lKHKTnlLAgjPHiU1ctDh0hqt0q1Aznb1gT8YczU0itvJiHG2
 x8SQufEVDdhtvfP+dR6jSEpNL91PJMAZeyacFds9Lr5UV7mo06rVvs2sSmprb0NjWR
 AZUhjAx6ZPv1Zk5wBzuzqIiLgr8byH/0/f6nV55yLWvMjQGwfGZZMHXhfD8mRcPazs
 RQS7NPmqF32S75s/2cf6ESCRZTJ0hEffGa3jpmr/AqEEfxIjlOzEurivwu24W/7H0p
 7rA9cwKWnJfRw==
Message-ID: <0ac406bd-d565-4037-a498-4273df2765dd@kernel.org>
Date: Sat, 6 Jun 2026 13:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v5 2/4] drm/scdc-helper: Add scdc_status debugfs entry
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20260604-scdc-link-health-v5-0-11173b0ac3de@collabora.com>
 <20260604-scdc-link-health-v5-2-11173b0ac3de@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <20260604-scdc-link-health-v5-2-11173b0ac3de@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 04/06/2026 17:52, Nicolas Frattaroli wrote:
> SCDC provides status information on the current display link. At the
> very least, it may be useful to expose this info through debugfs.
> 
> Add a debugfs entry for it under the connector, which displays a few
> more details parsed out of the SCDC registers. A new
> drm_scdc_debugfs_init function can be called by the connector
> implementation to initialise the debugfs file.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_scdc_helper.c | 184 ++++++++++++++++++++++++++++++
>  include/drm/display/drm_scdc_helper.h     |  32 ++++++
>  2 files changed, 216 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> index 8403f2390ab6..d98bcb8ce748 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> @@ -24,11 +24,14 @@
>  #include <linux/export.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/overflow.h>
>  
>  #include <drm/display/drm_scdc_helper.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_device.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_print.h>
>  
>  /**
> @@ -55,6 +58,11 @@
>  
>  #define SCDC_I2C_SLAVE_ADDRESS 0x54
>  
> +struct scdc_debugfs_priv {
> +	struct drm_connector *connector;
> +	struct drm_scdc_state state;
> +};
> +
>  /**
>   * drm_scdc_read - read a block of data from SCDC
>   * @adapter: I2C controller
> @@ -276,3 +284,179 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
>  	return true;
>  }
>  EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
> +
> +static void
> +drm_scdc_parse_status0_flags(u8 val, struct drm_scdc_status_flags *flags)
> +{
> +	flags->clock_detected = val & SCDC_CLOCK_DETECT;
> +	flags->ch0_locked = val & SCDC_CH0_LOCK;
> +	flags->ch1_locked = val & SCDC_CH1_LOCK;
> +	flags->ch2_locked = val & SCDC_CH2_LOCK;
> +}
> +
> +static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[3])
> +{
> +	u8 sum = 0;
> +	int i;
> +
> +	for (i = SCDC_ERR_DET_0_L; i <= SCDC_ERR_DET_CHECKSUM ; i++)
> +		sum = wrapping_add(u8, sum, scdc[i]);
> +
> +	if (sum)
> +		return -EPROTO;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (scdc[SCDC_ERR_DET_0_H + i * 2] & SCDC_CHANNEL_VALID)
> +			counter[i] =  (scdc[SCDC_ERR_DET_0_H + i * 2] &
> +				       ~SCDC_CHANNEL_VALID) << 8 |
> +				       scdc[SCDC_ERR_DET_0_L + i * 2];
> +		else
> +			counter[i] = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_scdc_read_state - Update state from SCDC
> + * @connector: pointer to a &struct drm_connector on which to operate on
> + * @state: pointer to a &struct drm_scdc_state to fill
> + *
> + * Reads the entire 256 byte SCDC state and parses it.
> + *
> + * Returns: %0 on success, negative errno on failure.
> + */
> +int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *state)
> +{
> +	struct i2c_adapter *ddc;
> +	struct drm_scdc *scdc;
> +	u8 *buf = state->scdc;
> +	int ret;
> +
> +	if (!state || !connector)
> +		return -ENODEV;
> +
> +	scdc = &connector->display_info.hdmi.scdc;
> +	ddc = connector->ddc;
> +
> +	if (!scdc->supported)
> +		return -EOPNOTSUPP;
> +
> +	/* Read in 128-byte chunks, to work around DP<->HDMI converters with issues. */
> +	ret = drm_scdc_read(ddc, 0, buf, 128);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_scdc_read(ddc, 127, &buf[127], 128);

Huh? Shouldn't this be: ret = drm_scdc_read(ddc, 128, &buf[128], 128);

I'm unable to test this series at the moment: I'm pretty sure I have
suitable hardware, but I don't have access to that for another week.

Regards,

	Hans

> +	if (ret)
> +		return ret;
> +
> +	state->scrambling_enabled = buf[SCDC_TMDS_CONFIG] & SCDC_SCRAMBLING_ENABLE;
> +	state->tmds_bclk_x40 = buf[SCDC_TMDS_CONFIG] & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40;
> +
> +	state->scrambling_detected = buf[SCDC_SCRAMBLER_STATUS] & SCDC_SCRAMBLING_STATUS;
> +
> +	drm_scdc_parse_status0_flags(buf[SCDC_STATUS_FLAGS_0], &state->stf);
> +	ret = drm_scdc_parse_error_counters(buf, state->error_count);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_scdc_read_state);
> +
> +#define scdc_print_str(_f, key, s) \
> +	(seq_printf((_f), "%-30s: %s\n", (key), (s)))
> +#define scdc_print_flag(_f, key, val) \
> +	(scdc_print_str((_f), (key), str_yes_no((val))))
> +#define scdc_print_dec(_f, key, val) \
> +	(seq_printf((_f), "%-30s: %d\n", (key), (val)))
> +
> +static int scdc_status_show(struct seq_file *m, void *data)
> +{
> +	struct scdc_debugfs_priv *priv = m->private;
> +	struct drm_scdc_state *st = &priv->state;
> +	struct drm_connector *connector = priv->connector;
> +	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
> +	int i, ret;
> +
> +	drm_connector_get(connector);
> +
> +	if (connector->status != connector_status_connected) {
> +		ret = -ENODEV;
> +		goto err_conn_put;
> +	}
> +
> +	if (scdc->supported) {
> +		ret = drm_scdc_read_state(connector, st);
> +		if (ret)
> +			goto err_conn_put;
> +
> +		for (i = 0; i < ARRAY_SIZE(st->scdc); i += 16)
> +			seq_printf(m, "%*ph\n", 16, &st->scdc[i]);
> +
> +		seq_puts(m, "\n----------------\n\n");
> +	}
> +
> +	scdc_print_flag(m, "SCDC Supported", scdc->supported);
> +	if (!scdc->supported) {
> +		ret = 0;
> +		goto err_conn_put;
> +	}
> +
> +	scdc_print_flag(m, "Sink Read Request Capable", scdc->read_request);
> +	scdc_print_flag(m, "Scrambling Supported", scdc->scrambling.supported);
> +	scdc_print_flag(m, "Low Rate Scrambling Supported", scdc->scrambling.low_rates);
> +
> +	drm_connector_put(connector);
> +
> +	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
> +	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
> +
> +	if (st->tmds_bclk_x40)
> +		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
> +	else
> +		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/10");
> +
> +	scdc_print_flag(m, "Clock Detected", st->stf.clock_detected);
> +	scdc_print_flag(m, "Channel 0 Locked", st->stf.ch0_locked);
> +	scdc_print_flag(m, "Channel 1 Locked", st->stf.ch1_locked);
> +	scdc_print_flag(m, "Channel 2 Locked", st->stf.ch2_locked);
> +
> +	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
> +	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
> +	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
> +
> +	return 0;
> +
> +err_conn_put:
> +	drm_connector_put(connector);
> +
> +	return ret;
> +}
> +DEFINE_SHOW_ATTRIBUTE(scdc_status);
> +
> +/**
> + * drm_scdc_debugfs_init - Initialize scdc files in connector debugfs
> + * @connector: pointer to &struct drm_connector to operate on
> + * @root: debugfs &struct dentry for the debugfs root of @connector
> + *
> + * Creates SCDC-related debugfs files for @connector. Must be called after
> + * @root is already created.
> + */
> +void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root)
> +{
> +	struct scdc_debugfs_priv *priv;
> +
> +	if (!root || !connector)
> +		return;
> +
> +	priv = drmm_kzalloc(connector->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return;
> +
> +	priv->connector = connector;
> +
> +	debugfs_create_file("scdc_status", 0444, root, priv, &scdc_status_fops);
> +}
> +EXPORT_SYMBOL(drm_scdc_debugfs_init);
> diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
> index e9ccaeba56dd..e0b79d79e1ff 100644
> --- a/include/drm/display/drm_scdc_helper.h
> +++ b/include/drm/display/drm_scdc_helper.h
> @@ -30,6 +30,34 @@
>  
>  struct drm_connector;
>  struct i2c_adapter;
> +struct dentry;
> +
> +struct drm_scdc_status_flags {
> +	/* Status Register 0 */
> +	bool clock_detected;
> +	bool ch0_locked;
> +	bool ch1_locked;
> +	bool ch2_locked;
> +};
> +
> +struct drm_scdc_state {
> +	/** @stf: contents of the status flag registers */
> +	struct drm_scdc_status_flags stf;
> +	/** @scramling_enabled: true if TMDS scrambling is on */
> +	bool scrambling_enabled;
> +	/** @scrambling_detected: true if the sink actually detected scrambling */
> +	bool scrambling_detected;
> +	/**
> +	 * @tmds_bclk_x40: true if TMDS bit period is 1/40th of the TMDS
> +	 * clock period, false if it's 1/10th of the clock period.
> +	 */
> +	bool tmds_bclk_x40;
> +	/** @error_count: character error counts for each channel */
> +	u16 error_count[3];
> +
> +	/** @scdc: raw SCDC data buffer */
> +	u8 scdc[256];
> +};
>  
>  int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
>  		  size_t size);
> @@ -77,4 +105,8 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
>  bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
>  bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
>  
> +int drm_scdc_read_state(struct drm_connector *connector,
> +			struct drm_scdc_state *state);
> +void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
> +
>  #endif
> 

