Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05959CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A02110F314;
	Tue,  2 Jun 2026 15:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="VNHV6C6Z";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D3310F314
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780415070; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JR1yvu/tXGMgvO4LQTPkxDaXbiW98mV92SDa+fex3a/YS/DBFSF67Ot3IHmcrcSZ6gl+6mAiEZT3LdV11Sv3PI9YPg2BrcWaXwFux9YegRL0Iwzlbh+9RGuVTsAzcMipQd+cE7B/qfju2Qkz7+rdkTiElsIkf0iGMOdBiEuZnq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780415070;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Sp7vSJM2amqlf9BLTosKXVJilzrPDp0jgF8WWt//6iA=; 
 b=AhGO0mVWOXkhLEV5vR9wLTVuNvRjzldUpyQ7+qqVqFR1XdLiZR9sjM3T10ws94ZmxqMSPlWSr4DXjzJeoGoAG+GbGn7eo2o05oK8y6JUS2o02+4Sw4dycPPCJ2FgR4xLBvsjX5U/90B7m2EGwS3c/oeAS4JyyiHY2IY+w/GhVjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780415069; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=Sp7vSJM2amqlf9BLTosKXVJilzrPDp0jgF8WWt//6iA=;
 b=VNHV6C6ZolPSXGbg+CYgI0ALu3VZDosXW4GUG0VhzF80bVCKE9r7umgjS6A33soI
 Yz0qoF53jjd3TP+8aotzfMSD7AfRzKSA0PhxVMAj3mLj4IqA9M+MIwqOJMN8NWgx70r
 FF0DL7LZpmQeQeCANYSRL0vrG4lZCXoRJ6cbRx4Y=
Received: by mx.zohomail.com with SMTPS id 1780415068386497.89568039035134;
 Tue, 2 Jun 2026 08:44:28 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>, Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v4 2/4] drm/scdc-helper: Add scdc_status debugfs entry
Date: Tue, 02 Jun 2026 17:44:21 +0200
Message-ID: <lDv_-lKaTr6sQ5X7tuw2hQ@collabora.com>
In-Reply-To: <cced78d8-b45e-4c4f-a666-411e43d8ebe8@kernel.org>
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
 <20260527-scdc-link-health-v4-2-622ea40a1f59@collabora.com>
 <cced78d8-b45e-4c4f-a666-411e43d8ebe8@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, 2 June 2026 08:40:34 Central European Summer Time Hans Verkuil wrote:
> Hi Nicolas,
> 
> As promised, here is my review:
> 
> On 27/05/2026 16:03, Nicolas Frattaroli wrote:
> > SCDC provides status information on the current display link. At the
> > very least, it may be useful to expose this info through debugfs.
> > 
> > Add a debugfs entry for it under the connector, which displays a few
> > more details parsed out of the SCDC registers. A new
> > drm_scdc_debugfs_init function can be called by the connector
> > implementation to initialise the debugfs file.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_scdc_helper.c | 237 ++++++++++++++++++++++++++++++
> >  include/drm/display/drm_scdc_helper.h     |  32 ++++
> >  2 files changed, 269 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> > index 8403f2390ab6..7739fb5e77a1 100644
> > --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> > +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> > @@ -24,11 +24,14 @@
> >  #include <linux/export.h>
> >  #include <linux/i2c.h>
> >  #include <linux/slab.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/delay.h>
> > +#include <linux/overflow.h>
> >  
> >  #include <drm/display/drm_scdc_helper.h>
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_device.h>
> > +#include <drm/drm_managed.h>
> >  #include <drm/drm_print.h>
> >  
> >  /**
> > @@ -55,6 +58,11 @@
> >  
> >  #define SCDC_I2C_SLAVE_ADDRESS 0x54
> >  
> > +struct scdc_debugfs_priv {
> > +	struct drm_connector *connector;
> > +	struct drm_scdc_state state;
> > +};
> > +
> >  /**
> >   * drm_scdc_read - read a block of data from SCDC
> >   * @adapter: I2C controller
> > @@ -276,3 +284,232 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
> >  	return true;
> >  }
> >  EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
> > +
> > +/**
> > + * drm_scdc_read_status0_flags - Read SCDC "Status Flags" Register
> > + * @connector: pointer to &struct drm_connector to issue the scdc request on
> > + * @flags: pointer to the caller's &struct drm_scdc_status_flags to output to
> > + *
> > + * Reads the SCDC Status Flags 0 register, and outputs its contents to the
> > + * destination @flags. Contents of @flags are only valid if function returns 0.
> > + *
> > + * Returns: %0 on success, negative errno on error.
> > + */
> > +int drm_scdc_read_status0_flags(struct drm_connector *connector,
> > +				struct drm_scdc_status_flags *flags)
> > +{
> > +	int ret;
> > +	u8 val;
> > +
> > +	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_STATUS_UPDATE);
> 
> It doesn't hurt to set SCDC_STATUS_UPDATE to 1, but neither is there a need for it.
> It just causes unnecessary DDC traffic IMHO.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	flags->clock_detected = val & SCDC_CLOCK_DETECT;
> > +	flags->ch0_locked = val & SCDC_CH0_LOCK;
> > +	flags->ch1_locked = val & SCDC_CH1_LOCK;
> > +	flags->ch2_locked = val & SCDC_CH2_LOCK;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_scdc_read_status0_flags);
> > +
> > +/**
> > + * drm_scdc_read_error_counters - Read and clear SCDC error counters
> > + * @connector: pointer to &struct drm_connector to issue the scdc request on
> > + * @counter: Caller's u16 array with 3 elements to write the counter values into
> > + *
> > + * Read the SCDC channel error counters. If the count of channel *n* is valid,
> > + * write it into counter[n]. Otherwise, set counter[n] to 0. Reads all counters
> > + * in one read chunk, then clears every counter, as is mandated.
> > + *
> > + * Returns: %0 on success, negative errno on error.
> > + */
> > +int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3])
> > +{
> > +	u8 buf[7] = {};
> > +	int ret;
> > +	u8 sum = 0;
> > +	int i;
> > +
> > +	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_CED_UPDATE);
> 
> Same here: there is no need to set SCDC_CED_UPDATE.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Verify the "checksum", i.e. sum up everything including the checksum
> > +	 * register as a wrapping unsigned 8-bit addition and verify it's 0.
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(buf); i++)
> > +		sum = wrapping_add(u8, sum, buf[i]);
> > +
> > +	if (sum)
> > +		return -EPROTO;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
> > +		if (buf[i + 1] & SCDC_CHANNEL_VALID)
> > +			counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
> > +		else
> > +			counter[i / 2] = 0;
> > +
> > +		buf[i] = 0;
> > +		buf[i + 1] = 0;
> > +	}
> > +	buf[ARRAY_SIZE(buf) - 1] = 0;
> > +
> > +	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
> 
> Huh? Reading the CED registers will automatically zero them as per the HDMI spec
> (section 10.4.1.8, first paragraph). So there is no need to write to these registers.
> Besides, they are read-only (table 10-14).

Yeah that's a mistake on my part. I thought the source had to clear
them to signal that it wants more data, but now that I think about it,
the sink obviously already knows when the source has read them because
it sends an i2c read command.

> > +}
> > +EXPORT_SYMBOL(drm_scdc_read_error_counters);
> > +
> > +/**
> > + * drm_scdc_read_state - Update state from SCDC
> > + * @connector: pointer to a &struct drm_connector on which to operate on
> > + * @state: pointer to a &struct drm_scdc_state to fill
> > + *
> > + * Reads update flags from SCDC, and updates the parts of @state that SCDC
> > + * claims have changed, as well as populating those where such a distinction
> > + * can't be made.
> > + *
> > + * Returns: %0 on success, negative errno on failure.
> > + */
> > +int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *state)
> > +{
> > +	u8 upd_flags[2] = {};
> > +	struct i2c_adapter *ddc;
> > +	struct drm_scdc *scdc;
> > +	int ret;
> > +	u8 val;
> > +
> > +	if (!state || !connector)
> > +		return -ENODEV;
> > +
> > +	scdc = &connector->display_info.hdmi.scdc;
> > +	ddc = connector->ddc;
> > +
> > +	if (!scdc->supported)
> > +		return -EOPNOTSUPP;
> > +
> > +	ret = drm_scdc_readb(ddc, SCDC_TMDS_CONFIG, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	state->scrambling_enabled = val & SCDC_SCRAMBLING_ENABLE;
> > +	state->tmds_bclk_x40 = val & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40;
> > +
> > +	state->scrambling_detected = drm_scdc_get_scrambling_status(connector);
> > +
> > +	ret = drm_scdc_read(ddc, SCDC_UPDATE_0, &upd_flags, sizeof(upd_flags));
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (upd_flags[0] & SCDC_STATUS_UPDATE) {
> 
> Ah, so here you use SCDC_STATUS_UPDATE/SCDC_CED_UPDATE.
> 
> I do not think this makes sense: for debugfs you just want to see the current
> status and not 'what has changed since last time', which is what this basically
> does.

My thought was that people will do a

  while sleep 0.5; do cat scdc_status ; echo "------"; done

and the update flags will make sure there isn't unnecessary traffic.

> > +		ret = drm_scdc_read_status0_flags(connector, &state->stf);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (upd_flags[0] & SCDC_CED_UPDATE) {
> 
> And if the counters change only a little bit, then CED_UPDATE may not be set at all,
> so you don't see such small changes.
> 
> > +		ret = drm_scdc_read_error_counters(connector, state->error_count);
> > +		if (ret)
> > +			return ret;
> 
> I would just always read the status flags and CED counters and report them. Especially
> for debugfs usage.
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_scdc_read_state);
> > +
> > +#define scdc_print_str(_f, key, s) \
> > +	(seq_printf((_f), "%-30s: %s\n", (key), (s)))
> > +#define scdc_print_flag(_f, key, val) \
> > +	(scdc_print_str((_f), (key), str_yes_no((val))))
> > +#define scdc_print_dec(_f, key, val) \
> > +	(seq_printf((_f), "%-30s: %d\n", (key), (val)))
> > +
> > +static int scdc_status_show(struct seq_file *m, void *data)
> > +{
> > +	struct scdc_debugfs_priv *priv = m->private;
> > +	struct drm_scdc_state *st = &priv->state;
> > +	struct drm_connector *connector = priv->connector;
> > +	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
> > +	int ret;
> > +
> > +	drm_connector_get(connector);
> > +
> > +	if (connector->status != connector_status_connected) {
> > +		ret = -ENODEV;
> > +		goto err_conn_put;
> > +	}
> > +
> > +	scdc_print_flag(m, "SCDC Supported", scdc->supported);
> > +	if (!scdc->supported) {
> > +		ret = 0;
> > +		goto err_conn_put;
> > +	}
> > +
> > +	scdc_print_flag(m, "Sink Read Request Capable", scdc->read_request);
> > +	scdc_print_flag(m, "Scrambling Supported", scdc->scrambling.supported);
> > +	scdc_print_flag(m, "Low Rate Scrambling Supported", scdc->scrambling.low_rates);
> > +
> > +	ret = drm_scdc_read_state(connector, st);
> > +	drm_connector_put(connector);
> > +	if (ret)
> > +		return ret;
> > +
> > +	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
> > +	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
> > +
> > +	if (st->tmds_bclk_x40)
> > +		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
> > +	else
> > +		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/10");
> > +
> > +	scdc_print_flag(m, "Clock Detected", st->stf.clock_detected);
> > +	scdc_print_flag(m, "Channel 0 Locked", st->stf.ch0_locked);
> > +	scdc_print_flag(m, "Channel 1 Locked", st->stf.ch1_locked);
> > +	scdc_print_flag(m, "Channel 2 Locked", st->stf.ch2_locked);
> > +
> > +	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
> > +	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
> > +	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
> 
> So, does parsing SCDC really belong in the kernel? Wouldn't it be easier
> to just give a hexdump and let edid-decode parse it?

Assuming I follow your advice and no longer use the status update
flags, does this provide any value over just having edid-decode access
the i2c itself? This isn't a rhetorical question; I don't know if the
i2c things as exposed by the kernel have drawbacks for multiple readers
or even drawbacks being exposed at all.

> 
> We do the same for EDIDs and Infoframes.
> 
> The edid-decode output (tested against my 4k TV) looks like this:
> 
> edid-decode SCDC (hex):
> 
> 00 01 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 03 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 80 00 80 00 80 80 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> ----------------
> 
> Sink Version: 1 Source Version: 1
> Sink Supported Features: 0x00
> Source Supported Features: 0x00
> Update Flags: 0x03 0x00
>         Status_Update
>         CED_Update
> TMDS Configuration: 0x03
>         Scrambling_Enable
>         TMDS_Bit_Clock_Ratio: 1/40
> TMDS Scrambler Status: 0x01
>         TMDS_Scrambling_Status
> Sink Configuration: 0x00 0x00
>         FRL_Rate: Disable FRL
>         FFE_Levels: 0
> Source Test Configuration: 0x00
> Status Flags: 0x0f 0x00 0x00
>         Clock_Detected
>         Ch0_Ln0_Locked
>         Ch1_Ln1_Locked
>         Ch2_Ln2_Locked
> Character Error Detection:
>         Channel 0 Error Count: 0
>         Channel 1 Error Count: 0
>         Channel 2 Error Count: 0
> Manufacturer Specific: none
> 
> The debugfs scdc_status_show() function could just dump the 256 byte SCDC data as a single
> binary blob or output it as a hex dump, and leave the parsing to edid-decode, just as was
> done for InfoFrames in debugfs.
> 
> This would simplify the kernel code quite a bit, and edid-decode is much easier to adapt
> to new HDMI versions. So parsing of the SCDC data from the display is not dependent on
> the kernel version.
> 
> At minimum I would suggest that you dump the hex values before your parsed output.

Hmmmm, I guess to keep it simple we could just dump the hex values or
the binary, and do none of the parsing. But I wonder if a hex dump or
a raw binary is preferable. I don't like potentially ruining people's
terminal when they go cat poking, so I suppose hex dumping is the
answer.

Kind regards,
Nicolas Frattaroli

> 
> Regards,
> 
> 	Hans
> 
> 
> > +
> > +	return 0;
> > +
> > +err_conn_put:
> > +	drm_connector_put(connector);
> > +
> > +	return ret;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(scdc_status);
> > +
> > +/**
> > + * drm_scdc_debugfs_init - Initialize scdc files in connector debugfs
> > + * @connector: pointer to &struct drm_connector to operate on
> > + * @root: debugfs &struct dentry for the debugfs root of @connector
> > + *
> > + * Creates SCDC-related debugfs files for @connector. Must be called after
> > + * @root is already created.
> > + */
> > +void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root)
> > +{
> > +	struct scdc_debugfs_priv *priv;
> > +
> > +	if (!root || !connector)
> > +		return;
> > +
> > +	priv = drmm_kzalloc(connector->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return;
> > +
> > +	priv->connector = connector;
> > +
> > +	debugfs_create_file("scdc_status", 0444, root, priv, &scdc_status_fops);
> > +}
> > +EXPORT_SYMBOL(drm_scdc_debugfs_init);
> > diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
> > index e9ccaeba56dd..3b3a4e0e48ba 100644
> > --- a/include/drm/display/drm_scdc_helper.h
> > +++ b/include/drm/display/drm_scdc_helper.h
> > @@ -30,6 +30,31 @@
> >  
> >  struct drm_connector;
> >  struct i2c_adapter;
> > +struct dentry;
> > +
> > +struct drm_scdc_status_flags {
> > +	/* Status Register 0 */
> > +	bool clock_detected;
> > +	bool ch0_locked;
> > +	bool ch1_locked;
> > +	bool ch2_locked;
> > +};
> > +
> > +struct drm_scdc_state {
> > +	/** @stf: contents of the status flag registers */
> > +	struct drm_scdc_status_flags stf;
> > +	/** @scramling_enabled: true if TMDS scrambling is on */
> > +	bool scrambling_enabled;
> > +	/** @scrambling_detected: true if the sink actually detected scrambling */
> > +	bool scrambling_detected;
> > +	/**
> > +	 * @tmds_bclk_x40: true if TMDS bit period is 1/40th of the TMDS
> > +	 * clock period, false if it's 1/10th of the clock period.
> > +	 */
> > +	bool tmds_bclk_x40;
> > +	/** @error_count: character error counts for each channel */
> > +	u16 error_count[3];
> > +};
> >  
> >  int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
> >  		  size_t size);
> > @@ -77,4 +102,11 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
> >  bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
> >  bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
> >  
> > +int drm_scdc_read_status0_flags(struct drm_connector *connector,
> > +				struct drm_scdc_status_flags *flags);
> > +int drm_scdc_read_state(struct drm_connector *connector,
> > +			struct drm_scdc_state *state);
> > +int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]);
> > +void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
> > +
> >  #endif
> > 
> 
> 




