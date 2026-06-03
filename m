Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1691CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570CE113C1B;
	Wed,  3 Jun 2026 06:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CGS63lo3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A72113C1B
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 06:16:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89E6D43D9B;
 Wed,  3 Jun 2026 06:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A871F00893;
 Wed,  3 Jun 2026 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780467374;
 bh=OrrfNmeaHLqNEHblu4uW7hOdMArYK42J8wVO/KBgwkc=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=CGS63lo3lGH5AFAmwJvNJCVsP5gf7ajWqKLJNzPW2HAYSV5XfVebjsVgfy8wQycWz
 aRbS6PvlRy66lf9K4DmAxeZKHzUXUKxVJU79r8Rwl4IhNHYv5wUyU5fhLTD8ks8FLs
 zuMYVhTgejnRffIWEQuiHOCEnigRlq7n5+/dY1PmPAc2woDEw/0n9yK7skakNO8ian
 h6FM9gMcu3S6tEmDDVbHJlYAo5jYd5AzwurPXXR9ed7BNSMidp7OJ9ilnfYLwDoDyF
 XsWxIJq0Wfnp4Xi9naUbU6vttXpm/JrN5UG1B80vEKEImRVEO6wwCKqXgRvO4RNZsD
 Ma/uEPn5ruj5A==
Message-ID: <2fdfb5f5-eb7e-45d0-aa1f-b669bd47584d@kernel.org>
Date: Wed, 3 Jun 2026 08:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v4 2/4] drm/scdc-helper: Add scdc_status debugfs entry
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
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
 <20260527-scdc-link-health-v4-2-622ea40a1f59@collabora.com>
 <cced78d8-b45e-4c4f-a666-411e43d8ebe8@kernel.org>
 <lDv_-lKaTr6sQ5X7tuw2hQ@collabora.com>
Content-Language: en-US, nl
In-Reply-To: <lDv_-lKaTr6sQ5X7tuw2hQ@collabora.com>
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

On 02/06/2026 17:44, Nicolas Frattaroli wrote:
> On Tuesday, 2 June 2026 08:40:34 Central European Summer Time Hans Verkuil wrote:
>> Hi Nicolas,
>>
>> As promised, here is my review:
>>
>> On 27/05/2026 16:03, Nicolas Frattaroli wrote:
>>> SCDC provides status information on the current display link. At the
>>> very least, it may be useful to expose this info through debugfs.
>>>
>>> Add a debugfs entry for it under the connector, which displays a few
>>> more details parsed out of the SCDC registers. A new
>>> drm_scdc_debugfs_init function can be called by the connector
>>> implementation to initialise the debugfs file.
>>>
>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>>> ---
>>>  drivers/gpu/drm/display/drm_scdc_helper.c | 237 ++++++++++++++++++++++++++++++
>>>  include/drm/display/drm_scdc_helper.h     |  32 ++++
>>>  2 files changed, 269 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
>>> index 8403f2390ab6..7739fb5e77a1 100644
>>> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
>>> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
>>> @@ -24,11 +24,14 @@
>>>  #include <linux/export.h>
>>>  #include <linux/i2c.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/debugfs.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/overflow.h>
>>>  
>>>  #include <drm/display/drm_scdc_helper.h>
>>>  #include <drm/drm_connector.h>
>>>  #include <drm/drm_device.h>
>>> +#include <drm/drm_managed.h>
>>>  #include <drm/drm_print.h>
>>>  
>>>  /**
>>> @@ -55,6 +58,11 @@
>>>  
>>>  #define SCDC_I2C_SLAVE_ADDRESS 0x54
>>>  
>>> +struct scdc_debugfs_priv {
>>> +	struct drm_connector *connector;
>>> +	struct drm_scdc_state state;
>>> +};
>>> +
>>>  /**
>>>   * drm_scdc_read - read a block of data from SCDC
>>>   * @adapter: I2C controller
>>> @@ -276,3 +284,232 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
>>>  	return true;
>>>  }
>>>  EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
>>> +
>>> +/**
>>> + * drm_scdc_read_status0_flags - Read SCDC "Status Flags" Register
>>> + * @connector: pointer to &struct drm_connector to issue the scdc request on
>>> + * @flags: pointer to the caller's &struct drm_scdc_status_flags to output to
>>> + *
>>> + * Reads the SCDC Status Flags 0 register, and outputs its contents to the
>>> + * destination @flags. Contents of @flags are only valid if function returns 0.
>>> + *
>>> + * Returns: %0 on success, negative errno on error.
>>> + */
>>> +int drm_scdc_read_status0_flags(struct drm_connector *connector,
>>> +				struct drm_scdc_status_flags *flags)
>>> +{
>>> +	int ret;
>>> +	u8 val;
>>> +
>>> +	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_STATUS_UPDATE);
>>
>> It doesn't hurt to set SCDC_STATUS_UPDATE to 1, but neither is there a need for it.
>> It just causes unnecessary DDC traffic IMHO.
>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = drm_scdc_readb(connector->ddc, SCDC_STATUS_FLAGS_0, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	flags->clock_detected = val & SCDC_CLOCK_DETECT;
>>> +	flags->ch0_locked = val & SCDC_CH0_LOCK;
>>> +	flags->ch1_locked = val & SCDC_CH1_LOCK;
>>> +	flags->ch2_locked = val & SCDC_CH2_LOCK;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(drm_scdc_read_status0_flags);
>>> +
>>> +/**
>>> + * drm_scdc_read_error_counters - Read and clear SCDC error counters
>>> + * @connector: pointer to &struct drm_connector to issue the scdc request on
>>> + * @counter: Caller's u16 array with 3 elements to write the counter values into
>>> + *
>>> + * Read the SCDC channel error counters. If the count of channel *n* is valid,
>>> + * write it into counter[n]. Otherwise, set counter[n] to 0. Reads all counters
>>> + * in one read chunk, then clears every counter, as is mandated.
>>> + *
>>> + * Returns: %0 on success, negative errno on error.
>>> + */
>>> +int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3])
>>> +{
>>> +	u8 buf[7] = {};
>>> +	int ret;
>>> +	u8 sum = 0;
>>> +	int i;
>>> +
>>> +	ret = drm_scdc_writeb(connector->ddc, SCDC_UPDATE_0, SCDC_CED_UPDATE);
>>
>> Same here: there is no need to set SCDC_CED_UPDATE.
>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = drm_scdc_read(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Verify the "checksum", i.e. sum up everything including the checksum
>>> +	 * register as a wrapping unsigned 8-bit addition and verify it's 0.
>>> +	 */
>>> +	for (i = 0; i < ARRAY_SIZE(buf); i++)
>>> +		sum = wrapping_add(u8, sum, buf[i]);
>>> +
>>> +	if (sum)
>>> +		return -EPROTO;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
>>> +		if (buf[i + 1] & SCDC_CHANNEL_VALID)
>>> +			counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
>>> +		else
>>> +			counter[i / 2] = 0;
>>> +
>>> +		buf[i] = 0;
>>> +		buf[i + 1] = 0;
>>> +	}
>>> +	buf[ARRAY_SIZE(buf) - 1] = 0;
>>> +
>>> +	return drm_scdc_write(connector->ddc, SCDC_ERR_DET_0_L, buf, ARRAY_SIZE(buf));
>>
>> Huh? Reading the CED registers will automatically zero them as per the HDMI spec
>> (section 10.4.1.8, first paragraph). So there is no need to write to these registers.
>> Besides, they are read-only (table 10-14).
> 
> Yeah that's a mistake on my part. I thought the source had to clear
> them to signal that it wants more data, but now that I think about it,
> the sink obviously already knows when the source has read them because
> it sends an i2c read command.
> 
>>> +}
>>> +EXPORT_SYMBOL(drm_scdc_read_error_counters);
>>> +
>>> +/**
>>> + * drm_scdc_read_state - Update state from SCDC
>>> + * @connector: pointer to a &struct drm_connector on which to operate on
>>> + * @state: pointer to a &struct drm_scdc_state to fill
>>> + *
>>> + * Reads update flags from SCDC, and updates the parts of @state that SCDC
>>> + * claims have changed, as well as populating those where such a distinction
>>> + * can't be made.
>>> + *
>>> + * Returns: %0 on success, negative errno on failure.
>>> + */
>>> +int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *state)
>>> +{
>>> +	u8 upd_flags[2] = {};
>>> +	struct i2c_adapter *ddc;
>>> +	struct drm_scdc *scdc;
>>> +	int ret;
>>> +	u8 val;
>>> +
>>> +	if (!state || !connector)
>>> +		return -ENODEV;
>>> +
>>> +	scdc = &connector->display_info.hdmi.scdc;
>>> +	ddc = connector->ddc;
>>> +
>>> +	if (!scdc->supported)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	ret = drm_scdc_readb(ddc, SCDC_TMDS_CONFIG, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	state->scrambling_enabled = val & SCDC_SCRAMBLING_ENABLE;
>>> +	state->tmds_bclk_x40 = val & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40;
>>> +
>>> +	state->scrambling_detected = drm_scdc_get_scrambling_status(connector);
>>> +
>>> +	ret = drm_scdc_read(ddc, SCDC_UPDATE_0, &upd_flags, sizeof(upd_flags));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (upd_flags[0] & SCDC_STATUS_UPDATE) {
>>
>> Ah, so here you use SCDC_STATUS_UPDATE/SCDC_CED_UPDATE.
>>
>> I do not think this makes sense: for debugfs you just want to see the current
>> status and not 'what has changed since last time', which is what this basically
>> does.
> 
> My thought was that people will do a
> 
>   while sleep 0.5; do cat scdc_status ; echo "------"; done
> 
> and the update flags will make sure there isn't unnecessary traffic.

Based on my experience that's not how this is used in practice. You only look at
the SCDC data if there is something wrong, and then you just want to dump it
all and parse it.

My understanding is that these update flags are more meant for use in a driver where
you poll periodically to check if there are updates and then do something with that
in the driver. But for a debugfs feature it makes more sense IMHO to just dump the
full SCDC contents.

> 
>>> +		ret = drm_scdc_read_status0_flags(connector, &state->stf);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (upd_flags[0] & SCDC_CED_UPDATE) {
>>
>> And if the counters change only a little bit, then CED_UPDATE may not be set at all,
>> so you don't see such small changes.
>>
>>> +		ret = drm_scdc_read_error_counters(connector, state->error_count);
>>> +		if (ret)
>>> +			return ret;
>>
>> I would just always read the status flags and CED counters and report them. Especially
>> for debugfs usage.
>>
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(drm_scdc_read_state);
>>> +
>>> +#define scdc_print_str(_f, key, s) \
>>> +	(seq_printf((_f), "%-30s: %s\n", (key), (s)))
>>> +#define scdc_print_flag(_f, key, val) \
>>> +	(scdc_print_str((_f), (key), str_yes_no((val))))
>>> +#define scdc_print_dec(_f, key, val) \
>>> +	(seq_printf((_f), "%-30s: %d\n", (key), (val)))
>>> +
>>> +static int scdc_status_show(struct seq_file *m, void *data)
>>> +{
>>> +	struct scdc_debugfs_priv *priv = m->private;
>>> +	struct drm_scdc_state *st = &priv->state;
>>> +	struct drm_connector *connector = priv->connector;
>>> +	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
>>> +	int ret;
>>> +
>>> +	drm_connector_get(connector);
>>> +
>>> +	if (connector->status != connector_status_connected) {
>>> +		ret = -ENODEV;
>>> +		goto err_conn_put;
>>> +	}
>>> +
>>> +	scdc_print_flag(m, "SCDC Supported", scdc->supported);
>>> +	if (!scdc->supported) {
>>> +		ret = 0;
>>> +		goto err_conn_put;
>>> +	}
>>> +
>>> +	scdc_print_flag(m, "Sink Read Request Capable", scdc->read_request);
>>> +	scdc_print_flag(m, "Scrambling Supported", scdc->scrambling.supported);
>>> +	scdc_print_flag(m, "Low Rate Scrambling Supported", scdc->scrambling.low_rates);
>>> +
>>> +	ret = drm_scdc_read_state(connector, st);
>>> +	drm_connector_put(connector);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	scdc_print_flag(m, "Scrambling Enabled", st->scrambling_enabled);
>>> +	scdc_print_flag(m, "Scrambling Detected", st->scrambling_detected);
>>> +
>>> +	if (st->tmds_bclk_x40)
>>> +		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/40");
>>> +	else
>>> +		scdc_print_str(m, "TMDS Bit Clock Ratio", "1/10");
>>> +
>>> +	scdc_print_flag(m, "Clock Detected", st->stf.clock_detected);
>>> +	scdc_print_flag(m, "Channel 0 Locked", st->stf.ch0_locked);
>>> +	scdc_print_flag(m, "Channel 1 Locked", st->stf.ch1_locked);
>>> +	scdc_print_flag(m, "Channel 2 Locked", st->stf.ch2_locked);
>>> +
>>> +	scdc_print_dec(m, "Channel 0 Errors", st->error_count[0]);
>>> +	scdc_print_dec(m, "Channel 1 Errors", st->error_count[1]);
>>> +	scdc_print_dec(m, "Channel 2 Errors", st->error_count[2]);
>>
>> So, does parsing SCDC really belong in the kernel? Wouldn't it be easier
>> to just give a hexdump and let edid-decode parse it?
> 
> Assuming I follow your advice and no longer use the status update
> flags, does this provide any value over just having edid-decode access
> the i2c itself? This isn't a rhetorical question; I don't know if the
> i2c things as exposed by the kernel have drawbacks for multiple readers
> or even drawbacks being exposed at all.

Good question. The only reason for it is if the DDC bus is not exposed
as an i2c device. Otherwise edid-decode can just read it straight from the
i2c device. 'edid-decode' is these days closer to being a 'ddc-decode'
since it can read and parse EDID, SCDC and HDCP data.

SCDC is different from InfoFrames that do not go over DDC, so there debugfs
was really required to get hold of them.

Whether the kernel reads from the DDC bus or userspace makes no difference.
It normally has no impact, but if you were to read e.g. all 256 SCDC bytes
continuously it would cause problems with other traffic that has to happen
periodically (scrambler status testing, HDCP).

But that's not a normal scenario, of course.

> 
>>
>> We do the same for EDIDs and Infoframes.
>>
>> The edid-decode output (tested against my 4k TV) looks like this:
>>
>> edid-decode SCDC (hex):
>>
>> 00 01 01 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 03 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 80 00 80 00 80 80 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> ----------------
>>
>> Sink Version: 1 Source Version: 1
>> Sink Supported Features: 0x00
>> Source Supported Features: 0x00
>> Update Flags: 0x03 0x00
>>         Status_Update
>>         CED_Update
>> TMDS Configuration: 0x03
>>         Scrambling_Enable
>>         TMDS_Bit_Clock_Ratio: 1/40
>> TMDS Scrambler Status: 0x01
>>         TMDS_Scrambling_Status
>> Sink Configuration: 0x00 0x00
>>         FRL_Rate: Disable FRL
>>         FFE_Levels: 0
>> Source Test Configuration: 0x00
>> Status Flags: 0x0f 0x00 0x00
>>         Clock_Detected
>>         Ch0_Ln0_Locked
>>         Ch1_Ln1_Locked
>>         Ch2_Ln2_Locked
>> Character Error Detection:
>>         Channel 0 Error Count: 0
>>         Channel 1 Error Count: 0
>>         Channel 2 Error Count: 0
>> Manufacturer Specific: none
>>
>> The debugfs scdc_status_show() function could just dump the 256 byte SCDC data as a single
>> binary blob or output it as a hex dump, and leave the parsing to edid-decode, just as was
>> done for InfoFrames in debugfs.
>>
>> This would simplify the kernel code quite a bit, and edid-decode is much easier to adapt
>> to new HDMI versions. So parsing of the SCDC data from the display is not dependent on
>> the kernel version.
>>
>> At minimum I would suggest that you dump the hex values before your parsed output.
> 
> Hmmmm, I guess to keep it simple we could just dump the hex values or
> the binary, and do none of the parsing. But I wonder if a hex dump or
> a raw binary is preferable. I don't like potentially ruining people's
> terminal when they go cat poking, so I suppose hex dumping is the
> answer.

Both InfoFrames and the edid as exposed in debugfs and /sys are binary. edid-decode can
handle both binary and hex.

So binary would be more consistent. But I have no strong opinion on this.

If you decide to just dump the SCDC data, then read it in two blocks of 128 bytes.
You should not read 256 bytes of data over DDC in one go. This will fail if
DisplayPort-to-HDMI adapters are used: the DP REMOTE_I2C_READ/WRITE requests use 8 bit
for the read/write length, so 256 maps to 0, so nothing is actually read or written.

I was bitten by that in edid-decode :-) It took me a while to figure out why I never
saw any valid data.

Regards,

	Hans

> 
> Kind regards,
> Nicolas Frattaroli
> 
>>
>> Regards,
>>
>> 	Hans
>>
>>
>>> +
>>> +	return 0;
>>> +
>>> +err_conn_put:
>>> +	drm_connector_put(connector);
>>> +
>>> +	return ret;
>>> +}
>>> +DEFINE_SHOW_ATTRIBUTE(scdc_status);
>>> +
>>> +/**
>>> + * drm_scdc_debugfs_init - Initialize scdc files in connector debugfs
>>> + * @connector: pointer to &struct drm_connector to operate on
>>> + * @root: debugfs &struct dentry for the debugfs root of @connector
>>> + *
>>> + * Creates SCDC-related debugfs files for @connector. Must be called after
>>> + * @root is already created.
>>> + */
>>> +void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root)
>>> +{
>>> +	struct scdc_debugfs_priv *priv;
>>> +
>>> +	if (!root || !connector)
>>> +		return;
>>> +
>>> +	priv = drmm_kzalloc(connector->dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return;
>>> +
>>> +	priv->connector = connector;
>>> +
>>> +	debugfs_create_file("scdc_status", 0444, root, priv, &scdc_status_fops);
>>> +}
>>> +EXPORT_SYMBOL(drm_scdc_debugfs_init);
>>> diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
>>> index e9ccaeba56dd..3b3a4e0e48ba 100644
>>> --- a/include/drm/display/drm_scdc_helper.h
>>> +++ b/include/drm/display/drm_scdc_helper.h
>>> @@ -30,6 +30,31 @@
>>>  
>>>  struct drm_connector;
>>>  struct i2c_adapter;
>>> +struct dentry;
>>> +
>>> +struct drm_scdc_status_flags {
>>> +	/* Status Register 0 */
>>> +	bool clock_detected;
>>> +	bool ch0_locked;
>>> +	bool ch1_locked;
>>> +	bool ch2_locked;
>>> +};
>>> +
>>> +struct drm_scdc_state {
>>> +	/** @stf: contents of the status flag registers */
>>> +	struct drm_scdc_status_flags stf;
>>> +	/** @scramling_enabled: true if TMDS scrambling is on */
>>> +	bool scrambling_enabled;
>>> +	/** @scrambling_detected: true if the sink actually detected scrambling */
>>> +	bool scrambling_detected;
>>> +	/**
>>> +	 * @tmds_bclk_x40: true if TMDS bit period is 1/40th of the TMDS
>>> +	 * clock period, false if it's 1/10th of the clock period.
>>> +	 */
>>> +	bool tmds_bclk_x40;
>>> +	/** @error_count: character error counts for each channel */
>>> +	u16 error_count[3];
>>> +};
>>>  
>>>  int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
>>>  		  size_t size);
>>> @@ -77,4 +102,11 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector);
>>>  bool drm_scdc_set_scrambling(struct drm_connector *connector, bool enable);
>>>  bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector, bool set);
>>>  
>>> +int drm_scdc_read_status0_flags(struct drm_connector *connector,
>>> +				struct drm_scdc_status_flags *flags);
>>> +int drm_scdc_read_state(struct drm_connector *connector,
>>> +			struct drm_scdc_state *state);
>>> +int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]);
>>> +void drm_scdc_debugfs_init(struct drm_connector *connector, struct dentry *root);
>>> +
>>>  #endif
>>>
>>
>>
> 
> 
> 
> 

