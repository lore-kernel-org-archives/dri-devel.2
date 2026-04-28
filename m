Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94529FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D175F10E32A;
	Tue, 28 Apr 2026 13:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="LEmcaE/Q";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A691B10E32A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777384307;
 bh=sU4/cbZTlYJ898JgkXkK5rJKdiUsQhuw4mg7I7NDGRk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LEmcaE/Qtt4L/l/wrTpaUoSyt1Uj387RyZH9OWWOqS5rEqDH6huIUWxMvCAXBfXmx
 ULPzJ9uTvJUJ3y6bXC6G9tCvWjlSxrWhZj+piKtgjQy6AeBp9QP6JcYatLLtnPYsEo
 qMnKSHTbzcd9F3nrKKyNNrAZeaB4hNo5yLjpwP916WULJDlK6sGdHCVHI5H6voltQF
 yp5k46alurfNpChtLk6Ew0zLAxqm+snYVCg86AZFC5Pm9u0oUzWK32tjoqgoSXy4iS
 676lVsMhPQ7fL+alBm+4S26VaM9eyiD+oXgKSfgvFgkcQYjonm+l+h3civ1kf8zvFF
 LMUoH3sFCvKtQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F55917E128F;
 Tue, 28 Apr 2026 15:51:47 +0200 (CEST)
Message-ID: <539f1bb9-6509-40c7-8692-bb3cdee33f91@collabora.com>
Date: Tue, 28 Apr 2026 16:51:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC
 scrambling and high TMDS clock ratio support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-5-d778e70c317b@collabora.com>
 <m5fxlfktxtvki5yaxhkx4h3hsjj5266stwvfdykhqkgcjbz5bk@s5gggcd45abm>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <m5fxlfktxtvki5yaxhkx4h3hsjj5266stwvfdykhqkgcjbz5bk@s5gggcd45abm>
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

Hi Dmitry,

Thanks for taking the time to review the series!

On 4/28/26 4:38 AM, Dmitry Baryshkov wrote:
> On Sun, Apr 26, 2026 at 03:20:17AM +0300, Cristian Ciocaltea wrote:
>> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) by adding SCDC management
>> for the high TMDS clock ratio and scrambling, required when the TMDS
>> character rate exceeds the 340 MHz HDMI 1.4b limit.
>>
>> A periodic work item monitors the sink's scrambling status to recover
>> from sink-side resets.  On hotplug detect, if SCDC scrambling state is
>> out of sync with the driver, trigger a CRTC reset to re-establish the
>> link.
>>
>> Reject modes requiring TMDS rates above 600 MHz, as those fall in the
>> HDMI 2.1 FRL domain which is not supported. In no_hpd configurations,
>> further restrict to 340 MHz since SCDC requires a connected sink.
>>
>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 188 ++++++++++++++++++++++++---
>>  1 file changed, 172 insertions(+), 16 deletions(-)
> 
> My main issue with this patch (sorry) is that this adds yet another copy
> of SCDC-related helpers into the driver which already OP_HDMI and other
> helpers.
> 
>> @@ -39,7 +42,9 @@
>>  #define DDC_SEGMENT_ADDR	0x30
>>  
>>  #define HDMI14_MAX_TMDSCLK	340000000
>> +#define HDMI20_MAX_TMDSRATE	600000000
>>  
>> +#define SCDC_MAX_SOURCE_VERSION	0x1
>>  #define SCRAMB_POLL_DELAY_MS	3000
>>  
>>  /*
>> @@ -164,6 +169,11 @@ struct dw_hdmi_qp {
>>  	} phy;
>>  
>>  	unsigned long ref_clk_rate;
>> +
>> +	struct drm_connector *curr_conn;
>> +	struct delayed_work scramb_work;
>> +	bool scramb_enabled;
> 
> s/scramb/scrambler/
> 
> Can we move those two to the drm_connector_hdmi

Sure, will do.

>> +
>>  	struct regmap *regm;
>>  	int main_irq;
>>  
>> @@ -749,28 +759,124 @@ static struct i2c_adapter *dw_hdmi_qp_i2c_adapter(struct dw_hdmi_qp *hdmi)
>>  	return adap;
>>  }
>>  
>> +static bool dw_hdmi_qp_supports_scrambling(struct drm_display_info *display)
>> +{
>> +	if (!display->is_hdmi)
>> +		return false;
>> +
>> +	return display->hdmi.scdc.supported &&
>> +		display->hdmi.scdc.scrambling.supported;
>> +}
>> +
>> +static int dw_hdmi_qp_set_scramb(struct dw_hdmi_qp *hdmi)
>> +{
>> +	bool done;
>> +
>> +	dev_dbg(hdmi->dev, "set scrambling\n");
>> +
>> +	done = drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, true);
>> +	if (!done)
>> +		return -EIO;
>> +
>> +	done = drm_scdc_set_scrambling(hdmi->curr_conn, true);
>> +	if (!done) {
>> +		drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, false);
>> +		return -EIO;
>> +	}
>> +
>> +	schedule_delayed_work(&hdmi->scramb_work,
>> +			      msecs_to_jiffies(SCRAMB_POLL_DELAY_MS));
>> +	return 0;
>> +}
>> +
>> +static void dw_hdmi_qp_scramb_work(struct work_struct *work)
>> +{
>> +	struct dw_hdmi_qp *hdmi = container_of(to_delayed_work(work),
>> +					       struct dw_hdmi_qp,
>> +					       scramb_work);
>> +	if (READ_ONCE(hdmi->scramb_enabled) &&
>> +	    !drm_scdc_get_scrambling_status(hdmi->curr_conn))
>> +		dw_hdmi_qp_set_scramb(hdmi);
>> +}
>> +
>> +static void dw_hdmi_qp_enable_scramb(struct dw_hdmi_qp *hdmi)
>> +{
>> +	int ret;
>> +	u8 ver;
>> +
>> +	if (!dw_hdmi_qp_supports_scrambling(&hdmi->curr_conn->display_info))
>> +		return;
>> +
>> +	ret = drm_scdc_readb(hdmi->bridge.ddc, SCDC_SINK_VERSION, &ver);
>> +	if (ret) {
>> +		dev_err(hdmi->dev, "Failed to read SCDC_SINK_VERSION: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	ret = drm_scdc_writeb(hdmi->bridge.ddc, SCDC_SOURCE_VERSION,
>> +			      min_t(u8, ver, SCDC_MAX_SOURCE_VERSION));
>> +	if (ret) {
>> +		dev_err(hdmi->dev, "Failed to write SCDC_SOURCE_VERSION: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	WRITE_ONCE(hdmi->scramb_enabled, true);
>> +
>> +	ret = dw_hdmi_qp_set_scramb(hdmi);
>> +	if (ret) {
>> +		hdmi->scramb_enabled = false;
>> +		return;
>> +	}
>> +
>> +	dw_hdmi_qp_write(hdmi, 1, SCRAMB_CONFIG0);
>> +
>> +	/* Wait at least 1 ms before resuming TMDS transmission */
>> +	usleep_range(1000, 5000);
>> +}
>> +
>> +static void dw_hdmi_qp_disable_scramb(struct dw_hdmi_qp *hdmi)
>> +{
>> +	if (!hdmi->scramb_enabled)
>> +		return;
>> +
>> +	dev_dbg(hdmi->dev, "disable scrambling\n");
>> +
>> +	WRITE_ONCE(hdmi->scramb_enabled, false);
>> +	cancel_delayed_work_sync(&hdmi->scramb_work);
>> +
>> +	dw_hdmi_qp_write(hdmi, 0, SCRAMB_CONFIG0);
>> +
>> +	if (hdmi->curr_conn->status == connector_status_connected) {
>> +		drm_scdc_set_scrambling(hdmi->curr_conn, false);
>> +		drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, false);
>> +	}
>> +}
> 
> All of these feel like generic helpers.

I'll factor these out.

>> +
>>  static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
>>  					    struct drm_atomic_state *state)
>>  {
>>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>>  	struct drm_connector_state *conn_state;
>> -	struct drm_connector *connector;
>>  	unsigned int op_mode;
>>  
>> -	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>> -	if (WARN_ON(!connector))
>> +	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state,
>> +								   bridge->encoder);
>> +	if (WARN_ON(!hdmi->curr_conn))
>>  		return;
>>  
>> -	conn_state = drm_atomic_get_new_connector_state(state, connector);
>> +	conn_state = drm_atomic_get_new_connector_state(state, hdmi->curr_conn);
>>  	if (WARN_ON(!conn_state))
>>  		return;
>>  
>> -	if (connector->display_info.is_hdmi) {
>> +	if (hdmi->curr_conn->display_info.is_hdmi) {
>>  		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u\n", __func__,
>>  			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
>>  			conn_state->hdmi.tmds_char_rate, conn_state->hdmi.output_bpc);
>>  		op_mode = 0;
>>  		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
>> +
>> +		if (conn_state->hdmi.tmds_char_rate > HDMI14_MAX_TMDSCLK)
>> +			dw_hdmi_qp_enable_scramb(hdmi);
>>  	} else {
>>  		dev_dbg(hdmi->dev, "%s mode=DVI\n", __func__);
>>  		op_mode = OPMODE_DVI;
>> @@ -781,7 +887,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
>>  	dw_hdmi_qp_mod(hdmi, HDCP2_BYPASS, HDCP2_BYPASS, HDCP2LOGIC_CONFIG0);
>>  	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
>>  
>> -	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
>> +	drm_atomic_helper_connector_hdmi_update_infoframes(hdmi->curr_conn, state);
>>  }
>>  
>>  static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
>> @@ -791,14 +897,49 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
>>  
>>  	hdmi->tmds_char_rate = 0;
>>  
>> +	dw_hdmi_qp_disable_scramb(hdmi);
>> +
>> +	hdmi->curr_conn = NULL;
>>  	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>>  }
>>  
>> -static enum drm_connector_status
>> -dw_hdmi_qp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
>> +static int dw_hdmi_qp_reset_crtc(struct dw_hdmi_qp *hdmi,
>> +				 struct drm_connector *connector,
>> +				 struct drm_modeset_acquire_ctx *ctx)
>> +{
>> +	u8 config;
>> +	int ret;
>> +
>> +	ret = drm_scdc_readb(hdmi->bridge.ddc, SCDC_TMDS_CONFIG, &config);
>> +	if (ret < 0) {
>> +		dev_err(hdmi->dev, "Failed to read TMDS config: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (!!(config & SCDC_SCRAMBLING_ENABLE) == hdmi->scramb_enabled)
>> +		return 0;
> 
> Also please check the high TMDS clock ration bit.

Ack.

>> +
>> +	drm_atomic_helper_connector_hdmi_hotplug(connector,
>> +						 connector_status_connected);
> 
> I don't see a forced hotplug event in the existing drivers. Why is it
> necessary? This function is being called from the detect() path.

For some reason, without it, the connector seems to lose its state after reset:

[ 2142.982967] dwhdmiqp-rockchip fde80000.hdmi: resetting crtc
[ 2142.994132] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't support RGB, something's wrong.
[ 2143.140827] dwhdmiqp-rockchip fde80000.hdmi: dw_hdmi_qp_bridge_atomic_enable mode=DVI

Will recheck if that's still the case after the HPD handling rework.

> 
>> +	/*
>> +	 * Conform to HDMI 2.0 spec by ensuring scrambled data is not sent
>> +	 * before configuring the sink scrambling, as well as suspending any
>> +	 * TMDS transmission while changing the TMDS clock rate in the sink.
>> +	 */
>> +
>> +	dev_dbg(hdmi->dev, "resetting crtc\n");
>> +
>> +	return drm_bridge_helper_reset_crtc(&hdmi->bridge, ctx);
>> +}
>> +
>> +static int dw_hdmi_qp_bridge_detect_ctx(struct drm_bridge *bridge,
>> +					struct drm_connector *connector,
>> +					struct drm_modeset_acquire_ctx *ctx)
>>  {
>>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>> +	enum drm_connector_status status;
>>  	const struct drm_edid *drm_edid;
>> +	int ret;
>>  
>>  	if (hdmi->no_hpd) {
>>  		drm_edid = drm_edid_read_ddc(connector, bridge->ddc);
>> @@ -808,7 +949,20 @@ dw_hdmi_qp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connec
>>  			return connector_status_disconnected;
>>  	}
>>  
>> -	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
>> +	status = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
>> +
>> +	dev_dbg(hdmi->dev, "%s status=%d scramb=%d\n", __func__,
>> +		status, hdmi->scramb_enabled);
>> +
>> +	if (status == connector_status_connected && hdmi->scramb_enabled) {
>> +		ret = dw_hdmi_qp_reset_crtc(hdmi, connector, ctx);
>> +		if (ret == -EDEADLK)
>> +			return ret;
>> +		if (ret < 0)
>> +			status = connector_status_unknown;
> 
> Ideally this should go to the drm_atomic_helper_connector_hdmi_update().
> And once it goes, I don't think we'd need the detect_ctx() callback for
> bridges.

Ok, I'll try that.

Regards,
Cristian
