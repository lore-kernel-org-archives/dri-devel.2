Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F8CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0662810E363;
	Tue, 28 Apr 2026 19:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sthPP9Di";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952F310E363
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1777404871;
 bh=tyuMmKgL6oRWTBJMy9sHFgkkcCZP0KsDIP4M04imiag=;
 b=sthPP9DiTNCoFl/eQ24MW/+ikwoABVzC1oG8cZBBn81aWpFBEu9l8poBjBykH2vxxtUre19yP
 0K6aFK49EyUQFepmxR/3drEyH8U5j1Jk43F+kVwRaxnmKJL/Yg6/oBAJQgEaZVxLrGsVHHCyYAm
 W2nbJs3MTry98V86mUAZpMERAkK2i/sKGwb6CCwsVZKItwHe1s2/5KxhJp0gfDzHti3GJ2RnFG0
 M/n23XoyrH6BCMGCr0/+kC1Xm/ohxmVQFj+Ntis8grEWGJnKEffboPFGUYGuZAA9sixRNF7WLTm
 ybZMXWDPUOkQUjdfcbjwo0fRQslqRl6jMU1sXx1KyyOA==
X-Forward-Email-ID: 69f10bc5a2c58f47e2133329
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.7.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9b4a676e-cf8f-4708-b580-8140a2e7a805@kwiboo.se>
Date: Tue, 28 Apr 2026 21:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-10-jonas@kwiboo.se>
 <go5i5iiwra426hydnvc5thhgtknv3fa7ti35q3et6frroxag2n@tfbfiyjmtzkk>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <go5i5iiwra426hydnvc5thhgtknv3fa7ti35q3et6frroxag2n@tfbfiyjmtzkk>
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

On 4/28/2026 2:38 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 06:52:55PM +0000, Jonas Karlman wrote:
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
> 
> Nit: please consider this for the followup cleanup. The
> drm_helper_hpd_irq_event() is not very effective: we already know which
> bridge (and thus connector) caused the HPD event.
> 
> Moreover, the call should be redundant as drm_bridge_hpd_notify will
> call the registered callback, which normally would be
> drm_bridge_connector_hpd_cb(). Internally, this function calls
> drm_kms_helper_connector_hotplug_event().

I disagree in part, based on my testing, without a call to
drm_helper_hpd_irq_event() or drm_connector_helper_hpd_irq_event() the
internal check_connector_changed() never seem to be reached to detect
any connector->status and/or connector->epoch_counter changes.

In my ongoing work to convert dw-hdmi to become a hdmi bridge, I have 
actually done the opposite to what you suggest here and instead fully
dropped the call to drm_bridge_hpd_notify() made here.

drm_bridge_connector_detect() calls drm_bridge_connector_hpd_notify()
so any bridges should already be notified as part of any internal
check_connector_changed() handling.

Maybe something like following could be an option:

	changed = drm_connector_helper_hpd_irq_event(connector);
	if (changed)
		drm_bridge_hpd_notify(bridge, connector->status);

I will likely keep this as-is to keep existing behavior in a v4, as this
patch was just about de-bouncing the existing calls being made at HPD.

Regards,
Jonas

> 
>> +		drm_bridge_hpd_notify(&hdmi->bridge, hdmi->last_connector_result);
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
>> -- 
>> 2.53.0
>>
> 

