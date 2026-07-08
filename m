Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503CDC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A184A10F0C9;
	Wed,  8 Jul 2026 11:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="h9xrOKfA";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022FB10F0C9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783509672;
 bh=GEwFILC+0xXIT2PjFETG0vxtNdBCpa2gjlVADBYSpnU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h9xrOKfAASK2CG1IYIOQK0cI/yaIkZ7MqAtRT/ZgVpNtfWvMYspviU8lejmf14sFV
 xZsaukwZgLzwhm/J0LcUa445eu9S8iTjwjZB+uuUbaH0GNo/dOmrGlsTphchH9xaXg
 y3AguVlLBqSmiJbpbHH0QQZRmL+qUc8WO3D30jzVzm5ibUdTEJ+eQLU3yZJ/XRkUgv
 5bgi6DQ7yaF2ErB0Jn3TQSM0RRMLTZmx551D7Zwxy3+EUjnJTtl0rVai7fTdm9KJqA
 5mChSL7WtADE9YIIDakoYDQEFXqluLICD0PH9U77FWQZwU8NxB/kE4pD8HGK9tAUJt
 EYoMVNms/ClpA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E77E17E0713;
 Wed, 08 Jul 2026 13:21:11 +0200 (CEST)
Message-ID: <05de7187-a7e9-4d69-8c65-cdbc30d21d33@collabora.com>
Date: Wed, 8 Jul 2026 14:21:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/39] drm/display: hdmi-state-helper: Sync SCDC state
 on hotplug
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-10-d79890d00b6a@collabora.com>
 <20260707-unique-carmine-cheetah-af2cb8@penduick>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260707-unique-carmine-cheetah-af2cb8@penduick>
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

Hi Maxime,

On 7/7/26 2:31 PM, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jul 02, 2026 at 05:46:23PM +0300, Cristian Ciocaltea wrote:
>> drm_atomic_helper_connector_hdmi_hotplug() does not currently
>> synchronize SCDC status on hotplug events, leaving the scrambler state
>> potentially inconsistent after (re)connect.
>>
>> Hook drm_connector_hdmi_sync_scdc() into both the connect and disconnect
>> paths, replacing the existing TODOs around missing scrambler handling.
>>
>> SCDC synchronization may require a CRTC reset, which in turn needs a
>> modeset acquire context for correct locking.  Therefore, extend
>> drm_atomic_helper_connector_hdmi_hotplug() and
>> drm_atomic_helper_connector_hdmi_update() to take a
>> drm_modeset_acquire_ctx argument.  Additionally, change their return
>> type from void to int, allowing propagation of errors, such as -EDEADLK
>> from lock contention.
>>
>> Update existing callers to pass NULL for the acquire context, preserving
>> current behavior.
> 
> You should have two patches here: one to change the prototype of the
> helpers, and one to add the call to drm_connector_hdmi_sync_scdc

Ack.

>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_bridge_connector.c  |  3 ++-
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 28 +++++++++++++++++--------
>>  drivers/gpu/drm/vc4/vc4_hdmi.c                  |  2 +-
>>  include/drm/display/drm_hdmi_state_helper.h     |  6 ++++--
>>  4 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
>> index 796069dbf1a1..46104506fe32 100644
>> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
>> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
>> @@ -221,7 +221,8 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
>>  		status = detect->funcs->detect(detect, connector);
>>  
>>  		if (hdmi)
>> -			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
>> +			drm_atomic_helper_connector_hdmi_hotplug(connector, status,
>> +								 NULL);
>>  
>>  		drm_bridge_connector_hpd_notify(connector, status);
>>  	} else {
> 
> We should move this one to detect_ctx to get the ctx passed and avoid
> passing NULL here.

We do this in patch 15.  Should I try to reorder?

>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index db76699093e8..69ccfbf123fe 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -1198,18 +1198,20 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
>>  }
>>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
>>  
>> -static void
>> +static int
>>  drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
>> -					enum drm_connector_status status)
>> +					enum drm_connector_status status,
>> +					struct drm_modeset_acquire_ctx *ctx)
> 
> detect_ctx has the context first, I think we should use that convention
> here too.

Ack.

>>  {
>>  	const struct drm_edid *drm_edid;
>> +	int ret = 0;
>>  
>>  	if (status == connector_status_disconnected) {
>> -		// TODO: also handle scramber, HDMI sink disconnected.
>> +		ret = drm_connector_hdmi_sync_scdc(connector, false, ctx);
>>  		drm_connector_hdmi_audio_plugged_notify(connector, false);
>>  		drm_edid_connector_update(connector, NULL);
>>  		drm_connector_cec_phys_addr_invalidate(connector);
>> -		return;
>> +		return ret;
>>  	}
>>  
>>  	if (connector->hdmi.funcs->read_edid)
>> @@ -1222,24 +1224,32 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
>>  	drm_edid_free(drm_edid);
>>  
>>  	if (status == connector_status_connected) {
>> -		// TODO: also handle scramber, HDMI sink is now connected.
>> +		ret = drm_connector_hdmi_sync_scdc(connector, true, ctx);
>>  		drm_connector_hdmi_audio_plugged_notify(connector, true);
>>  		drm_connector_cec_phys_addr_set(connector);
>>  	}
>> +
>> +	return ret;
>>  }
>>  
>>  /**
>>   * drm_atomic_helper_connector_hdmi_hotplug - Handle the hotplug event for the HDMI connector
>>   * @connector: A pointer to the HDMI connector
>>   * @status: Connection status
>> + * @ctx: Lock acquisition context to be used for resetting CRTC
>>   *
>>   * This function should be called as a part of the .detect() / .detect_ctx()
>>   * callbacks for all status changes.
>> + *
>> + * Returns:
>> + * Zero on success, error code on failure.
>> + * If @ctx is set, it might also return -EDEADLK.
>>   */
>> -void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
>> -					      enum drm_connector_status status)
>> +int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
>> +					     enum drm_connector_status status,
>> +					     struct drm_modeset_acquire_ctx *ctx)
>>  {
>> -	drm_atomic_helper_connector_hdmi_update(connector, status);
>> +	return drm_atomic_helper_connector_hdmi_update(connector, status, ctx);
>>  }
>>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
>>  
>> @@ -1254,6 +1264,6 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
>>   */
>>  void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
>>  {
>> -	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
>> +	drm_atomic_helper_connector_hdmi_update(connector, connector->status, NULL);
>>  }
> 
> We should create a new context here.

Ack.

> 
>>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> index 74dce4be0c00..e165f604939b 100644
>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>> @@ -375,7 +375,7 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
>>  	 * the lock for now.
>>  	 */
>>  
>> -	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
>> +	drm_atomic_helper_connector_hdmi_hotplug(connector, status, NULL);
> 
> vc4_hdmi_handle_hotplug has the context passed as an argument, we should reuse it.

The vc4 conversion (patch 31) removes vc4_hdmi_handle_hotplug() and calls
drm_atomic_helper_connector_hdmi_hotplug() directly in
vc4_hdmi_connector_detect_ctx().  

I used NULL here to ensure there wouldn't be any race between the two separate
SCDC state management implementations, but that can't happen at this point
anyway (hdmi->scrambler_enabled isn't set by the driver).  So we can pass the
context if you prefer.

Thanks,
Cristian
