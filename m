Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E4C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0289110E484;
	Tue, 18 Aug 2026 02:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dFywGsdB";
	dkim-atps=neutral
Received: from mail-m9373.xmail.ntesmail.com (mail-m9373.xmail.ntesmail.com
 [103.126.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B148410E484
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:05:37 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4a55d3d6b;
 Tue, 18 Aug 2026 10:05:32 +0800 (GMT+08:00)
Message-ID: <364f223e-15c6-44c4-a909-134754cfd0e1@rock-chips.com>
Date: Tue, 18 Aug 2026 10:05:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/bridge: allow hpd_notify() to suppress connector
 hotplug events
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa0129de44003a7kunmc0fc8708438ed0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSktKVh9PTxlCTx4ZSExIGVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=dFywGsdBtvZRVJemi0N+HjQrvA6VMmVIb18ZLdmsL3Ic4tBAFCATiNU/Da+GZgXDhVSIz8U03oEwrpR2JOwTUMa86YCerIdWVCjLHaFxL6qKBFk7HX5dLjWzoHtrTg669GS8iIuCxS7iYK64SHSLCH8Bhi513UXjUValaG6NxLo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=QuPkMCmr0GH+tbEEJBOzYqXRVTh/Jjq7Xd3/Zg44YS0=;
 h=date:mime-version:subject:message-id:from;
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

Hello Yongxing,

On 6/29/2026 10:48 PM, Yongxing Mou wrote:
> The bridge connector framework currently invokes all bridge
> hpd_notify() callbacks and unconditionally emits a connector hotplug
> event afterwards.
> 
> However, not every HPD notification requires a userspace hotplug event.
> 
> In particular, DP MST bridges may use hpd_notify() to propagate HPD and
> IRQ notifications through the bridge chain while the actual hotplug
> handling is performed by the DRM DP MST core. Connector creation,
> removal and userspace hotplug events are already managed by the MST
> topology framework.
> 
> Allow hpd_notify() implementations to suppress the bridge connector
> hotplug event by introducing a bool *send_hotplug parameter. Drivers
> can clear this flag when HPD processing should not result in a
> connector hotplug notification.
> 
> A NULL pointer indicates that hotplug suppression is not supported by
> the caller, such as the connector detect polling path.
>

Should we add an API to distinguish between regular HPD events and
the IRQ-only notifications you mentioned?

I've recently seen similar approaches. For example, this patch[0] adds
handling for internal events, which I think is somewhat similar to the
IRQ-only notification here.

[0]: https://lore.kernel.org/all/20260806-synopsys-dw-dp-improvements-v11-11-0d508505f383@collabora.com/

> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
>  drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
>  drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
>  include/drm/drm_bridge.h                       |  3 ++-
>  7 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 8cb17bd0e238..42e1cadcd3fb 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -430,7 +430,8 @@ static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *brid
>  static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,
>  					struct drm_connector *connector,
>  					enum drm_connector_status status,
> -					enum drm_connector_status_extra extra_status)
> +					enum drm_connector_status_extra extra_status,
> +					bool *send_hotplug)
>  {
>  	const struct drm_edid *drm_edid;
>  
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 8f7075fd2aa5..5edca47a025f 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -142,7 +142,8 @@ struct drm_bridge_connector {
>  
>  static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
>  					    enum drm_connector_status status,
> -					    enum drm_connector_status_extra extra_status)
> +					    enum drm_connector_status_extra extra_status,
> +					    bool *send_hotplug)
>  {
>  	struct drm_bridge_connector *bridge_connector =
>  		to_drm_bridge_connector(connector);
> @@ -150,13 +151,14 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
>  	/* Notify all bridges in the pipeline of hotplug events. */
>  	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
>  		if (bridge->funcs->hpd_notify)
> -			bridge->funcs->hpd_notify(bridge, connector, status, extra_status);
> +			bridge->funcs->hpd_notify(bridge, connector, status,
> +						  extra_status, send_hotplug);
>  	}
>  }
>  
>  static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bridge_connector,
> -					    enum drm_connector_status status,
> -					    enum drm_connector_status_extra extra_status)
> +	enum drm_connector_status status,
> +	enum drm_connector_status_extra extra_status)
>  {
>  	struct drm_connector *connector = &drm_bridge_connector->base;
>  	struct drm_device *dev = connector->dev;
> @@ -165,7 +167,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>  	connector->status = status;
>  	mutex_unlock(&dev->mode_config.mutex);
>  
> -	drm_bridge_connector_hpd_notify(connector, status, extra_status);
> +	drm_bridge_connector_hpd_notify(connector, status, extra_status, NULL);
>  
>  	drm_kms_helper_connector_hotplug_event(connector);
>  }
> @@ -227,7 +229,8 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
>  		if (hdmi)
>  			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
>  
> -		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
> +		drm_bridge_connector_hpd_notify(connector, status,
> +						DRM_CONNECTOR_NO_EXTRA_STATUS, NULL);
>  	} else {
>  		switch (connector->connector_type) {
>  		case DRM_MODE_CONNECTOR_DPI:
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 4aecf0ffcf75..a67e7b365c5b 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -324,7 +324,8 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
>  static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
>  					  struct drm_connector *connector,
>  					  enum drm_connector_status status,
> -					  enum drm_connector_status_extra extra_status)
> +					  enum drm_connector_status_extra extra_status,
> +					  bool *send_hotplug)
>  {
>  	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index fcfee26f0078..6835c68fe510 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1763,7 +1763,8 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge)
>  void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  			      struct drm_connector *connector,
>  			      enum drm_connector_status status,
> -			      enum drm_connector_status_extra extra_status)
> +			      enum drm_connector_status_extra extra_status,
> +			      bool *send_hotplug)
>  {
>  	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
>  	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
> index f6b96c27408a..07ddcd055962 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.h
> @@ -32,6 +32,7 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
>  void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  			      struct drm_connector *connector,
>  			      enum drm_connector_status status,
> -			      enum drm_connector_status_extra extra_status);
> +			      enum drm_connector_status_extra extra_status,
> +			      bool *send_hotplug);
>  
>  #endif /* _DP_DRM_H_ */
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> index d02d432abde4..ad659cef16f5 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -430,7 +430,8 @@ static void hdmi4_bridge_disable(struct drm_bridge *bridge,
>  static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
>  				    struct drm_connector *connector,
>  				    enum drm_connector_status status,
> -				    enum drm_connector_status_extra extra_status)
> +				    enum drm_connector_status_extra extra_status,
> +				    bool *send_hotplug)
>  {
>  	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
>  
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 9c4c88024cc5..e6de665ce8f6 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -616,7 +616,8 @@ struct drm_bridge_funcs {
>  	void (*hpd_notify)(struct drm_bridge *bridge,
>  			   struct drm_connector *connector,
>  			   enum drm_connector_status status,
> -			   enum drm_connector_status_extra extra_status);
> +			   enum drm_connector_status_extra extra_status,
> +			   bool *send_hotplug);
>  
>  	/**
>  	 * @hpd_enable:
> 

-- 
Best, 
Chaoyi
