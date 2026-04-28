Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1486CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 22:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB0D10EC15;
	Tue, 28 Apr 2026 22:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Kp+CYy+m";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342E810EC15
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1777414336;
 bh=4Wn6FNQkWVZhm1Jo6+p0qU6roeRRL+Rp43SxbUMbzBo=;
 b=Kp+CYy+mFm9a6JNTFyYfr1qSHs7l403knfv2ObqDEWt9FJiIBB02MxbURx7hzol9U/5f9wbpA
 tYzM4I0B95zh/gTcFuQlvCSQ2C63KuexXFUbkBW3wIQPaf5vya1Swq9jW8UFjAgzcqpFGOODRm9
 oGegdSpGuhGEqWbcNQqxIDTe74tWCnJl2kOY5ZVOmQufYV2F/9fBRwz1b5WPiU8DG7hqQ2IxfXF
 GHIgmzuD7uHpRV3rPyEnCCyvOjiTqKnkn7iZvt/s0f0h/tpx6zEVntBfSjOdSWQKJrRoTMzUETT
 aVAsenfM8Hld8MK6rBvBFbfQ5KorifkNUsmSQyMWCZTQ==
X-Forward-Email-ID: 69f130bf1c18ffbd317efb1a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.7.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <76999c96-3e3e-40f2-923e-75a30abaf5db@kwiboo.se>
Date: Wed, 29 Apr 2026 00:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-10-jonas@kwiboo.se>
 <y1d99UBuRDyCACvs45dokA@collabora.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <y1d99UBuRDyCACvs45dokA@collabora.com>
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

Hi Nicolas,

On 4/27/2026 8:27 PM, Nicolas Frattaroli wrote:
> On Friday, 3 April 2026 20:52:55 Central European Summer Time Jonas Karlman wrote:
>> HDMI Specification Version 1.4b chapter 8.5 mentions:
>>
>>   An HDMI Sink shall not assert high voltage level on its Hot Plug
>>   Detect pin when the E-EDID is not available for reading.
>>
>>   A Source may use a high voltage level Hot Plug Detect signal to
>>   initiate the reading of E-EDID data.
>>
>>   An HDMI Sink shall indicate any change to the contents of the E-EDID
>>   by driving a low voltage level pulse on the Hot Plug Detect pin. This
>>   pulse shall be at least 100 msec.
>>
>> Use a work queue to debounce reacting on HPD events to better handle a
>> HPD low voltage level pulse when a sink changes the EDID.
>>
>> The 1100 msec hotplug debounce timeout was arbitrarily picked to match
>> other drivers using same const, and testing using a Raspberry Pi Monitor
>> seem to use a 200-300 msec pulse when going from standby to power on
>> state.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v3: New patch
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index f3f8144ae98e..4d079b689b3b 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -51,6 +51,8 @@
>>  
>>  #define HDMI14_MAX_TMDSCLK	340000000
>>  
>> +#define HOTPLUG_DEBOUNCE_MS	1100
>> +
>>  static const u16 csc_coeff_default[3][4] = {
>>  	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>>  	{ 0x0000, 0x2000, 0x0000, 0x0000 },
>> @@ -192,6 +194,7 @@ struct dw_hdmi {
>>  	hdmi_codec_plugged_cb plugged_cb;
>>  	struct device *codec_dev;
>>  	enum drm_connector_status last_connector_result;
>> +	struct delayed_work hpd_work;
>>  };
>>  
>>  const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
>> @@ -2528,6 +2531,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>>  
>>  	mutex_lock(&hdmi->mutex);
>>  	hdmi->force = connector->force;
>> +	hdmi->last_connector_result = connector->status;
>>  	dw_hdmi_update_phy_mask(hdmi);
>>  	mutex_unlock(&hdmi->mutex);
>>  }
>> @@ -3046,6 +3050,16 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>>  }
>>  EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
>>  
>> +static void dw_hdmi_hpd_work(struct work_struct *work)
>> +{
>> +	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
>> +
>> +	if (hdmi->bridge.dev) {
>> +		drm_helper_hpd_irq_event(hdmi->bridge.dev);
>> +		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
> 
> I think you'll want to `mutex_lock(&hdmi->mutex);` (or better yet,
> `guard(mutex)(&hdmi->mutex)` or `scoped_guard(mutex, &hdmi->mutex) {`)
> here before reading last_connector_result, otherwise you'll have a
> data race with any writers.

Thanks, I will adjust to something like that in a v4.

With the first call to drm_helper_hpd_irq_event() the dw_hdmi_detect()
that updates the last_connector_result value should have been called.
So by the time drm_bridge_hpd_notify() is called we should have the
latest connector->status value in last_connector_result.

Ideally I would like to fully drop the drm_bridge_hpd_notify() call here
and instead only call drm_connector_helper_hpd_irq_event() to detect any
connector changes due to HPD and/or EDID changes. Something to look
closer at in a future series :-)

Regards,
Jonas

> 
>> +	}
>> +}
>> +
>>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>>  {
>>  	struct dw_hdmi *hdmi = dev_id;
>> @@ -3097,10 +3111,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>>  			status == connector_status_connected ?
>>  			"plugin" : "plugout");
>>  
>> -		if (hdmi->bridge.dev) {
>> -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
>> -			drm_bridge_hpd_notify(&hdmi->bridge, status);
>> -		}
>> +		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
>> +				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
>>  	}
>>  
>>  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
>> @@ -3420,6 +3432,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>>  		goto err_res;
>>  	}
>>  
>> +	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
>> +
>>  	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
>>  					dw_hdmi_irq, IRQF_SHARED,
>>  					dev_name(dev), hdmi);
>> @@ -3552,6 +3566,8 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
>>  
>>  void dw_hdmi_remove(struct dw_hdmi *hdmi)
>>  {
>> +	disable_delayed_work_sync(&hdmi->hpd_work);
>> +
>>  	drm_bridge_remove(&hdmi->bridge);
>>  
>>  	if (hdmi->audio && !IS_ERR(hdmi->audio))
>>
> 
> Kind regards,
> Nicolas Frattaroli
> 
> 

