Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE5CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85B810F56C;
	Fri, 22 May 2026 11:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pQIbBUKf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95EC10F56C
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779450166;
 bh=eEnxhVP7h9oNVDGsBLFcwZgYtanJdNFLIjNzXRvxveg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pQIbBUKfLUUcBeUIyJLFkWg85GrWbe3+dbaliKFQTozycasoD6CoVrro0PxJL8Rse
 pKiRSM/4ODqb/IYIBpQIT/uar68Rg3pWgbECr1h+oNU+gYPzfLvHxiQimyUkfM28Cq
 FgjsLmQE9E6g9aC1SHo0NN1rrFUr3WWwuzVgVeh57CRfOtvPDmdUonIolcuxwqEmNy
 nznWdddZfPNEZl7JQ6uwKqOxCR5JZskhIc9Hh/6dew0r9X9niUqiDhIoWY6m0ir+l9
 JD8ycgKgs+5IGbNuHbCo5bulYhm4FATTK2jpvwKE/9R1CY86LMYuMeRZq04gxhZ5eu
 bbkR3rq9UMdzw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B903917E0550;
 Fri, 22 May 2026 13:42:45 +0200 (CEST)
Message-ID: <64a21a69-d99b-4ae3-9477-dd0f6b37f689@collabora.com>
Date: Fri, 22 May 2026 14:42:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/22] drm/display: scdc_helper: Add HDMI 2.0
 scrambling management helpers
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Daniel Stone <daniels@collabora.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
 <20260520-dw-hdmi-qp-scramb-v6-4-24b74603b782@collabora.com>
 <20260521-chestnut-harrier-of-enhancement-2bcfa2@penduick>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260521-chestnut-harrier-of-enhancement-2bcfa2@penduick>
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

On 5/21/26 11:10 AM, Maxime Ripard wrote:
> On Wed, May 20, 2026 at 09:38:15PM +0300, Cristian Ciocaltea wrote:
>> Add drm_scdc_start_scrambling(), drm_scdc_stop_scrambling() and
>> drm_scdc_sync_status() helpers to manage the full lifecycle of HDMI 2.0
>> SCDC scrambling on both source and sink sides.
>>
>> drm_scdc_start_scrambling() configures SCDC scrambling and high TMDS
>> clock ratio and starts a periodic work item that monitors the sink's
>> SCDC scrambling status, retrying setup when the sink loses state.
>>
>> drm_scdc_stop_scrambling() tears down scrambling on both sides and
>> cancels the monitoring work.
>>
>> drm_scdc_sync_status() triggers a CRTC reset on reconnection to restore
>> SCDC state lost during sink disconnects within an active display
>> pipeline.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_scdc_helper.c | 235 +++++++++++++++++++++++++++++-
>>  include/drm/display/drm_scdc_helper.h     |   6 +-
>>  2 files changed, 236 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
>> index cb6632346aad..5bacb886d373 100644
>> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
>> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
>> @@ -21,16 +21,22 @@
>>   * DEALINGS IN THE SOFTWARE.
>>   */
>>  
>> +#include <linux/delay.h>
>>  #include <linux/export.h>
>>  #include <linux/i2c.h>
>> +#include <linux/minmax.h>
>>  #include <linux/slab.h>
>> -#include <linux/delay.h>
>>  
>> -#include <drm/display/drm_scdc_helper.h>
>> +#include <drm/drm_atomic.h>
>> +#include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_bridge_helper.h>
>>  #include <drm/drm_connector.h>
>> +#include <drm/drm_crtc.h>
>>  #include <drm/drm_device.h>
>>  #include <drm/drm_print.h>
>>  
>> +#include <drm/display/drm_scdc_helper.h>
>> +
>>  /**
>>   * DOC: scdc helpers
>>   *
>> @@ -50,10 +56,14 @@
>>   * has to track the connector status changes using interrupts and
>>   * restore the SCDC status. The typical solution for this is to trigger an
>>   * empty modeset in drm_connector_helper_funcs.detect_ctx(), like what vc4 does
>> - * in vc4_hdmi_reset_link().
>> + * in vc4_hdmi_reset_link(). Alternatively, use the HDMI connector framework
>> + * which ensures drm_scdc_sync_status() is called in the context of
>> + * drm_atomic_helper_connector_hdmi_hotplug_ctx().
>>   */
>>  
>> -#define SCDC_I2C_SLAVE_ADDRESS 0x54
>> +#define SCDC_I2C_SLAVE_ADDRESS		0x54
>> +#define SCDC_MAX_SOURCE_VERSION		0x1
>> +#define SCDC_STATUS_POLL_DELAY_MS	3000
>>  
>>  #define drm_scdc_dbg(connector, fmt, ...)					\
>>  	drm_dbg_kms((connector)->dev, "[CONNECTOR:%d:%s] " fmt,			\
>> @@ -270,3 +280,220 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
>>  	return true;
>>  }
>>  EXPORT_SYMBOL(drm_scdc_set_high_tmds_clock_ratio);
>> +
>> +static int drm_scdc_setup_scrambler(struct drm_connector *connector)
>> +{
>> +	bool done;
>> +
>> +	done = drm_scdc_set_high_tmds_clock_ratio(connector, true);
>> +	if (!done)
>> +		return -EIO;
>> +
>> +	done = drm_scdc_set_scrambling(connector, true);
>> +	if (!done)
>> +		return -EIO;
>> +
>> +	schedule_delayed_work(&connector->hdmi.scdc_work,
>> +			      msecs_to_jiffies(SCDC_STATUS_POLL_DELAY_MS));
>> +	return 0;
>> +}
> 
> There's a very tight deadline in the spec to enable the scrambler
> relative to the video. Debouncing (I assume?) for three seconds break
> it. Drivers might not be able to do better, but it's really not
> something we should entertain at the framework level and we should call
> the callback straight-away.

In drm_scdc_start_scrambling() we call this function directly, the callback is
only meant to retry the call if the sink didn't set the scrambling for whatever
reason.

Or do you mean we shouldn't wait that long before retrying? vc4 uses 1s, I got
some mixed results in a few occasions and experimented with increased values,
but I'll revert or we can adjust to whatever you think it'd be more sensible.

>> +static void drm_scdc_monitor_scrambler(struct drm_connector *connector)
>> +{
>> +	if (READ_ONCE(connector->hdmi.scrambler_enabled) &&
>> +	    !drm_scdc_get_scrambling_status(connector))
>> +		drm_scdc_setup_scrambler(connector);
>> +}
>> +
>> +static int drm_scdc_reset_crtc(struct drm_connector *connector,
>> +			       struct drm_modeset_acquire_ctx *ctx)
>> +{
>> +	struct drm_crtc *crtc;
>> +	u8 config;
>> +	int ret;
>> +
>> +	if (!ctx || !connector->state)
>> +		return 0;
>> +
>> +	crtc = connector->state->crtc;
>> +	if (!crtc || !crtc->state || !crtc->state->active)
>> +		return 0;
>> +
>> +	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
>> +	if (ret) {
>> +		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if ((config & SCDC_SCRAMBLING_ENABLE) &&
>> +	    (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40))
>> +		return 0;
>> +
>> +	/*
>> +	 * Reset the CRTC to suspend TMDS transmission, conforming to HDMI 2.0
>> +	 * spec which requires scrambled data not to be sent before the sink is
>> +	 * configured, and TMDS clock to be suspended while changing the clock
>> +	 * ratio.  The disable/re-enable cycle triggered by the reset should
>> +	 * call drm_scdc_start_scrambling() during re-enable, properly
>> +	 * configuring the sink before data transmission resumes.
>> +	 */
>> +
>> +	drm_scdc_dbg(connector, "Resetting CRTC to restore SCDC status\n");
>> +
>> +	ret = drm_atomic_helper_reset_crtc(crtc, ctx);
>> +	if (ret && ret != -EDEADLOCK)
>> +		drm_scdc_dbg(connector, "Failed to reset CRTC: %d\n", ret);
>> +
>> +	return ret;
>> +}
> 
> locking is a bit more involved than that, I'd suggest to take
> vc4_hdmi_reset_link() and turn it into a helper.

The current non-NULL ctx call chain goes through drm_helper_probe_detect_ctx()
-> .detect_ctx -> ... -> drm_scdc_sync_status() -> drm_scdc_reset_crtc(), and
the connection mutex is already held by drm_helper_probe_detect() in that path. 

I'll make the helper safe under any caller by taking the connection_mutex via
the supplied ctx, since re-acquiring it with the same context when it is already
held should be a no-op.  Moreover, the racy crtc->state->active early out could
be dropped: when the CRTC is inactive, drm_atomic_helper_reset_crtc() should
result in a no-op commit anyway, so the check is at best an optimisation. 
This mirrors what drm_bridge_helper_reset_crtc() does.

>> +/**
>> + * drm_scdc_start_scrambling - activate scrambling and monitor SCDC status
>> + * @connector: connector
>> + *
>> + * Enables scrambling and high TMDS clock ratio on both source and sink sides.
>> + * Additionally, use a delayed work item to monitor the scrambling status on
>> + * the sink side and retry the operation, as some displays refuse to set the
>> + * scrambling bit right away.
>> + *
>> + * Returns:
>> + * Zero if scrambling is set successfully, an error code otherwise.
>> + */
>> +int drm_scdc_start_scrambling(struct drm_connector *connector)
>> +{
>> +	struct drm_display_info *info = &connector->display_info;
>> +	struct drm_connector_hdmi *hdmi = &connector->hdmi;
>> +	int ret;
>> +	u8 ver;
>> +
>> +	if (!hdmi->funcs ||
>> +	    !hdmi->funcs->scrambler_src_enable ||
>> +	    !hdmi->funcs->scrambler_src_disable) {
>> +		drm_scdc_dbg(connector, "Function not implemented, bailing.\n");
>> +		return -EINVAL;
>> +	}
> 
> This case shouldn't be a thing. The driver must not probe if it's not set.

When advertising DRM_BRIDGE_OP_HDMI_SCRAMBLER, drm_bridge_connector_init() will
fail if the scrambler hooks are not provided.  However, the check would be still
useful if one missed to set DRM_BRIDGE_OP_HDMI_SCRAMBLER before adding the
bridge.  I'll try to also handle non-bridge usecases - pls see the proposal
below.

>> +	if (!info->is_hdmi ||
>> +	    !info->hdmi.scdc.supported ||
>> +	    !info->hdmi.scdc.scrambling.supported) {
>> +		drm_scdc_dbg(connector, "Sink doesn't support scrambling.\n");
>> +		return -EINVAL;
>> +	}
> 
> You should also compute whether we actually need to enable the scrambler
> here, based on the mode, format and bpc.

I'm thinking to mirror the existing supported_formats / ycbcr_420_allowed
plumbing:

- Add a 'scrambling_supported' flag to struct drm_connector_hdmi and let
  drm_bridge_connector_init() to propagates it from the HDMI bridge before
  calling drmm_connector_hdmi_init().

- drmm_connector_hdmi_init() validates that the capability is consistent with
  the provided callbacks: when scrambling_supported is true, both
  scrambler_src_enable() and scrambler_src_disable() must be provided.

- Add a 'scrambling_needed' flag to struct drm_connector_hdmi_state to be set by
  hdmi_compute_clock() based on the TMDS character rate and the source/sink
  scrambling capabilities.

- Ensure hdmi_clock_valid() rejects modes having TMDS character rate exceeding
  340 MHz when either the source or the sink lacks the required SCDC scrambling
  capability.

> I'd also like to see what a !bridge user of this would look like. The
> vc4 driver has all the infrastructure you need already, so converting it
> to it would be great.

Sure, will do.  I've just ordered a RPI5 board, so I should be able to properly
validate this.

Thanks,
Cristian
