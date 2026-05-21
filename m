Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA10CCD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 20:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D49010E646;
	Thu, 21 May 2026 20:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VGnzUv8I";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C5C10E646
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779394407;
 bh=G6x1g9xJdqk+zdBPwW6rPVSmR2PUbPlPZx4/m/V3gy8=;
 b=VGnzUv8IJ1A5zUwsAVRf1I4hXsJ9kgLcod3lSURZpBgtOm4rUdu9m0/r18xB9hVMcs5xP0+CG
 +GDcRrMvoDvHnho6kh5kZ7T+abTc3xdkdlVqUNHNPRB/Ex65nxJg32mDty4zAJK1qPyL+wtDpRe
 1A2Zrc+ULpJjwPEw+6xAOklmPePHvxz/npE+zTAuXEYfUnHewAw0P9MRHQI4vtut3kTXQdP87jU
 NoY0xb4huxHdF76rIPb5UpDiJyWOVqTeTCuF2xA8Q6xB8CG2Y5Lfef/vEd10jgPj4pUQw+gSCjU
 sXdY2EOI6bgRcZ3VEmv03AvXmX8dQP1yuS5u/BmsbYPQ==
X-Forward-Email-ID: 6a0f67626fd0f8c2ba150eb6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <310e7a75-62e2-463c-b471-fcaaa3acfef5@kwiboo.se>
Date: Thu, 21 May 2026 22:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/23] drm: bridge: dw_hdmi: Use delayed_work to
 debounce hotplug event
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260518180206.2480119-1-jonas@kwiboo.se>
 <20260518180206.2480119-20-jonas@kwiboo.se>
 <e584ab2b-677d-4893-95c9-7b68165633c6@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e584ab2b-677d-4893-95c9-7b68165633c6@linaro.org>
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

Hi Neil,

On 5/20/2026 11:58 AM, Neil Armstrong wrote:
> Hi,
> 
> On 5/18/26 20:01, Jonas Karlman wrote:
>> HDMI Specification Version 1.4b chapter 8.5 mentions:
>>
>>    An HDMI Sink shall not assert high voltage level on its Hot Plug
>>    Detect pin when the E-EDID is not available for reading.
>>
>>    A Source may use a high voltage level Hot Plug Detect signal to
>>    initiate the reading of E-EDID data.
>>
>>    An HDMI Sink shall indicate any change to the contents of the E-EDID
>>    by driving a low voltage level pulse on the Hot Plug Detect pin. This
>>    pulse shall be at least 100 msec.
>>
>> Use a delayed work to debounce reacting on HPD events to improve
>> handling of a HPD low voltage level pulse when a sink changes the EDID.
>>
>> The delayed work is only enabled between enable_hpd()/hpd_enable() and
>> disable_hpd()/hpd_disable() calls from core, i.e. enabled after
>> attach/bind/resume and disabled before detach/unbind/suspend.
>>
>> The 1100 msec hotplug debounce timeout was arbitrarily picked to match
>> other drivers using same const, and testing using a Raspberry Pi Monitor
>> seem to use a 200-300 msec pulse when going from standby to power on
>> state.
> 
> The logic looks ok, but I'm puzzled by the 1.1 sec debounce, which after
> plugging in a monitor will only send an irq event after 1.1s which is very long.
> 
> Since the spec says 100ms and the real worls values are more like 200-300ms,
> I would first reduce this to 500ms.

You are correct, this value was picked based on existing values used by
other drivers:

  exynos/exynos_hdmi.c:#define HOTPLUG_DEBOUNCE_MS                1100
  bridge/ti-tfp410.c:#define HOTPLUG_DEBOUNCE_MS          1100
  amd/display/amdgpu_dm/amdgpu_dm.h:#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
  rockchip/dw_hdmi_qp-rockchip.c:#define HOTPLUG_DEBOUNCE_MS              150

150 ms was too short for my test monitor (Raspberry Pi Monitor), it
does a HPD low voltage level pulse when powering on of around 200+ ms.

  [82.641903] dw_hdmi_hardirq: EVENT=plugout
  [82.841939] dw_hdmi_hardirq: EVENT=plugin

And on my LG OLED 4K TV there was typically a pulse of around 700-900 ms.
So the 1.1 seconds used by other drivers seemed like a good candidate :-)

> But as I understand the code right now, on the first HPD front the irq work
> is programmed to run after the debounce time, but if it's a pulse the irq would
> also trigger on the second HPD front and then delay again the work after the
> debounce time.

Your analysis is correct, any HPD event would keep debouncing adding 1.1
timout from each HPD irq, both plugout and plugin.

The intention was to allow for up to 1.1 seconds to pass between a
plugout and a plugin, before we treated a plugout as a full disconnect
event, and not to delay a possible connected event by 1.1 seconds.

> My understanding of a debounce was that we "ignore" the pulse by only generating
> a single irq event when the pulse is finished.

Correct, as long as the pulse was less than 1.1 seconds.

> The current code does that, we will only have a single irq event and the HPD
> will return as connected state, good. But this delays the irq event 1.1s _after_
> the end of the pulse, which I would expect the event to be send at tht debounce
> time after the start of the pulse.

Good catch and I agree, we should delay/timeout the disconnected state
longer than plugin and react on plugin almost immediately.

> Like, program the work at the beginning of the pulse, if somehow the pulse ends before
> the debounce time, send the irq event immediately, otherwise let the debounce
> work run after the debounce time which will trigger a disconnect event.
> 
> But the delay is too high, 1.1s could be a manual unplug/plug or bad connector
> with false contact on the hpd pin.
> 
> I would rather reduce this to something more realistic like 500ms or less and
> try to better handle the pulse somehow. But I don't have any idea if the scheme
> I described is doable.

We can configure different delays for plugout and plugin, I am currently
testing something like following:

  #define HOTPLUG_CONNECTED_DEBOUNCE_MS		150
  #define HOTPLUG_DISCONNECTED_DEBOUNCE_MS	500

  delay = status == connector_status_connected ?
		    HOTPLUG_CONNECTED_DEBOUNCE_MS :
		    HOTPLUG_DISCONNECTED_DEBOUNCE_MS;
  mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
		   msecs_to_jiffies(delay));

That would mean:
- at plugout we (re-)start the timer to trigger in 500ms
- at plugin we (re-)start the timer to trigger in 150ms
- whenever the timer triggers the hpd_work is started
- the hpw_work trigger normal detect() handling to determin if
  connector status (or EDID) has changed

Example during power on of a Raspberry Pi Monitor:

  [82.641903] dw_hdmi_hardirq: EVENT=plugout
  [82.648276] dw_hdmi_schedule_hpd_work(status=2)
  [82.841939] dw_hdmi_hardirq: EVENT=plugin
  [82.848211] dw_hdmi_schedule_hpd_work(status=1)
  [83.008573] dw_hdmi_hpd_work(): START
  [83.020358] dw_hdmi_bridge_detect()
  [83.034958] dw_hdmi_bridge_edid_read()
  [83.187102] [drm:update_display_info.part.0] [CONNECTOR:55:HDMI-A-1] CEA VCDB 0x4a
  [83.194471] [drm:update_display_info.part.0] [CONNECTOR:55:HDMI-A-1] HDMI: DVI dual 0, max TMDS clock 0 kHz
  [83.201755] [drm:update_display_info.part.0] [CONNECTOR:55:HDMI-A-1] ELD monitor RPI MON156
  [83.208968] [drm:update_display_info.part.0] [CONNECTOR:55:HDMI-A-1] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
  [83.216588] [drm:update_display_info.part.0] [CONNECTOR:55:HDMI-A-1] ELD size 36, SAD count 1
  [83.224445] [drm:check_connector_changed] [CONNECTOR:55:HDMI-A-1] Same epoch counter 2
  [83.231553] dw_hdmi_hpd_work(): END

Around 205ms between HPD=0 and HPD=1 and around 160ms from plugin until
delayed hpd_work starts.

And at full plugout the debounce time is around 497 ms:

  [95.125105] dw_hdmi_hardirq: EVENT=plugout
  [95.147586] dw_hdmi_schedule_hpd_work(status=2)
  [95.645277] dw_hdmi_hpd_work(): START
  [95.667741] dw_hdmi_bridge_detect()
  [95.691523] [drm:drm_edid_connector_update] [CONNECTOR:55:HDMI-A-1] EDID changed, epoch counter 3
  [95.709861] [drm:check_connector_changed] [CONNECTOR:55:HDMI-A-1] status updated from connected to disconnected
  [95.722674] [drm:check_connector_changed] [CONNECTOR:55:HDMI-A-1] Changed epoch counter 2 => 4
  [95.735173] [drm:drm_sysfs_connector_hotplug_event] [CONNECTOR:55:HDMI-A-1] generating connector hotplug event
  [95.746326] [drm:drm_fb_helper_hotplug_event]
  [95.754871] [drm:drm_client_modeset_probe]
  [95.762429] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:55:HDMI-A-1]
  [95.769758] dw_hdmi_bridge_detect()
  [95.776597] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:55:HDMI-A-1] disconnected
  [95.784389] [drm:drm_client_modeset_probe] No connectors reported connected with modes
  [95.791865] [drm:drm_client_modeset_probe] [CONNECTOR:55:HDMI-A-1] enabled? no
  [95.799426] [drm:drm_client_firmware_config.isra.0] Not using firmware configuration
  [95.807140] [drm:drm_client_modeset_probe] picking CRTCs for 1920x1080 config
  [95.818422] dw_hdmi_bridge_atomic_disable()
  [95.826412] [drm:vop2_plane_atomic_disable] Smart0-win0 disable
  [95.868341] [drm:drm_client_hotplug] fbdev: ret=0
  [95.878206] dw_hdmi_hpd_work(): END

With a much quicker reaction on plugin event maybe the 1.1 seconds could
stay to avoid having to do a full teardown, disable() + enable() cycle,
at slightly longer HPD pulses.

Or maybe it is time to re-spin an old cec-adapter debounce series [1]
that can allow for some additional time until the CEC phys addr is fully
invalidated at a longer HPD low voltage level pulse.

[1] https://lore.kernel.org/linux-media/HE1PR06MB40115700084D1D875673D60EAC9D0@HE1PR06MB4011.eurprd06.prod.outlook.com/

Regards,
Jonas

> 
> Neil
> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v7: Change to free irq before mute and clear using IH regs, also include
>>      clear of STAT0_RX_SENSE
>> v6: Change back to disable_delayed_work_sync() in hpd disable ops,
>>      Ensure HPD interrupt is masked and IRQ handler is disabled early
>>      in dw_hdmi_remove() to prevent any irq re-arming of delayed work,
>>      Drop use of suspend helper
>> v5: Change to none-sync disable_delayed_work() in hpd disable ops,
>>      Change to cancel_delayed_work_sync() in remove,
>>      Add cancel_delayed_work_sync() to new suspend helper
>> v4: Disable/mask delayed_work until enable_hpd()/hpd_enable(),
>>      Read connector status directly from HW regs in hpd_work
>> v3: New patch
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 80 +++++++++++++++++++++--
>>   1 file changed, 75 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 8afc9d240121..270db58a0e7c 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -50,6 +50,8 @@
>>   
>>   #define HDMI14_MAX_TMDSCLK	340000000
>>   
>> +#define HOTPLUG_DEBOUNCE_MS	1100
>> +
>>   static const u16 csc_coeff_default[3][4] = {
>>   	{ 0x2000, 0x0000, 0x0000, 0x0000 },
>>   	{ 0x0000, 0x2000, 0x0000, 0x0000 },
>> @@ -185,6 +187,7 @@ struct dw_hdmi {
>>   	hdmi_codec_plugged_cb plugged_cb;
>>   	struct device *codec_dev;
>>   	enum drm_connector_status last_connector_result;
>> +	struct delayed_work hpd_work;
>>   };
>>   
>>   const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
>> @@ -2517,6 +2520,20 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>>   	dw_hdmi_connector_status_update(hdmi, connector, connector->status);
>>   }
>>   
>> +static void dw_hdmi_connector_enable_hpd(struct drm_connector *connector)
>> +{
>> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
>> +
>> +	enable_delayed_work(&hdmi->hpd_work);
>> +}
>> +
>> +static void dw_hdmi_connector_disable_hpd(struct drm_connector *connector)
>> +{
>> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
>> +
>> +	disable_delayed_work_sync(&hdmi->hpd_work);
>> +}
>> +
>>   static void dw_hdmi_connector_destroy(struct drm_connector *connector)
>>   {
>>   	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
>> @@ -2538,6 +2555,8 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
>>   static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
>>   	.get_modes = dw_hdmi_connector_get_modes,
>>   	.atomic_check = dw_hdmi_connector_atomic_check,
>> +	.enable_hpd = dw_hdmi_connector_enable_hpd,
>> +	.disable_hpd = dw_hdmi_connector_disable_hpd,
>>   };
>>   
>>   static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
>> @@ -2968,6 +2987,20 @@ static const struct drm_edid *dw_hdmi_bridge_edid_read(struct drm_bridge *bridge
>>   	return dw_hdmi_edid_read(hdmi, connector);
>>   }
>>   
>> +static void dw_hdmi_bridge_hpd_enable(struct drm_bridge *bridge)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +
>> +	enable_delayed_work(&hdmi->hpd_work);
>> +}
>> +
>> +static void dw_hdmi_bridge_hpd_disable(struct drm_bridge *bridge)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +
>> +	disable_delayed_work_sync(&hdmi->hpd_work);
>> +}
>> +
>>   static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>> @@ -2981,6 +3014,8 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>>   	.mode_valid = dw_hdmi_bridge_mode_valid,
>>   	.detect = dw_hdmi_bridge_detect,
>>   	.edid_read = dw_hdmi_bridge_edid_read,
>> +	.hpd_enable = dw_hdmi_bridge_hpd_enable,
>> +	.hpd_disable = dw_hdmi_bridge_hpd_disable,
>>   };
>>   
>>   /* -----------------------------------------------------------------------------
>> @@ -3101,8 +3136,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>>   			status == connector_status_connected ?
>>   			"plugin" : "plugout");
>>   
>> -		if (hdmi->bridge.dev)
>> -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
>> +		mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
>> +				 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
>>   	}
>>   
>>   	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
>> @@ -3112,6 +3147,29 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static void dw_hdmi_hpd_work(struct work_struct *work)
>> +{
>> +	struct dw_hdmi *hdmi = container_of(work, struct dw_hdmi, hpd_work.work);
>> +	struct drm_device *dev = hdmi->bridge.dev;
>> +
>> +	if (WARN_ON(!dev))
>> +		return;
>> +
>> +	/*
>> +	 * Notify the DRM core of the HPD event using drm_helper_hpd_irq_event()
>> +	 * instead of drm_bridge_hpd_notify(). This will cause the DRM function
>> +	 * check_connector_changed() to be called, which in turn calls the
>> +	 * connector detect()/force() funcs to detect any connection status or
>> +	 * epoch changes. The bridge connector detect() func also ensures that
>> +	 * any hpd_notify() funcs are called for all bridges in the chain.
>> +	 *
>> +	 * drm_bridge_hpd_notify() shares a mutex with drm_bridge_hpd_disable(),
>> +	 * and can result in a deadlock due to the disable_delayed_work_sync()
>> +	 * call to wait on work to complete in dw_hdmi_bridge_hpd_disable().
>> +	 */
>> +	drm_helper_hpd_irq_event(dev);
>> +}
>> +
>>   static const struct dw_hdmi_phy_data dw_hdmi_phys[] = {
>>   	{
>>   		.type = DW_HDMI_PHY_DWC_HDMI_TX_PHY,
>> @@ -3396,6 +3454,9 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>>   		goto err_res;
>>   	}
>>   
>> +	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_hpd_work);
>> +	disable_delayed_work(&hdmi->hpd_work);
>> +
>>   	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
>>   					dw_hdmi_irq, IRQF_SHARED,
>>   					dev_name(dev), hdmi);
>> @@ -3532,6 +3593,18 @@ EXPORT_SYMBOL_GPL(dw_hdmi_probe);
>>   
>>   void dw_hdmi_remove(struct dw_hdmi *hdmi)
>>   {
>> +	struct platform_device *pdev = to_platform_device(hdmi->dev);
>> +	int irq = platform_get_irq(pdev, 0);
>> +
>> +	/* Free, mute and clear phy interrupts */
>> +	devm_free_irq(hdmi->dev, irq, hdmi);
>> +	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
>> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
>> +		    HDMI_IH_PHY_STAT0);
>> +
>> +	/* Cancel any pending hot plug work */
>> +	cancel_delayed_work_sync(&hdmi->hpd_work);
>> +
>>   	drm_bridge_remove(&hdmi->bridge);
>>   
>>   	if (hdmi->audio && !IS_ERR(hdmi->audio))
>> @@ -3539,9 +3612,6 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
>>   	if (!IS_ERR(hdmi->cec))
>>   		platform_device_unregister(hdmi->cec);
>>   
>> -	/* Disable all interrupts */
>> -	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
>> -
>>   	if (hdmi->i2c)
>>   		i2c_del_adapter(&hdmi->i2c->adap);
>>   	else
> 

